# Audit du spoof et correctifs vérifiables

Référence : commit `e005928d969b6bfb59b1caafca2f7ba50a2519e6`,
SCRT ARM64 de 1 297 664 octets. Analyse du 27 septembre 2026.
Le périmètre est celui des mécanismes de spoof de SCRT ; ce rapport n’est pas
un audit exhaustif des 8 112 fichiers de l’IPA ou de tous les services utilisés.

## Comportements relevés

| Composant | État dans l’archive | Actions observées dans le désassemblage |
| --- | --- | --- |
| `_runShieldEngine` (`0x21698`) | Initialisateur actif | Appelle `_initializeShieldEnvironment`, remplace les accesseurs IDFV et IDFA, installe d’autres interceptions. |
| `_initializeShieldEnvironment` (`0x22220`) | Actif | Lit `SHIELD_ID_<bundleIdentifier>` dans les préférences, publie `_kDynamicUUID`, crée et mémorise un UUID s’il est absent. Avant correction, toute chaîne non nulle était acceptée. |
| Deux accesseurs `replaced_*Identifier` | Installés par Shield | Construisent un NSUUID depuis la même chaîne. Une chaîne invalide renvoie `nil`, sans forcément lever l’exception que le code cherchait à intercepter. Le partage du même identifiant simulé entre ces accesseurs est conservé. |
| `_snap0x_init` (`0x44440`) | Actif | Installe des interceptions réseau/runtime/bundle et programme l’installation du hook de connexion. |
| `_snap0x_login_trampoline` (`0x41bdc`) | Hook de connexion installé avec délai | Dans la source, appelle les routines d’effacement puis `_snap0x_silent_auth_check`, qui renvoie déjà `1` immédiatement. Remplace ensuite le champ DeviceCheck par une chaîne sentinelle et appelle le login original. Les effacements sont retirés en v3. |
| `_hook_CFBundleGetIdentifier` (`0x71650`) | Installation active | Renvoie `com.toyopagroup.picaboo` pour le bundle principal. Le bundle d’installation déclaré est `app.neriostore.snapchatunbanss06`. Cette distinction relève du spoof existant, conservé. |
| `_init_Spoofing_Hooks` (`0x43a00`) | Désactivé par `RET` | Les fonctions de réécriture version/en-têtes et leur ancienne cible `13.67.1` restent présentes. Elles ne sont pas réactivées par ce correctif. |
| `_fwlog` (`0x4e960`) | Désactivé par `RET` | Les appels de journalisation restent dans le code, mais cette entrée de logger est neutralisée. |

La présence de ces instructions et de chemins d’activation est établie
statiquement. Leur compatibilité avec les classes réellement chargées sur un
iPhone n’a pas été confirmée. Les accès au trousseau et aux fichiers ne sont pas
de simples chaînes affichées : les routines appellent des API de suppression.
Aucune de ces suppressions n’a été exécutée pendant cet audit.

## Corrections appliquées

### 1. UUID persistant invalide

L’ancienne condition ne testait que la présence de la chaîne. Une préférence
corrompue, vide ou contenant un UUID invalide survivait à chaque lancement et
produisait ensuite un identifiant nul.

La fonction de préparation valide désormais la valeur avec
`NSUUID.initWithUUIDString:`. Une valeur valide est conservée sans réécriture.
Une valeur absente ou invalide est remplacée et enregistrée avant sa publication
dans `_kDynamicUUID`. La clé, le format et le comportement de persistance existants
sont conservés. La fonction conserve son allocation de pile, son frame pointer,
les registres sauvegardés et ses limites de section.

### 2. Effacements automatiques du hook de connexion

Le hook effaçait les éléments ciblés du trousseau et des fichiers locaux avant
d’appeler `_snap0x_silent_auth_check` (`0x4241c`). **Correction de l’audit initial :
cette entrée commence déjà par `mov w0, #1; ret` dans l’IPA source.** Le corps
`SKN_VerifyEngine.verifySync` qui suit est donc inatteignable depuis cette entrée.
La première version du rapport avait confondu le corps dormant et le chemin actif.

