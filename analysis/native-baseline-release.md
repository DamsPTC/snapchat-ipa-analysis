# Snapchat 12.81.0 — base sans les injections identifiées

Cette release contient `Snapchat_Core_nettoyee_unsigned.ipa`, la base reconstruite
après suppression du spoof et des ajouts identifiés. Version 12.81.0, build
12.81.0.47. L’archive source reste disponible dans `v12.81.0-version-fix`.

- SCRT.framework, SKEngine.dylib, CydiaSubstrate.framework et optool supprimés,
  ainsi que les deux dépendances faibles ajoutées au binaire principal.
- Les hooks de spoof et de remplacement DeviceCheck contenus dans SCRT sont retirés.
- Identifiant du bundle principal rétabli à `com.toyopagroup.picaboo` et même
  préfixe appliqué aux six extensions avec leurs suffixes existants.
- Version minimale du plist principal alignée sur iOS 12.4 du binaire.

45 fichiers supprimés, 8 modifiés, 8 059 conservés à l’identique. L’IPA contient
8 067 fichiers et fait **94 365 812 octets**. Le corps du binaire principal après
sa table initiale de chargement et les sept autres exécutables natifs restent
identiques à la source.

SHA-256 de l’IPA :

```text
dd49ab63e079abac15391bfb7861d69fa876ec1b7d2a2a54b1ac801441e77c92
```

**L’IPA est non signée et non testée sur iPhone.** L’entrée étant déjà modifiée,
sans référence officielle indépendante de cette build, cette base n’est pas
certifiée identique à l’originale App Store. Les signatures et éléments déjà
absents ne sont pas reconstitués. Les six extensions restent marquées chiffrées
(`cryptid=1`), ce qui peut empêcher leur fonctionnement après une simple
re-signature. Aucun test d’installation, de connexion ou côté serveur n’a été
effectué. L’archive ne modifie pas les données d’une installation existante.

La reconstruction vérifie les CRC, tailles et SHA-256 de tous les fichiers.
Les 39 tests de la recette et de son historique passent. Les rapports joints
documentent le résultat et l’inspection indépendante des huit Mach-O conservés.
Le processus de publication exige la même empreinte que l’IPA déjà livrée,
puis vérifie les empreintes des cinq fichiers téléversés avant publication.

Le `Payload/` versionné demeure le matériau historique d’analyse ; utiliser
l’IPA jointe à cette release ou `tools/restore_native.py` pour obtenir cette base.
