# Gestalt, identifiants et intégrité du trousseau

Analyse du 27 septembre 2026. Périmètre : SCRT ARM64 de l’archive référencée par
`tools/spoof_fix/patches.json`. Les adresses ci-dessous appartiennent uniquement
à cette build. Analyse statique et émulation ; aucun test d’IPA sur iPhone ni
observation du serveur Snapchat.

## Ce que montre le flux de données

| Affirmation | Résultat vérifiable dans les chemins examinés |
| --- | --- |
| Les cinq valeurs iPhone X adjacentes sont renvoyées par Gestalt à tous les utilisateurs | Non établi. Elles alimentent deux listes d’exemption. Les lecteurs Gestalt appellent la fonction système résolue puis retournent sa réponse. |
| `_kDynamicUUID` impose un UUID identique à chaque installation | Non établi. C’est un emplacement global au processus. L’initialisation lit les préférences locales puis appelle `NSUUID.UUID` si nécessaire. |
| L’UUID Shield est persistant dans les appels `SecItem*` | Faux pour la routine étudiée : elle utilise `NSUserDefaults`, avec la clé `SHIELD_ID_<bundleIdentifier>`. Les hooks du trousseau modifient d’autres requêtes. |
| IDFV et IDFA sont liés dans Shield | Confirmé : les deux accesseurs construisent un `NSUUID` à partir de la même variable locale au processus. Ce couplage existant reste conservé. |
| `_g_device_id` est réservé aux logs snap0x | Dans les références examinées, il sert au champ `device_id` de ces logs. Il est dérivé de `UIDevice.identifierForVendor`, donc pas nécessairement indépendant de Shield. |
| Ces valeurs déclenchent des collisions de masse ou un bannissement côté serveur | Impossible à conclure à partir du binaire seul. Aucun trafic, traitement serveur ou regroupement de comptes n’a été observé. |

## Gestalt : lecture, pas substitution dans ces fonctions

`_SH_MGCopyAnswerObj`, aux adresses `0x1f418` et `0x5dfe4`, fait résoudre
`MGCopyAnswer` avec `dlsym` (et `dlopen` en secours). Les initialisateurs associés
sont `0x1f500` et `0x5e0cc`. La clé reçue est transmise à cette fonction et son
résultat est retourné après gestion de la durée de vie de l’objet. Une réponse
absente reste absente.

`_SH_IsExemptDevice`, à `0x1ebe0` et `0x5d5d4`, lit `UniqueDeviceID`,
`SerialNumber`, `ProductType` et `BuildVersion`, puis compare ces résultats à
des enregistrements. `hw.machine` et `kern.osversion` servent de secours pour
les deux derniers champs. Les constantes du profil iPhone 12 mini remplacent
les anciens enregistrements de comparaison, pas la fonction système.

Les tests exécutent les deux lecteurs avec des réponses MobileGestalt simulées
différentes du profil : les mêmes réponses sont retournées, y compris `nil`.
Cela ne démontre pas l’absence de toute interception possible dans une autre
bibliothèque chargée ou dans une autre build.

## UUID local et limites de la persistance

L’initialisation `0x22220` utilise `NSUserDefaults.standardUserDefaults`, une clé
construite avec le bundle identifier, puis `NSUUID.UUID` et `UUIDString` pour une
nouvelle valeur. La correction v1 ajoute la validation des valeurs enregistrées.
La clé commune n’est pas une valeur UUID commune et `NSUserDefaults` n’est pas
un stockage global partagé entre tous les appareils.

Les tests fournissent deux résultats distincts au générateur simulé : chacun
est mémorisé séparément puis réutilisé au lancement suivant. Ils vérifient le
flux du code, pas l’aléa de Foundation. Une copie des préférences ou une
restauration de conteneur peut recopier un UUID valide : aucune rotation
automatique ni détection de clone n’est ajoutée.

