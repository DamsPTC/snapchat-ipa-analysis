# Nettoyage des ajouts séparables

**Révision historique avec spoof conservé.** La demande ultérieure de suppression
complète est traitée dans [native-baseline.md](native-baseline.md). L’IPA livrée
sous le même nom a depuis été remplacée par cette base sans injections ; le hash
ci-dessous identifie uniquement l’ancienne révision.

Produit : `Snapchat_Core_nettoyee_unsigned.ipa`, reconstruit le 27 septembre 2026
depuis l’archive source exacte, puis corrigé par la v3 et la recette
`tools/cleanup/recipe.json`. Aucun binaire de l’IPA n’a été lancé sur un appareil
ou autorisé à contacter un service pendant ce travail.

## Résultat

| Élément | Traitement |
| --- | --- |
| `SKEngine.dylib` | Module séparé d’annonces/abonnement SideKit retiré ; son initialisateur était déjà un `RET` dans la source. |
| Chargement de SKEngine dans `Snapchat` | Dernier `LC_LOAD_WEAK_DYLIB` retiré ; aucun import dyld ni symbole indéfini ne référence son ordinal 115. |
| `CydiaSubstrate.framework` | Trois fichiers retirés ; aucune dépendance de chargement des Mach-O conservés, aucun import MSHook de SCRT. SCRT utilise ses propres routines de rebinding. |
| `optool/` | 37 fichiers d’outillage de packaging retirés. |
| Ressources de développement/legacy SCRT | Module map vide et localisation SAMKeychain inutilisée retirés. |
| Boutique et coordinateur annexe SCRT | Deux initialisateurs neutralisés ; leurs cibles finales étaient déjà inactives. |
| Deux méthodes Objective-C `+load` annexes | Neutralisées ; elles lançaient les contrôles de protection du composant, distincts du noyau Shield/snap0x conservé. |
| Noyau Shield, DeviceCheck et interceptions associées | Instructions conservées à l’identique de la v3, sauf les quatre entrées annexes listées. |
| Ressources natives et extensions de l’archive source | Conservées, octet pour octet. |

**43 fichiers supprimés, 2 fichiers modifiés, 8 067 fichiers conservés à
l’identique : 8 069 fichiers dans l’IPA finale.** Le nettoyage retire 1 445 799
octets non compressés. L’archive finale fait 94 740 174 octets.

Le binaire principal garde exactement la même taille. Sa table de chargement
est compactée dans l’espace de l’ancien en-tête, dont la fin est mise à zéro.
Aucune section, instruction applicative ou donnée LINKEDIT n’est déplacée.
Comme SKEngine est la dernière dépendance et n’a pas d’import, les ordinaux des
autres bibliothèques restent identiques.

## Démarrages SCRT

Parmi les 28 entrées `__init_offsets`, seules ces trois entrées restent actives :

- `_runShieldEngine`, `0x21698` : initialisation Shield existante.
- `_snap0x_init`, `0x44440` : interceptions et installation différée du hook existant.
- `_snap0x_proxy_init`, `0x56be0` : interceptions du runtime déjà présentes.

Les nouveaux retours immédiats concernent `_initializer_store` (`0x379f0`),
`_initializer` (`0x6930c`), `+[SCLoaddingHar load]` (`0x1d184`) et
`+[SCLoad load]` (`0x5bae0`). Cela modifie exactement 16 octets par rapport à la v3.
Les autres initialisateurs annexes commençaient déjà par `RET` dans la source.
Les tables de pointeurs et les métadonnées dyld ne sont pas réécrites dans SCRT.

Le coordinateur visé par `0x6930c` est la classe SCRT
`Ewff0yCVSBsd08GAXd05o3fiQ0xuC0OnzYhz1`, dont `start` (`0x626a4`) était déjà un
`RET`. La cible boutique `_FetchStoreAssetsSecure` (`0x37a74`) était aussi un
`RET`. Ce nettoyage supprime leur programmation inutile ; il ne débloque aucune
fonctionnalité d’abonnement.

Correction de l’audit antérieur : `_snap0x_silent_auth_check` (`0x4241c`) renvoie
déjà `1` immédiatement dans l’IPA source. Le corps `verifySync` est dormant.
Le nettoyage ne crée ni ne modifie ce comportement. Les tests distinguent
maintenant ce stub réel des branches couvertes avec un retour simulé.

## Ce qui demeure

SCRT est un framework compilé monolithique. Des classes, méthodes et chaînes
des menus, téléchargements, thèmes, cartes et autres ajouts restent physiquement
dans le fichier, même lorsque leurs points de démarrage sont neutralisés.
Ses classes et catégories Objective-C restent enregistrables par le runtime.
Ce résultat est donc une suppression des composants séparables et une
neutralisation des activations recensées, **pas une purge de tout code Snap++/SCRT**.
Retirer aussi ces octets de façon fiable tout en gardant les fonctions partagées
demanderait les sources et une reconstruction du framework.

Le profil fictif iPhone 12 mini reste celui de la v3 dans les listes d’exemption
et le User-Agent dormant. Il ne transforme pas les réponses MobileGestalt en
identité d’iPhone 12 mini. Les correctifs de trousseau, UUID et logs de la v3 sont
conservés. Aucun nouveau mécanisme de contournement n’est ajouté.

## Reproduction et validation

```sh
python3 tools/clean_ipa.py Snapchat_DeviceCheck_etude_unsigned.ipa Snapchat_Core_nettoyee_unsigned.ipa --report cleanup-result.json
python3 -m unittest discover -s tests -v
python3 tools/fix_spoof_consistency.py --check
```

Le script utilise la bibliothèque standard Python 3.11 ou supérieure, refuse
toute autre IPA source, vérifie les préimages/hashes et n’écrase aucun fichier
existant. Il applique d’abord la v3, puis le nettoyage. Il relit tous les fichiers
produits et vérifie leurs CRC ZIP, tailles et SHA-256. L’ordre des fichiers et les
dates ZIP sont fixes ; la compression peut dépendre de la version de zlib.

Les tests contrôlent les risques de renumérotation/imports Mach-O, les seuls
octets SCRT modifiés, l’absence d’appels depuis les entrées neutralisées, le
nombre d’initialisateurs actifs et le flux d’identité/login conservé dans un
runtime simulé. L’IPA réelle a aussi été reconstruite et relue intégralement.
Ils ne valident ni dyld/Objective-C sur iOS, ni la signature, ni une connexion
Snapchat, ni une levée de restriction. **L’IPA reste non signée et non testée
sur iPhone.**

| Fichier | SHA-256 |
| --- | --- |
| IPA source | `416aa57047ef1aaa77d03d1ca4c69759412b11d8141da877306be94d2bf633e9` |
| IPA nettoyée | `b31048749501a358ef6705e62dc70e0c107f550e1e63b2ca6ab6794e8ed1949b` |
| `Snapchat` nettoyé | `d3de5264ddb7f8043eb8fc7c5ede5d62bd30663f418bd4f6d5f3c17f77b1ee3c` |
| SCRT nettoyé | `922833f2ef2d3d00376d1cf1761a14727e8363abfd28c4ae8187b6333e50851a` |

[cleanup-result.json](cleanup-result.json) enregistre les différences exactes.
Le `Payload/` versionné reste le matériau d’analyse v3 avec ses inventaires
cohérents ; la recette produit l’IPA nettoyée séparément. L’ancienne release reste
l’archive source. Aucun fichier source de cette release n’a été remplacé.
