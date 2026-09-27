# Snapchat — IPA extraite pour analyse

Archive privée du contenu exact de `Snapchat_DeviceCheck_etude_unsigned.ipa`,
version **12.81.0**, build **12.81.0.47**.

Cette révision est celle dont la version déclarée a été corrigée et dont certains
ajouts ont été désactivés. Aucun autre changement de l’application n’est effectué
lors de cet import.

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

Empreinte SHA-256 de l’IPA exacte :

```text
416aa57047ef1aaa77d03d1ca4c69759412b11d8141da877306be94d2bf633e9
```
