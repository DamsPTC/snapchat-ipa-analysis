# Snapchat — IPA extraite pour analyse

Archive privée dérivée du contenu de `Snapchat_DeviceCheck_etude_unsigned.ipa`,
version **12.81.0**, build **12.81.0.47**.

Cette révision est celle dont la version déclarée a été corrigée et dont certains
ajouts ont été désactivés. Les correctifs de cohérence documentés ci-dessous
sont ensuite appliqués de façon reproductible après l’extraction.

## Contenu

- `Payload/Snapchat.app/` : fichiers extraits, binaires et ressources.
- `analysis/plists/` : copies XML lisibles des métadonnées ; les fichiers originaux
  restent inchangés dans `Payload/`.
- `analysis/versions.json` : versions et identifiants déclarés par les composants.
- `analysis/manifest.json` et `FILES.sha256` : inventaire et empreintes SHA-256.
- `tools/extract_ipa.py` : extraction contrôlée de cette archive précise.
- L’IPA complète, non signée, est jointe à la release `v12.81.0-version-fix`.

L’extraction donne les fichiers compilés distribués dans l’application.
Il ne s’agit pas du code source Swift/Objective-C ni d’un projet Xcode.

## Modifications déjà présentes dans cette révision

- `CFBundleShortVersionString` rétabli à `12.81.0`, build `12.81.0.47` conservé.
- Initialisateur de réécriture des versions/en-têtes en `13.67.1` désactivé.
- `Assets.der`, `I.plist`, `snappy.framework` et sa dépendance de chargement retirés.
- Plusieurs points d’activation des ajouts Snap++ désactivés.
- Initialisation du logger et fonction `_fwlog` neutralisées.
- Anciennes signatures et anciens profils de distribution retirés.

Du code dormant reste dans SCRT. Le hook de connexion, les interceptions du
runtime et SKEngine restent présents. Ce n’est pas une purge complète des ajouts,
ni une application officielle, ni une garantie de sécurité ou de connexion.
Le fonctionnement sur iPhone de cette révision n’a pas été validé.

## Récupération complète

Le binaire principal de 204 641 792 octets est stocké avec **Git LFS**.
Après un clonage authentifié du dépôt :

```sh
git lfs install
git lfs pull
sha256sum -c FILES.sha256
```

Un simple téléchargement ZIP du dépôt peut ne contenir que le pointeur LFS
du binaire principal. L’IPA jointe à la release contient toujours tous les fichiers.

Empreinte SHA-256 de l’IPA source, avant ces correctifs :

```text
416aa57047ef1aaa77d03d1ca4c69759412b11d8141da877306be94d2bf633e9
```
<!-- spoof-consistency-v1 -->

## Correctifs de cohérence du spoof

Le remplacement d’IDFV/IDFA existant est conservé. Les modifications de SCRT sont :

- Valider l’UUID mémorisé avant de le réutiliser. Une valeur absente ou invalide
  est remplacée une seule fois et enregistrée ; un UUID valide reste inchangé.
- Supprimer les effacements automatiques du hook de connexion, y compris
  après réussite de la vérification du composant. Cette vérification reste
  exécutée ; elle n’est pas la validation du mot de passe par Snapchat.
- Transmettre les requêtes `SecItemAdd`, `SecItemCopyMatching` et `SecItemUpdate`
  intactes aux API d’origine : services distincts, groupes d’accès et attributs
  de synchronisation sont conservés.
- Fermer les points d’entrée résiduels d’envoi des logs snap0x. Le logger et
  son initialisateur étaient déjà désactivés dans l’archive source.
- Utiliser le même profil `iPhone13,1 / iOS 17.5.1` dans les deux constructeurs
  de User-Agent. Leur initialisateur reste désactivé ; ce correctif est latent.
- Remplacer les anciennes constantes iPhone X des listes d’exemption par un
  profil fictif iPhone 12 mini : build `21F90`, série `SIM12MINI001`,
  UDID `00008101-0000000000000001`. Ces identifiants sont inventés pour le test.

Le profil est documenté dans
[tools/spoof_fix/iphone12-mini.json](tools/spoof_fix/iphone12-mini.json).
Les valeurs série/UDID/modèle servent à comparer l’appareil à une liste
d’exemption interne ; elles ne remplacent pas les informations renvoyées par iOS.

L’analyse [Gestalt, identifiants et trousseau](analysis/gestalt-identity-boundaries.md)
documente les chemins vérifiés. L’UUID Shield est généré localement avec `NSUUID`
et conservé dans `NSUserDefaults` ; aucune valeur UUID commune à tous les appareils
n’est imposée par ce chemin. Des préférences copiées peuvent toutefois conserver
le même UUID. Les anciennes entrées du trousseau rangées sous le service Shield
ne sont ni migrées ni supprimées ; une reconnexion peut être nécessaire.

Le rapport [analysis/spoof-consistency.md](analysis/spoof-consistency.md) distingue
les actions actives, les résidus et les limites. Les tests exécutent des instructions
ARM64 avec des API Foundation simulées. **Aucun test sur iPhone n’a été effectué.**

La release `v12.81.0-version-fix` contient toujours l’IPA source **sans ces nouveaux
correctifs**. Une IPA reconstruite depuis le `Payload` corrigé devra être signée
pour une installation. Aucun résultat de connexion ou de levée de restriction
n’est garanti par les tests.

Après une nouvelle extraction de l’archive source :

```sh
python3 tools/fix_spoof_consistency.py
python3 tools/fix_spoof_consistency.py --check
sha256sum -c FILES.sha256
```

Le workflow d’import applique aussi ce patch après extraction, pour éviter qu’un
nouvel import ne rétablisse silencieusement les défauts. Le script refuse tout
binaire différent des empreintes d’entrée/sortie documentées, et il est idempotent.
