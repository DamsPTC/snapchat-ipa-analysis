# SS03 signalé et vérification du chiffrement

L'utilisateur signale désormais le code SS03 et confirme que l'ancienne version
avec SCRT et DeviceCheck permettait la connexion. Il demande d'ignorer la capture
jointe ; elle n'est ni ouverte ni interprétée. Il ne souhaite pas fournir de
nouveaux éléments. L'analyse utilise les quatre archives déjà disponibles.

## Résultats vérifiés le 27 septembre 2026

- Le binaire principal des quatre archives porte `cryptid=0`. Les fonctions de
  connexion identifiées sont déjà lisibles et analysables ; leur étude ne
  nécessite pas de déchiffrer l'application.
- Les six extensions de la base portent toujours `cryptid=1`. Le précédent
  contrôle d'intégrité les trouve identiques à la source. Ce marquage n'a pas
  été introduit par le retrait de SCRT. Modifier le drapeau ne constituerait
  pas un déchiffrement de leurs données.
- Les régions natives d'envoi du mot de passe, de traitement de la réponse,
  de génération DeviceCheck et de construction de requête du trousseau ont
  les mêmes empreintes dans la source, l'ancienne version avec SCRT, la base
  nettoyée et la variante conservant les métadonnées.
- Aucune occurrence littérale ASCII de `SS03` n'est présente dans les quatre
  exécutables principaux. Cette recherche ne prouve pas l'origine du texte :
  un libellé peut être assemblé dynamiquement, localisé ailleurs ou reçu dans
  une réponse. Aucun patch de chaîne n'est justifié par ce constat.

Les détails vérifiables figurent dans
[login-ss03-encryption-review.json](login-ss03-encryption-review.json).
Les contrôles précédents des extensions figurent dans
[native-baseline-verification.json](native-baseline-verification.json).

## Interprétation limitée aux éléments disponibles

Le succès de l'ancienne variante rapporté par l'utilisateur reste un point de
comparaison essentiel. Des fonctions inchangées sur disque peuvent se comporter
différemment quand un composant injecté modifie leurs entrées ou leur
environnement à l'exécution. La comparaison d'empreintes ne démontre donc pas
que la différence entre les deux versions est sans effet.

Le dernier diagnostic reçu montre deux réponses natives `16 / ErrBlocked` et
aucun NSError de transport. Il ne fournit pas le code SS de ces réponses :
il ne faut pas transformer le nouveau signalement SS03 en donnée observée dans
cet ancien rapport, ni supposer que l'application contactait un service donné.

L'[assistance officielle Snapchat](https://help.snapchat.com/hc/en-us/articles/7012325477268-I-get-an-error-message-logging-in-to-Snapchat)
classe SS03 parmi les accès temporairement désactivés après des échecs ou une
activité inhabituelle. Cette description, consultée le 27 septembre 2026,
ne détermine pas la signification que lui donnerait le serveur émulé décrit
par l'utilisateur et n'isole pas la cause du test.

## État de la réparation

Ces vérifications n'identifient pas de fonction native supprimée ou de nouvelle
zone de chiffrement empêchant le login. L'audit ne permet pas de choisir un
correctif local causal et de vérifier une connexion complète avec les seuls
fichiers disponibles. Les substitutions d'identité, d'attestation et les
modifications destinées à contourner un blocage ne sont pas réintroduites.

Aucun binaire n'est modifié et aucune nouvelle IPA n'est présentée comme
réparée. Le refus de connexion et le crash AutoFill restent ouverts.
