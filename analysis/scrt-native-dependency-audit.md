# SCRT fournissait-il une partie manquante du login natif ?

L'utilisateur précise que les deux variantes ont été signées avec la même
procédure et qu'il ne peut pas exporter les IPA signées. L'analyse continue sur
les archives disponibles ; leur export n'est plus posé comme préalable. Cette
précision réduit l'intérêt de l'hypothèse d'un changement volontaire de réglages
du signateur, sans certifier l'identité des fichiers produits.

L'hypothèse examinée est celle d'un utilitaire natif ou d'un correctif de
compatibilité fourni par SCRT, qui aurait disparu lors du retrait du framework.
**SCRT contient effectivement plusieurs familles de code. L'audit n'identifie
toutefois pas de fonction native de login déportée dans ce framework.**

## Inventaire vérifié

L'examen porte sur SCRT extrait de l'ancienne version conservant le noyau,
SHA-256 `922833f2ef2d3d00376d1cf1761a14727e8363abfd28c4ae8187b6333e50851a`.
Il lit les tables Objective-C et les symboles, au lieu de classer les fonctions
sur la seule base du nom du framework.

| Vérification | Résultat |
| --- | --- |
| Classes définies par SCRT | 36, totalisant 511 entrées de méthodes |
| Catégories enregistrables de SCRT | 9 entrées, totalisant 46 entrées de méthodes |
| Classes de même nom définies dans le binaire principal | Aucune parmi ces 36 classes |
| Noms exacts de ces classes présents comme chaînes dans le binaire principal | Aucun |
| Imports du binaire principal correspondant à un symbole défini par SCRT | Aucun dans les tables examinées |
| Initialisateurs SCRT | 28 entrées ; 25 commencent par un retour immédiat |
| Méthodes de classe `+load` de SCRT | Deux, toutes deux neutralisées dans cette variante |
| Méthodes de classe `+initialize` de SCRT | Aucune déclarée |

Les quatre classes `SCLoginJanusService`, `UNISCJanusLoginService`,
`SCDeviceCheckFeature` et `SCKeychainManager` sont définies dans le binaire
principal. Leurs régions déjà comparées sont conservées entre les variantes.
L'absence d'import explicite depuis SCRT avait également été vérifiée avant
le retrait de sa dépendance de chargement.

L'inventaire détaillé, les adresses et les empreintes se trouvent dans
[scrt-native-dependency-audit.json](scrt-native-dependency-audit.json).

## Catégories et utilitaires

Les catégories restent enregistrables lorsque leurs initialisateurs annexes
sont neutralisés. Elles pouvaient donc modifier l'environnement de l'ancienne
version, même lorsque les fonctions de menus étaient inactives.

| Classe étendue | Contenu relevé |
| --- | --- |
| `UIColor` | Conversion de couleurs hexadécimales |
| `NSObject` | Méthodes de remplacement d'identifiants et de reporting, hooks de menus, localisation et médias |
| `UIImage` | Redimensionnement et images des ajouts |
| `NSUserDefaults` | Sauvegarde de couleurs |
| `UIView` | Recherche du contrôleur parent |
| `NSFileManager`, `NSArray`, `NSString` | Manipulation et suppression de chemins |
| `NSDataDetector` | Accesseur partagé du composant |

Deux noms de méthodes figurent aussi dans les références de sélecteurs du
binaire principal : `colorWithHexString:` et `sharedInstance`. La présence
d'un nom partagé ne suffit pas à établir un appel à la catégorie de SCRT.

- `UIColor +colorWithHexString:` possède déjà une implémentation native dans
  la catégorie `GenerativeAIUI`, à `0x107358a4c`. Retirer les implémentations
  supplémentaires de SCRT ne retire donc pas l'unique fournisseur de cette
  méthode. Leur présence pouvait en revanche changer l'implémentation choisie.
- `sharedInstance` est un sélecteur générique utilisé par de nombreuses classes.
  Les huit références directes adjacentes ADRP/LDR au pointeur importé de
  `NSDataDetector` ont été examinées. Elles conduisent aux constructeurs Apple
  `initWithTypes:error:` ou `dataDetectorWithTypes:error:`, y compris via un
  helper Swift ; aucun appel à l'accesseur SCRT n'a été identifié dans ces sites.

Ces utilitaires ne fournissent donc pas de dépendance manquante démontrée pour
le traitement des réponses de connexion. Une différence d'interface liée aux
catégories reste possible ; elle n'explique pas à elle seule le statut reçu.

## Interceptions et compatibilité runtime

Les trois initialisateurs encore actifs sont `_runShieldEngine`,
`_snap0x_init` et `_snap0x_proxy_init`. Ils installent des interceptions,
initialisent l'identité du composant et programment son hook de connexion.
Ils ne chargent pas un moteur d'authentification Snapchat absent du binaire
principal dans les chemins examinés.

Plusieurs noms de classes de contrôle présents dans les listes Shield sont
absents des classes et chaînes exactes du binaire principal de cette build.
Le simple contenu d'une liste ne prouve donc pas que chaque interception
prévue a trouvé sa cible à l'exécution. L'inventaire ne présente pas ces
entrées comme des hooks confirmés sur appareil.

SCRT contient aussi un filtre runtime qui vise notamment `_UIRemoteKeyboards`,
la classe citée dans le crash AutoFill. Il peut avoir modifié les conditions
dans lesquelles le code natif interagit avec cette classe. Ce lien reste une
**hypothèse de compatibilité**, distincte d'une fonction Snapchat manquante.
Le gestionnaire de crash de SCRT termine le processus après journalisation ;
il ne répare pas l'objet mémoire impliqué dans ce crash.

Réintroduire l'ensemble des interceptions ne permettrait pas de distinguer
un correctif de compatibilité des changements d'identité, de requête ou de
visibilité du runtime. Aucun patch ciblé de compatibilité n'est justifié par
les traces disponibles à ce stade.

## Conséquence pour le refus actuel

Le [rapport sur iPhone](login-runtime-observation-2026-09-27.md) montre une
réponse présente, sans erreur de transport, avec `16 / ErrBlocked`, ensuite
traitée par la branche native d'échec. Il ne montre pas un appel interrompu
par une classe ou une méthode manquante. Le succès antérieur signalé par
l'utilisateur reste pris en compte.

Le retrait de SCRT a réellement changé les entrées et l'environnement du
login. Cet audit ne détermine pas quel changement déclenche le refus. Il
écarte des hypothèses de dépendances manquantes précises, sans prouver
l'absence de tout appel dynamique ou de tout défaut dans cette IPA déjà
modifiée. Aucun Snapchat n'a été exécuté sur iOS dans cet environnement.

**Aucun module natif manquant n'a été identifié à remettre en place ; aucune
nouvelle IPA n'est présentée comme réparée.** La base reste non validée pour
la connexion et le parcours AutoFill. Les archives et données utilisateur
existantes restent disponibles pour des comparaisons supplémentaires.

Référence de format : [structures Apple des imports Mach-O chaînés](https://github.com/apple-oss-distributions/dyld/blob/main/include/mach-o/fixup-chains.h).
