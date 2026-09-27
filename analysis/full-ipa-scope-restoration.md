# Retour au périmètre de l'IPA complète

Le 27 septembre 2026, l'utilisateur signale que l'IPA SnapLab de 15 Ko a perdu
les fonctions attendues. La création d'une application séparée était une erreur
de périmètre. Il demande de reprendre l'application complète et précise que son
serveur est un émulateur qu'il contrôle.

## Archives disponibles et revérifiées

| Archive | Taille | Fichiers | Usage |
| --- | ---: | ---: | --- |
| Source étudiée | 95 550 793 octets | 8 112 | Archive complète avant cette recette de nettoyage |
| Base sans les injections identifiées | 94 365 812 octets | 8 067 | Base complète de travail, avec régressions connues |
| SnapLab hors ligne | 15 547 octets | 2 | Expérience séparée, ne répondant pas à la demande de restauration |

La base complète est toujours disponible dans la
[release native-baseline](https://github.com/DamsPTC/snapchat-ipa-analysis/releases/tag/v12.81.0-native-baseline).
Son SHA-256 local correspond à celui de l'asset GitHub publié :
`dd49ab63e079abac15391bfb7861d69fa876ec1b7d2a2a54b1ac801441e77c92`.
La relecture CRC de l'archive ne trouve pas de fichier corrompu.

Le binaire principal décompressé fait 204 641 792 octets. La base comprend
333 modules Composer, 6 bundles d'extensions et 6 982 fichiers de localisation.
La comparaison avec la source retrouve 8 059 fichiers identiques, 45 retirés,
8 modifiés et aucun ajouté. Les fichiers modifiés sont le binaire principal
et les sept Info.plist ; le corps du binaire à partir de l'offset `0x3800`
reste identique. Le [rapport de nettoyage](native-baseline.md) détaille les
injections retirées et les limites des extensions encore marquées chiffrées.

Ces contrôles portent sur la conservation des fichiers. Ils ne démontrent pas
que chaque fonction est opérationnelle : le login refusé et le crash Face ID
signalés sur cette base ne sont toujours pas corrigés. Aucune nouvelle IPA
n'est fabriquée pour donner artificiellement l'apparence d'un correctif.

## Configuration du serveur émulé à identifier

La racine du dépôt comprend le Payload, les recettes, tests et analyses ; aucun
projet serveur distinct n'y est visible. La recherche ciblée dans les recettes
et analyses ne retrouve pas de configuration d'émulateur. Les clés réseau du
plist principal examinées ne donnent pas d'adresse d'authentification locale.

Le binaire principal contient notamment des chaînes `auth.snapchat.com`,
`aws.api.snapchat.com`, `gcp.api.snapchat.com`, ainsi que des références à
localhost et à des adresses privées. Ce sont des **chaînes statiques**, pas
une observation de trafic : elles ne prouvent ni le serveur réellement joint
sur l'iPhone, ni l'absence d'une redirection externe. Aucun appel réseau vers
ces adresses n'a été effectué pendant cette vérification.

L'information manquante est l'adresse ou le dépôt du serveur émulé et le
mécanisme qui y dirige l'IPA : configuration embarquée, proxy, DNS ou autre
adaptateur de test. Cette information permettra de cibler les échanges du
parcours existant au lieu de remplacer l'application par une démo locale.

Le README et la PR replacent l'archive complète au centre du travail. La
publication automatique de SnapLab est désactivée ; ses sources et sa release
restent conservées comme historique d'une expérience annexe.
