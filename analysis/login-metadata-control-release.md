# Snapchat 12.81.0 — test des métadonnées, sans spoof

**IPA de diagnostic, pas un correctif de connexion confirmé.** Ce fichier isole
une modification introduite lors du nettoyage : les changements de métadonnées.

L’utilisateur a confirmé que la saisie automatique du mot de passe avec Face ID
déclenche le crash observé, tandis que la saisie manuelle ne ferme pas l’app.
La connexion manuelle reste refusée. Les deux problèmes sont suivis séparément.

Cette variante rétablit les sept Info.plist exactement comme dans la précédente
IPA qui conservait SCRT : identifiants de bundle, version minimale déclarée et
tous leurs autres champs restent ceux de cette référence. SCRT, SKEngine et
CydiaSubstrate restent supprimés. Aucun faux identifiant, faux jeton DeviceCheck,
hook de connexion ou filtre du runtime n’est réintroduit.

Par rapport à la base sans injections publiée précédemment, seuls les sept
Info.plist changent. Le binaire principal est identique. Par rapport à l’ancienne
IPA avec SCRT, seuls le retrait du framework SCRT et de sa dépendance de
chargement subsistent comme différences de contenu.

Le but est de tester l’effet des métadonnées avant de modifier davantage le
parcours de connexion. L’ancienne réponse « compte inexistant » ne prouve pas
à elle seule qu’une session pouvait être ouverte avec un compte valide. Aucune
connexion réussie n’a été reproduite par l’outil de reconstruction.

## Essai sur iPhone

Signer avec la même méthode et les mêmes réglages que la version précédente.
Saisir manuellement les identifiants d’un compte autorisé à se connecter, sans
utiliser le remplissage automatique Face ID. Noter le texte exact et le code de
l’erreur éventuelle. Pour une comparaison interprétable, relever aussi tout
identifiant de bundle que l’outil de signature aurait réécrit.

Une connexion réussie constituerait un indice en faveur de l’effet des
métadonnées, à confirmer. Un refus identique laisserait la cause ouverte et
nécessiterait le code d’erreur ou des informations d’exécution supplémentaires.
Le rapport de crash fourni ne contient pas la réponse d’authentification.

## Vérification et limites

- SHA-256 : `39b4d600ee724b9b0ddf986e744bb5f9ac2e75d7e387da233b9a8cc5b202e516`.
- Taille : 94 365 886 octets ; 8 067 fichiers.
- Tous les CRC, tailles et empreintes des fichiers reconstruits sont vérifiés.
- Les comparaisons complètes avec les deux IPA précédentes confirment les
  seules différences annoncées. Les 39 tests passent, dont le test étendu
  vérifiant la conservation des plists et l’absence d’application du spoof.
- Non signée, non testée sur iPhone ; réussite de connexion et correction du
  crash AutoFill non confirmées. Les six extensions restent marquées chiffrées.
- Pas de certificat officiel reconstitué, pas d’équivalence App Store vérifiée,
  pas d’effacement des données existantes sur l’appareil.

Reproduction depuis l’archive source exacte :

```sh
python3 tools/restore_native.py Snapchat_DeviceCheck_etude_unsigned.ipa Snapchat_SansSpoof_MetadataTest_unsigned.ipa --preserve-source-metadata --report login-metadata-control-result.json
```
