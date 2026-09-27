# Connexion toujours refusée après le contrôle des métadonnées

## Résultat utilisateur

Après livraison de `v12.81.0-metadata-control`, l'utilisateur indique que le login
reste cassé. Sa capture montre le message français indiquant que l'accès à
Snapchat est temporairement désactivé en raison d'échecs répétés ou d'activités
inhabituelles. Aucun code SS n'est visible. La capture et le nom de compte ne
sont pas recopiés dans le dépôt.

Ce résultat ne confirme aucun correctif. Il est distinct du crash AutoFill avec
Face ID, que la saisie manuelle permettait d'éviter lors du précédent essai.
L'IPA exportée après signature n'a pas été fournie : la capture ne permet pas
de vérifier l'empreinte du binaire installé ni ses entitlements.

L'assistance officielle classe ce libellé parmi les refus temporaires d'accès.
Elle décrit plusieurs causes ; le seul texte affiché n'identifie ni un code SS
précis, ni le facteur déclenchant de ce test. Il ne faut donc pas attribuer
automatiquement cette régression à un nombre excessif d'essais, à la signature,
à DeviceCheck ou à un bannissement.

## Différence isolée par la variante de contrôle

La comparaison complète déjà enregistrée dans
`login-metadata-control-verification.json` établit que, par rapport à l'ancienne
IPA conservant le noyau SCRT, la variante de contrôle :

- retire le binaire SCRT et son Info.plist ;
- change uniquement l'en-tête de chargement du binaire principal ;
- conserve les 8 066 autres fichiers octet pour octet, dont les sept plists.

Le retour aux plists précédents n'a pas rétabli la connexion signalée par
l'utilisateur. Le retrait des comportements actifs de SCRT reste donc à prendre
en compte. Les éventuels changements du signateur et l'état de l'installation
ne sont pas contrôlés par cette comparaison d'archives non signées.

## Vérification du parcours natif

Les tables de classes et méthodes Objective-C du binaire principal ont permis
de retrouver les méthodes ci-dessous. Leurs octets ont été comparés directement
dans les quatre archives : source, ancienne version avec SCRT, base native et
variante de contrôle des métadonnées. Chaque zone a la même empreinte dans les
quatre archives. Les adresses concernent uniquement cette build, sans slide ASLR.

| Zone vérifiée | Adresse virtuelle | Taille | SHA-256 commun |
| --- | --- | --- | --- |
| `UNISCJanusLoginService`, envoi de connexion par mot de passe | `0x1067febfc` | 228 octets | `d6f0f9a7c5db1c0c90d2287c236fd6200c6f64b1748941f57ded2a3edbb79e75` |
| `SCLoginJanusService`, traitement de la réponse par mot de passe et helper adjacent | `0x105f8f458` | 1 372 octets | `d15f2c733e87ab6c4a6536dd556d702345e8e53b2111345a2fdb140e0444dab6` |
| `SCDeviceCheckFeature`, appel Apple et bloc de retour | `0x106e0222c` | 376 octets | `015e232ad05ecc3c739f0d6a80c5dc1715be910dacf2c76b4750b286f1ce2db1` |

Le service d'envoi sérialise la requête et transmet un handler au transport gRPC.
Le traitement de réponse distingue une erreur de transport d'une réponse
protocolaire. Il lit notamment `errorData.humanReadableErrorMessage` et
`statusCode`, puis construit `SCLogInError` avec `grpcStatusCode`,
`protoStatusCode` et `loginErrorDetail` avant d'appeler le bloc d'échec.
La réponse de succès possède un chemin distinct.

Ces fonctions n'ont donc pas été supprimées par le nettoyage. Cette identité
statique ne prouve pas que leurs entrées, l'environnement runtime ou les réponses
reçues soient identiques sur appareil. La capture ne contient pas les deux codes
internes permettant d'identifier la branche réellement empruntée.

## Ce que SCRT changeait réellement

L'examen porte sur SCRT extrait de l'ancienne IPA nettoyée, empreinte
`922833f2ef2d3d00376d1cf1761a14727e8363abfd28c4ae8187b6333e50851a`.

Son hook de connexion récupérait `loginHeader`, remplaçait le champ
`iosDeviceCheckToken` par la valeur sentinelle d'indisponibilité, puis appelait
l'implémentation native avec la requête, les options et le handler d'origine.
Ce hook ne se contentait donc pas de corriger l'interface. Son retrait laisse le
chemin natif de génération du jeton déterminer la valeur envoyée.

Le chemin Apple natif demande le jeton à `DCDevice` lorsqu'il est disponible et
supporté, encode le résultat reçu, et utilise une valeur sentinelle si la
génération ne fournit pas de jeton. Forcer cette dernière avant chaque connexion
constituait une différence de comportement ; rien dans la capture ne démontre
qu'elle explique à elle seule le refus actuel.

Les interceptions d'identifiants, de bundle et du runtime étaient également
retirées avec SCRT. Réintroduire tout ce framework ne permettrait pas d'isoler
une réparation du parcours natif et rétablirait les substitutions que
l'utilisateur a demandé de supprimer.

## Données nécessaires pour poursuivre la réparation

1. L'IPA exacte exportée après signature, accompagnée du nom et de la version
   du signateur. Vérifier ses dépendances effectives, ses métadonnées, les
   entitlements embarqués et la correspondance des groupes d'accès au trousseau.
2. Si ces contrôles ne trouvent pas de divergence : un journal local de l'échec
   contenant uniquement le domaine/code d'erreur de transport et le statut
   protocolaire. Les identifiants saisis, mots de passe, jetons, en-têtes et corps
   des requêtes ne sont pas nécessaires. Le rapport de crash AutoFill ne contient
   pas ces informations.

Aucun nouvel essai de connexion n'est nécessaire pour fournir l'archive signée.
Aucune nouvelle IPA n'est présentée comme réparée à cette étape. Les rapports
de reconstruction des releases précédentes restent inchangés : ils décrivent
leurs contrôles de fabrication, pas une validation du login sur iPhone.

Référence : [messages d'erreur de connexion — assistance Snapchat](https://help.snapchat.com/hc/en-us/articles/7012325477268-I-get-an-error-message-logging-in-to-Snapchat), consultée le 27 septembre 2026.