Pour l’IDFV système, la documentation Apple distingue la distribution App Store
du cas hors App Store, où elle décrit un calcul fondé sur le bundle identifier.
Les deux Team IDs cités ne suffisent donc pas à démontrer les valeurs obtenues.
Voir [identifierForVendor](https://developer.apple.com/documentation/uikit/uidevice/identifierforvendor).
Ces règles système ne changent pas ce que font les accesseurs remplacés dans SCRT.

## Défaut confirmé : fusion des services du trousseau

La table de rebinding `0xb1258` installe les hooks suivants :

| API | Entrée du hook | Pointeur de l’API originale |
| --- | --- | --- |
| `SecItemAdd` | `0x208c0` | `0xcd7f8` |
| `SecItemCopyMatching` | `0x20b74` | `0xcd800` |
| `SecItemUpdate` | `0x20e28` | `0xcd808` |

Avant correction, hors exceptions, ils remplaçaient `kSecAttrService` par
`com.apple.shield.identity.v3`. Add/Copy enlevaient `kSecAttrAccessGroup` et
`kSecAttrSynchronizable`. Update retirait le groupe d’accès des attributs.
Les hooks ne lisent pas `_kDynamicUUID` et n’injectent pas sa valeur dans les données.

Les tests reproduisent le problème avec deux requêtes portant le même compte
et deux services différents : les trois hooks transmettent le même service à
l’API simulée. Il s’agit d’une collision de noms locale, sans preuve de collision
entre appareils. Les anciennes transformations divergeaient aussi de Delete,
absent de cette table de rebinding.

La v3 remplace l’entrée de chaque hook par un transfert direct vers son API
originale, en conservant les arguments et son code de retour. Aucune valeur de
service, permission ou synchronisation n’est inventée. Les erreurs de permission
éventuelles sont à nouveau celles du système ; la signature doit autoriser les
groupes demandés. Référence :
[kSecAttrAccessGroup](https://developer.apple.com/documentation/security/ksecattraccessgroup).

**Compatibilité :** les éléments auparavant créés sous le service Shield ne
sont pas renommés ni supprimés. Les services d’origine peuvent ne pas les
retrouver ; une reconnexion peut être nécessaire. La modification est publiée
dans une branche de correction, sans installer l’IPA sur un appareil.

Le hook de connexion interrogeait aussi le trousseau pour l’effacer. Afin de ne
pas modifier implicitement la portée de cet effacement en rétablissant les
services, ses deux appels automatiques de nettoyage (trousseau et fichiers)
sont retirés du chemin de réussite. Le stub de contrôle du composant, les arguments de connexion et le traitement
DeviceCheck existant sont conservés. L’entrée `0x4241c` renvoie déjà `1` dans
l’IPA source ; elle n’appelle pas le corps `verifySync` dormant qui la suit. Les routines de
suppression restent présentes dans le binaire ; ce n’est pas une garantie portant
sur toutes les opérations possibles de l’application.

## Logs : identifiant dérivé et fermeture des points résiduels

`_snap0x_get_device_id` (`0x4ff98`) met en cache la chaîne de l’IDFV courant dans
`_g_device_id` (`0xcdd20`), avec les valeurs de secours `UNKNOWN` et `ERROR`.
Le collecteur `0x4f1f4` l’insère dans un dictionnaire contenant aussi des
informations de système, d’écran, de langue et de fuseau. Le transport
`0x4fa6c` sait construire une requête JSON.

Cependant, dans l’archive source, `_fwlog` (`0x4e960`) et l’initialisateur de
logs (`0x4e3d8`) commencent déjà par `RET`, et l’URL du transport est vide.
La présence des fonctions ne prouve donc pas un envoi actif.

La v3 ferme également `flush` (`0x4ecc4`) et le traitement de file (`0x4ed34`)
par retour immédiat. Le transport (`0x4fa6c`) retourne `false` immédiatement,
sans prétendre avoir réussi un envoi. Les tests appellent ces entrées avec des
données de file préremplies et refusent tout appel de collecte ou de réseau.
Les caches restent intacts et aucun effacement n’est effectué.

Les autres fonctionnalités réseau, SKEngine et la télémétrie propre à Snapchat
ne sont pas couverts par cette fermeture. Aucun hook supplémentaire de GPU,
caméra, mouvement, écran ou matériel n’est introduit.
