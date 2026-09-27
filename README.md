# Snapchat — analyse et base sans injections

**Périmètre de travail rétabli : l'IPA complète.** La création de la petite
application SnapLab de 15 Ko ne répondait pas à la demande de conserver les
fonctions existantes. Elle n'a remplacé aucune des archives complètes.
La [base complète sans les injections identifiées](https://github.com/DamsPTC/snapchat-ipa-analysis/releases/tag/v12.81.0-native-baseline)
reste disponible : **94 365 812 octets, 8 067 fichiers**. Son binaire principal,
ses 333 modules Composer et ses ressources natives sont conservés ; cela ne
constitue pas une validation fonctionnelle du login ou des extensions.

L'utilisateur précise que l'application utilise un serveur émulé qu'il contrôle.
L'adresse et la configuration de redirection ne sont pas identifiées dans les
fichiers examinés. Elles sont nécessaires pour travailler sur ce parcours.
Voir [la vérification de l'archive complète](analysis/full-ipa-scope-restoration.md).
Le refus de connexion et le crash AutoFill de cette base restent ouverts.

La cible `tools/offline_sandbox/` et sa release sont conservées comme expérience
annexe ; elles ne sont plus le livrable de la demande en cours. Leur publication
automatique est désactivée. Les [résultats du laboratoire](analysis/offline-sandbox-result.json)
ne doivent pas être présentés comme des tests de l'IPA complète.

**Audit des dépendances de SCRT :** le framework comprend des utilitaires et des
interceptions de plusieurs types. L'examen de ses 36 classes et 9 catégories ne
met pas en évidence de fonction native de login à rétablir après son retrait.
Voir [l'analyse des dépendances et de la compatibilité](analysis/scrt-native-dependency-audit.md).
L'utilisateur ne peut pas exporter les IPA signées ; l'analyse poursuit les
comparaisons possibles sur les archives disponibles.

**Résultat du diagnostic sur iPhone :** les deux réponses observées portent le
statut natif `16 / ErrBlocked`, sans erreur de transport ; les écritures du
trousseau observées réussissent. L'utilisateur confirme une connexion réelle
avec l'ancienne version conservant SCRT. Le critère déclenchant le refus actuel
reste inconnu. Voir
[l'analyse du rapport reçu](analysis/login-runtime-observation-2026-09-27.md)
et ses [preuves binaires](analysis/login-runtime-observation-2026-09-27.json).
Aucune nouvelle IPA ni réparation confirmée ne résulte de cette analyse.

**Diagnostic runtime local :** une variante séparée ajoute un bouton
**Diagnostic** et un export de codes d'erreur pour l'essai après signature par
l'utilisateur. Elle conserve le login natif et ne réintroduit pas de spoof.
Voir [le mode d'emploi et les limites](analysis/login-runtime-diagnostic-release.md)
et la [release dédiée](https://github.com/DamsPTC/snapchat-ipa-analysis/releases/tag/v12.81.0-runtime-diagnostic).
La compilation iPhoneOS, les tests de transmission sur le runtime Apple et les
contrôles de l'archive ont passé. Les [empreintes publiées](analysis/login-runtime-diagnostic-result.json)
identifient exactement le livrable. Ce diagnostic ne constitue pas encore un
correctif du refus de connexion ou du crash AutoFill.

**Livrable actuel : une base sans les injections identifiées, spoof compris.**
**Régression signalée après signature et essai sur iPhone : crash dans le
parcours de connexion. Cette base n’est pas validée fonctionnellement.**
Le [rapport de diagnostic](analysis/crash-2026-09-27-keyboard.md) décrit un
contrôle d’intégrité mémoire déclenché pendant la gestion du clavier et une
interception de SCRT retirée qui visait la même classe système.
L’utilisateur a depuis isolé le crash au remplissage automatique avec Face ID ;
la saisie manuelle ne crash pas, mais la connexion reste refusée.
Une [variante de diagnostic des métadonnées](analysis/login-metadata-control-release.md)
conserve les plists de la version précédente tout en laissant le spoof retiré.
Elle est disponible dans la
[release de test](https://github.com/DamsPTC/snapchat-ipa-analysis/releases/tag/v12.81.0-metadata-control).
**Retour utilisateur suivant : la connexion reste refusée.** La capture affiche
un accès temporairement désactivé, sans code SS visible. Le rétablissement des
métadonnées n'a donc pas produit de correctif confirmé. Le
[suivi du refus de connexion](analysis/login-refusal-2026-09-27.md) documente la
comparaison des fonctions natives, la modification de requête auparavant faite
par SCRT et les informations encore nécessaires sur l'IPA après signature.
La recette `tools/restore_native.py` retire entièrement SCRT, SKEngine et
CydiaSubstrate, restaure les identifiants de bundle et corrige la version
minimale déclarée. Voir [le rapport actuel](analysis/native-baseline.md).
Télécharger l’IPA et ses empreintes dans la
[release sans spoof](https://github.com/DamsPTC/snapchat-ipa-analysis/releases/tag/v12.81.0-native-baseline).
Le `Payload/` ci-dessous reste le matériau historique d’analyse v3 ;
il ne faut pas le rezipper pour obtenir la nouvelle base.

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

## Base actuelle sans spoof

La demande de conservation du spoof est remplacée par sa suppression complète.
La nouvelle recette n’applique aucun patch Shield : elle retire entièrement son
framework, les deux commandes de chargement ajoutées, et les autres fichiers
annexes. Les sept identifiants de bundle sont remis dans le namespace Snapchat ;
la version minimale du plist principal est alignée sur iOS 12.4 du binaire.

```sh
python3 tools/restore_native.py Snapchat_DeviceCheck_etude_unsigned.ipa Snapchat_Core_nettoyee_unsigned.ipa --report native-baseline-result.json
```

Voir [native-baseline.md](analysis/native-baseline.md) et
[native-baseline-result.json](analysis/native-baseline-result.json).
**La base est non signée et n’est pas certifiée identique à une IPA App Store.**
Les six extensions conservent leur marquage de chiffrement. Les sections qui
suivent décrivent les révisions d’analyse antérieures, conservées pour référence.

## Historique : correctifs de cohérence du spoof

Le remplacement d’IDFV/IDFA existant est conservé. Les modifications de SCRT sont :

- Valider l’UUID mémorisé avant de le réutiliser. Une valeur absente ou invalide
  est remplacée une seule fois et enregistrée ; un UUID valide reste inchangé.
- Supprimer les effacements automatiques du hook de connexion. L’entrée du
  contrôle intermédiaire renvoie déjà « succès » dans l’IPA source ; ce stub
  reste inchangé. Il n’effectue ni `verifySync`, ni l’authentification Snapchat.
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

## Historique : IPA nettoyée avec noyau spoof conservé

`tools/clean_ipa.py` reconstruit une copie distincte depuis l’IPA source exacte,
applique les correctifs ci-dessus, retire 43 fichiers annexes et désactive quatre
entrées de démarrage supplémentaires dans SCRT. Le noyau Shield/DeviceCheck et
ses interceptions existantes restent conservés. Les ressources natives et les
extensions officielles restent inchangées.

```sh
python3 tools/clean_ipa.py Snapchat_DeviceCheck_etude_unsigned.ipa Snapchat_Core_nettoyee_unsigned.ipa --report cleanup-result.json
```

Le [rapport de nettoyage](analysis/ipa-cleanup.md) et
[l’inventaire des différences](analysis/cleanup-result.json) décrivent le résultat.
Le `Payload/` versionné reste la révision v3 d’analyse ; l’IPA nettoyée est un
produit dérivé par cette recette, avec ses propres empreintes. Cela évite de
confondre le binaire principal Git LFS source avec le produit reconstruit.
**SCRT reste monolithique : du code compilé dormant demeure.** Aucune purge
complète des classes/chaînes ni validation sur iPhone n’est revendiquée.