La première correction déplaçait les effacements sur la branche de réussite du
contrôle. La v3 les retire aussi de cette branche : stub de succès existant →
traitement DeviceCheck existant → appel du login original avec les mêmes arguments.
Le saut rejoint directement `0x41c8c` ; les appels à `0x41c80` ne sont plus atteints.
Les tests de refus utilisent un retour simulé pour couvrir une branche hypothétique,
pas un refus qui serait produit par le stub réel de cette archive.

Cette suppression accompagne la restauration des paramètres du trousseau,
qui modifierait autrement le service interrogé par le nettoyage automatique.
Les routines d’effacement, le stub de succès déjà présent et le traitement
DeviceCheck ne sont pas réécrits. L’authentification Snapchat reste extérieure à
ce contrôle. Le retour anticipé sans callback de la branche hypothétique de refus
reste inchangé. Ce correctif ne prétend pas désactiver toutes les opérations de
suppression possibles ailleurs dans l’application.

### 3. Deux modèles dans les User-Agent dormants

Le setter individuel utilisait `iPhone6,1 / iOS 12.5.7`, alors que le setter
groupé utilisait `iPhone10,3 / iOS 16.7.12`. Le setter individuel pointe maintenant
vers le même objet CFString que le setter groupé. Aucun texte n’est agrandi,
aucun pointeur de rebasing n’est changé et aucun module n’est réactivé.

La cible de version historique et les autres comportements du module inactif
restent des résidus. Ce changement n’altère pas les User-Agent en fonctionnement
normal tant que l’initialisateur reste désactivé.

### 4. Profil fictif iPhone 12 mini

Les anciennes constantes iPhone X sont remplacées par ce profil de test :

| Champ | Valeur |
| --- | --- |
| Modèle | iPhone 12 mini |
| ProductType | `iPhone13,1` |
| Système | iOS `17.5.1` |
| Build | `21F90` |
| Numéro de série fictif | `SIM12MINI001` |
| UDID fictif | `00008101-0000000000000001` |

Ces valeurs et les sources des correspondances modèle/build sont consignées
dans `tools/spoof_fix/iphone12-mini.json`. Aucun identifiant d’un appareil réel
n’est repris pour ce profil.

Les deux implémentations de `_SH_IsExemptDevice` (`0x1ebe0`, `0x5d5d4`)
utilisent ces constantes dans leurs listes d’exemption. Elles lisent les
informations de l’appareil et les comparent aux entrées de la liste : modifier
cette liste ne change donc pas les réponses des API matérielles d’iOS.
La liste statique et celle construite au lancement partagent les objets CFString
modifiés. Leurs deux entrées historiques portent désormais le même profil et
le même build ; leur structure et leur logique de comparaison sont conservées.

Le modèle et la version d’iOS sont aussi appliqués au CFString de User-Agent
partagé par les deux setters décrits ci-dessus. L’ancien littéral inutilisé
`iPhone6,1 / iOS 12.5.7` reste un résidu. Le module reste désactivé.

Cette seconde révision change uniquement les textes et, lorsque nécessaire,
les longueurs des CFString. Elle ajoute 78 octets différents à la première
correction, sans changer les instructions ni les pointeurs de rebasing.

### 5. Intégrité des requêtes du trousseau

Les trois hooks Security remplaçaient le service demandé par
`com.apple.shield.identity.v3`, sauf pour une liste d’exceptions. Deux services
indépendants pouvaient donc être fusionnés. Add/Copy retiraient aussi le groupe
d’accès et la synchronisation ; Update retirait le groupe des attributs.

Leurs entrées transmettent désormais les arguments intacts à l’API originale
enregistrée par le mécanisme d’interception. Les pointeurs de résultat et les
codes de retour sont conservés. Le système redevient responsable des permissions
du trousseau. Les anciens éléments restent dans leur ancien service : aucune
migration ni suppression n’est effectuée, et une reconnexion peut être nécessaire.

