# Régression constatée après retrait de SCRT

**Retour utilisateur complémentaire :** la fermeture se produit juste après le
remplissage automatique du mot de passe avec Face ID. La saisie manuelle ne
provoque pas ce crash, mais la connexion reste refusée. Le parcours AutoFill et
le refus de connexion manuelle constituent donc deux problèmes à suivre
séparément. Ce constat ne prouve pas encore le rôle causal du filtre SCRT.

Diagnostic du 27 septembre 2026, fondé sur le rapport iOS fourni par
l’utilisateur et sur les deux IPA effectivement produites. Le rapport brut
n’est pas recopié dans le dépôt. Aucun nouveau binaire n’est publié à cette
étape : le point où iOS détecte la corruption est connu, son origine ne l’est pas.

## Essai utilisateur et périmètre

L’utilisateur signale que la révision conservant SCRT affiche une réponse pour
un compte inexistant sans fermer l’application. La base sans SCRT affiche
« trop de tentatives de connexion » puis se ferme. Les deux symptômes doivent
être investigués dans la comparaison de ces révisions ; le rapport ne contient
ni la requête ni la réponse réseau permettant d’expliquer le changement de message.

Le rapport indique Snapchat 12.81.0 / 12.81.0.47, iPhone13,1 et iOS 26.3
(23D127), avec le bundle `com.toyopagroup.picaboo`. Le crash intervient environ
21,28 secondes après le lancement, sur le thread principal.

L’UUID du binaire correspond à celui de la build analysée. Comme les recettes
conservent cet UUID entre les révisions, ce champ ne prouve pas à lui seul
l’identité octet pour octet de l’exécutable installé après signature.

## Panne établie par le rapport

| Champ | Valeur |
| --- | --- |
| Exception | `EXC_BREAKPOINT`, signal `SIGTRAP` |
| Terminaison | namespace `SIGNAL`, code 5 |
| Première frame | `__CFCheckCFInfoPACSignature + 44` |
| Appel précédent | `_CFRelease + 228` |
| Objet en cours de destruction | `_UIKeyboardChangedInformation`, `.cxx_destruct` puis `dealloc` |
| Parcours système | `_UIRemoteKeyboards updateCurrentState:` puis préparation du déplacement du clavier |
| Type d’objet visible dans les registres | `__NSCFString`, sélecteur `release` |

Les octets d’instruction présents dans le rapport ont été désassemblés. Le
contrôle relit les métadonnées de l’objet, recalcule un code d’authentification
avec `pacga`, compare le résultat, puis exécute `brk #0xc470` en cas de
désaccord. Ce diagnostic concerne l’intégrité d’un objet en mémoire ; il ne
s’agit pas du certificat utilisé pour signer l’IPA.

Le système détecte donc une incohérence pendant la libération d’une chaîne dans
le parcours du clavier. Le rapport ne montre pas l’instruction qui a créé
cette incohérence. Il ne permet pas de conclure à une double libération,
un use-after-free, une écriture concurrente ou une autre modification précise.
Une pile composée de fonctions Apple ne démontre pas que le défaut vient d’iOS.

Ce rapport ne décrit ni une terminaison `CODESIGNING`, ni une dépendance manquante
signalée par `DYLD`, ni une fermeture via le gestionnaire de signaux de SCRT.
Cela ne valide pas pour autant toutes les permissions et fonctionnalités de la signature.

## Différence directement pertinente dans l’ancien SCRT

Dans le SCRT conservé par l’ancienne IPA, `_g_proxy_classes` contient précisément
`_UIRemoteKeyboards`. Ce n’est pas une simple chaîne isolée : la table est
parcourue par plusieurs fonctions installées par `_snap0x_install_proxy_hooks`.
Ce dernier est appelé par les initialisateurs actifs du composant.

Le code examiné filtre certaines recherches de classes et méthodes pour des
appelants hors des images système reconnues. Il peut notamment renvoyer une
classe ou une méthode absente, ou une liste de méthodes vide pour les classes
de cette table. Les appels système reconnus empruntent le chemin original.
Ce comportement dépasse les substitutions d’identifiants et le parcours DeviceCheck.

La portion contenant l’installation et les hooks, ainsi que la table des classes,
a été comparée à celle de l’ancienne IPA nettoyée : elle est identique. Le retrait
complet de SCRT supprime donc aussi ce traitement de `_UIRemoteKeyboards`.

**Il s’agit d’un candidat concret à examiner, pas d’une preuve de causalité.**
Le contrôle PAC échoue pendant la destruction d’un objet ; aucun appel au filtre
ci-dessus n’apparaît dans la pile fautive. Son rétablissement seul n’a pas été
testé sur appareil et ne constitue pas encore un correctif démontré.

Le gestionnaire `_snap0x_safe_signal_handler` a également été revérifié : il
écrit des informations et une backtrace, synchronise la sortie, puis appelle
`_exit`. Il ne restaure pas un objet corrompu et ne reprend pas l’exécution.

## Autres différences entre les deux IPA

Comparaison directe des archives non signées, fichier par fichier :

- 2 fichiers supplémentaires retirés : le binaire SCRT et son Info.plist ;
- 8 fichiers modifiés : l’en-tête de chargement du binaire principal et 7 plists ;
- 8 059 fichiers identiques ; aucun fichier ajouté.

Les plists changent les sept identifiants de bundle. Le plist principal change
aussi `MinimumOSVersion` de 10.0 à 12.4. Le binaire principal garde sa taille et
tous ses octets après l’ancienne table de chargement restent identiques.
Les changements de bundle constituent une deuxième variable à isoler dans
un essai comparatif ; ils ne sont pas désignés comme cause du crash par le rapport.

## Validation ciblée restante

Le premier essai utile ne nécessite aucune nouvelle tentative d’authentification :
sur la version qui crash, désactiver le réseau, ouvrir un champ de connexion,
saisir quelques caractères, changer de champ puis fermer le clavier sans valider
la connexion. Observer si l’application se ferme et, dans ce cas, comparer le
nouveau rapport avec cette même signature PAC et ce même parcours clavier.

Un crash identique dans cet essai montrerait que l’envoi de la connexion n’est
pas nécessaire au déclenchement. L’absence de crash ne disculperait pas le
clavier : le parcours dépendrait peut-être aussi de la présentation de l’erreur.
Un essai différentiel doit conserver le même appareil, la même méthode de
signature et les mêmes actions. Les modifications de métadonnées et les
interceptions runtime doivent être isolées une à une avant d’attribuer un correctif.

Les 39 tests précédents vérifient la recette et des fonctions dans un runtime
simulé. Ils n’exercent pas les objets UIKit/CoreFoundation d’iOS 26.3 ni la
gestion du clavier sur un iPhone. Ils ne permettent pas de fermer cette régression.

Références Apple pour l’interprétation, sans attribution automatique de la cause :
[authentification des pointeurs](https://developer.apple.com/documentation/security/preparing-your-app-to-work-with-pointer-authentication)
et [investigation des erreurs mémoire](https://developer.apple.com/documentation/xcode/investigating-memory-access-crashes).
