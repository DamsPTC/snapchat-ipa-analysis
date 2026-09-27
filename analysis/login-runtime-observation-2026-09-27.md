# Refus observé sur iPhone : `ErrBlocked`

**Précision ultérieure :** l'utilisateur utilise la même procédure de signature
pour les deux variantes et ne peut pas exporter les archives signées. Leur
comparaison reste une vérification possible, mais n'est plus un préalable à la
poursuite. Voir [l'audit des dépendances réelles de SCRT](scrt-native-dependency-audit.md).

Le rapport exporté depuis la variante `2a5f8c8da84d3c58a20b870792052f62ee43c7ff`
contient deux tentatives de connexion par mot de passe. Les sept observateurs
sont installés. Chaque tentative atteint le traitement natif d'une réponse
présente, sans `NSError` de transport, avec le statut protocolaire **16**.
Dans cette build, ce statut se nomme **`ErrBlocked`**.

L'utilisateur confirme que l'ancienne version conservant SCRT permettait une
connexion réelle à un compte, ainsi que le retour « compte inexistant » pour
un identifiant inexistant. Cette précision remplace l'hypothèse selon laquelle
seul un message différent aurait été constaté. Nous n'avons toutefois ni trace
de cette connexion réussie, ni les deux archives exportées après signature pour
contrôler les conditions de la comparaison.

Le JSON brut, ses identifiants de signature et les captures utilisateur ne sont
pas publiés. Les observations minimales et les preuves binaires sont consignées
dans [le relevé associé](login-runtime-observation-2026-09-27.json).

## Décodage du statut

Le nom vient du descripteur embarqué de
`SCJanusLoginWithPasswordResponse_StatusCode`, et non d'une interprétation de
la valeur numérique comme code gRPC. Le constructeur référence une table de
20 noms à l'adresse `0x107b7365c` et une table de 20 entiers à `0x107b73800`.
Les entrées sont associées dans l'ordre du descripteur, qui n'est pas l'ordre
numérique des valeurs.

| Valeur | Nom dans cette build |
| --- | --- |
| 1 | `LoginSuccess` |
| 11 | `ErrThrottled` |
| 13 | `ErrAccountNotFound` |
| 15 | `ErrAppVersionUpgrade` |
| 16 | `ErrBlocked` |

La table de branchement du traitement de réponse, à `0x107b11df8`, dirige la
valeur 16 vers `0x105f8f610`. Ce chemin construit une erreur native à partir du
message reçu, conserve le statut protocolaire dans `SCLogInError`, puis appelle
le bloc d'échec d'origine. Le chemin de succès est distinct.

Cela montre un refus explicite reçu par le parcours natif. Cela n'identifie
pas le critère qui l'a déclenché, ni un code SS particulier. Le texte affiché
sur l'écran ne suffit donc pas à conclure à une simple limitation du nombre
de tentatives ou à un bannissement de l'appareil. Le diagnostic observe le
callback natif ; il ne constitue pas une capture du trafic réseau.

## Trousseau et signature

Les trois lectures observées retournent `-25300` (élément introuvable). Les
quatre écritures en arrière-plan retournent `0` (succès). Aucun
`errSecMissingEntitlement` (`-34018`) n'apparaît. Comme le module ne relève
aucune clé ou valeur, il ne permet pas d'établir si une lecture et une écriture
visent le même élément. Des lectures sans résultat ne démontrent donc pas une
perte de persistance.

Le constructeur natif `+[SCKeychainManager queryForKey:]`, à `0x100070c5c`,
assemble les cinq attributs suivants :

| Attribut | Valeur construite |
| --- | --- |
| `kSecClass` | `kSecClassGenericPassword` |
| `kSecAttrGeneric` | Clé reçue, encodée en UTF-8 |
| `kSecAttrAccount` | Même clé encodée |
| `kSecAttrService` | Service constant `com.toyopagroup.picaboo` |
| `kSecAttrSynchronizable` | Faux |

Ce constructeur ne fixe pas `kSecAttrAccessGroup` et ne lit pas
`SCKeychainAccessIdentifier`. Les noms des constantes ont été résolus dans la
table des symboles indirects du Mach-O. Ce constat concerne cette méthode,
pas l'ensemble des accès Security de l'application.

Le rapport montre aussi une différence entre les identifiants déclarés dans
les métadonnées du bundle et ceux lus dans les entitlements XML embarqués.
Cette différence est à examiner sur les archives signées, mais les observations
ne démontrent pas qu'elle bloque le trousseau ou provoque `ErrBlocked`.
`cryptographic_signature_verified: false` signifie que le collecteur n'effectue
pas de validation cryptographique ; ce n'est pas un verdict de signature invalide.

## Ce que la comparaison établit

Les quatre régions natives d'envoi, de traitement de réponse, de génération
DeviceCheck et de construction de requête du trousseau sont octet pour octet
identiques dans la source, l'ancienne version conservant SCRT, la base native
et la variante de contrôle des métadonnées. Le relevé JSON conserve leurs
adresses, tailles et empreintes. La variante de diagnostic conserve elle aussi
le corps du binaire ; son rapport de fabrication publié en atteste.

Cela écarte une suppression de ces fonctions lors de notre nettoyage. En
revanche, SCRT changeait leurs entrées et leur environnement à l'exécution,
notamment le champ DeviceCheck de la requête et les identifiants exposés.
La [précédente analyse](login-refusal-2026-09-27.md) documente ces changements.
Le succès signalé dans l'ancienne version est compatible avec cette différence,
sans isoler lequel de ces comportements rendait la requête acceptable.

Le crash AutoFill reste un défaut distinct. Ce rapport de connexion ne contient
pas de trace permettant de le corriger.

## Prochaine comparaison utile

Comparer les **deux IPA exportées après signature** : l'ancienne version qui
permettait la connexion et la variante de diagnostic testée. Cette inspection
ne demande pas de nouvelle tentative de connexion. Elle doit vérifier :

- les exécutables et dépendances réellement livrés après le passage du signateur ;
- les identifiants présents sur disque, les entitlements et les profils embarqués ;
- les ajouts ou changements apportés par le signateur entre les deux versions.

Si un défaut local de conditionnement est démontré, le corriger puis le tester.
Si la seule différence pertinente reste la substitution d'informations dans
SCRT, la réintroduire ne constituerait pas une restauration du comportement
natif. Changer le statut reçu ou appeler artificiellement le callback de succès
ne créerait pas une session authentifiée.

**Aucun correctif de connexion n'est encore confirmé et aucune nouvelle IPA
n'est produite à cette étape.** Les rapports historiques de fabrication restent
inchangés ; ce document ajoute le résultat du test utilisateur.

Références Apple : [élément introuvable](https://developer.apple.com/documentation/security/errsecitemnotfound),
[groupes d'accès au trousseau](https://developer.apple.com/documentation/security/sharing-access-to-keychain-items-among-a-collection-of-apps).