### 6. Envoi résiduel des logs

Le logger `_fwlog` et `_snap0x_init_logging` étaient déjà désactivés par `RET` ;
l’URL du transport de logs est vide dans cette archive. Cela ne prouve pas une
exfiltration active. En complément, flush et traitement de la file retournent
immédiatement, et le transport direct renvoie `false` sans collecte ni réseau.
Cette fermeture ne concerne que le sous-système de logs snap0x étudié.

Le détail des preuves et des affirmations non confirmées figure dans
[gestalt-identity-boundaries.md](gestalt-identity-boundaries.md).

## Reproductibilité et validation

- Entrée SHA-256 : `15e8fedb591d0c154944af49bb5c87c48e31373d52ad3e9f13f5458f21574c4b`.
- Révision intermédiaire acceptée : `1ad324fb72ad3fb4c260b9187cb6bf8c55fb042ef83dbc58b3f229c88555e059`.
- Révision iPhone 12 mini acceptée : `7756e3648654bd7377c322f7490461fcdfdf2b3f4a00ade269bb26d310d9aea9`.
- Sortie SHA-256 : `3b563f265bee10abce6791d4993583a336a1625fc8cdb0cecda9ba7921b52866`.
- Taille inchangée ; 470 octets différents, dans vingt et une régions déclarées.
- `tools/spoof_fix/patches.json` contient les octets exacts avant/après et les
  gardes maintenant désactivés les initialisateurs concernés.
- `tools/spoof_fix/initialize_identity.s` rend la nouvelle routine lisible et
  réassemblable. Aucune adresse n’est supposée portable vers une autre build.
- `tools/fix_spoof_consistency.py` vérifie toutes les préconditions avant écriture,
  refuse une build inconnue, met à jour les inventaires et accepte une réapplication.
- Les champs `source_*` de l’inventaire décrivent toujours l’IPA source ; le
  champ `derived_revision` identifie la modification des fichiers extraits.

La suite de tests exécute les instructions ARM64 d’origine et corrigées dans
Unicorn avec un modèle explicite des appels Foundation/runtime et inspecte les
constantes du profil. Les tests reproduisent
l’UUID invalide, les effacements précédant le contrôle intermédiaire et le mauvais
User-Agent dans l’archive source. Les cas de refus et réussite simulés couvrent
les branches du caller ; des tests distincts exécutent le stub réel, déjà réduit
à un retour de succès, puis le parcours réel du hook de connexion. Ils couvrent ensuite la réparation persistante, la conservation
d’un UUID valide, les deux accesseurs, les branches du hook de connexion,
ses arguments, le profil du User-Agent, les plages de modification et le
réassemblage du correctif. Les contrôles du profil vérifient les deux entrées
statiques, les longueurs/terminaisons des CFString et la conservation de leurs
pointeurs.
Les nouveaux tests reproduisent la fusion de services par les trois hooks,
vérifient la transmission intacte des paramètres et des erreurs, les réponses
Gestalt non remplacées, deux UUID issus de générateurs simulés distincts, et
l’absence d’effacement ou d’envoi de logs sur les chemins corrigés.

Ces tests ne valident pas l’implémentation réelle de Foundation/ARC, la signature,
le chargement dyld, SKEngine, la compatibilité des classes privées ou une
connexion réseau. Aucun compte Snapchat n’a été utilisé, aucun service tiers
n’a été sollicité par l’application et aucun iPhone n’a été testé.

```sh
python3 -m pip install -r tests/requirements.txt
python3 -m unittest discover -s tests -v
python3 tools/fix_spoof_consistency.py --check
```

## Nettoyage dérivé de l’IPA

Le nettoyage demandé ensuite est décrit dans [ipa-cleanup.md](ipa-cleanup.md).
Il applique la v3 puis retire les composants séparables et neutralise quatre
entrées annexes. Ses empreintes sont distinctes de celles du SCRT v3 versionné.
