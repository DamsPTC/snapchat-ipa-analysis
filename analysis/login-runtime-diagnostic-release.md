# Snapchat 12.81.0 — diagnostic local du login

Cette variante permet d'observer le refus sur l'iPhone après signature par
l'utilisateur. **Elle n'est pas présentée comme un correctif de connexion ou
du crash AutoFill.** La base sans spoof reste conservée dans sa release propre.

## Utilisation

1. Signer et installer `Snapchat_DiagnosticLogin_unsigned.ipa` comme les IPA
   précédentes, en conservant le framework inclus.
2. Saisir manuellement les identifiants pour éviter le crash AutoFill déjà
   constaté. Effectuer un essai de connexion.
3. Ouvrir le bouton **Diagnostic** en haut à droite, puis **Partager le rapport**.
4. Transmettre le fichier `Snapchat-login-diagnostic.json` pour poursuivre
   l'analyse. Si le bouton n'apparaît pas, signaler ce fait ; le module peut ne
   pas avoir été chargé après signature.

Le panneau doit afficher **7/7 observateurs**. Un nombre inférieur est aussi
utile à signaler : un observateur refuse de s'installer si sa classe, sa méthode,
sa signature d'appel ou l'origine de son implémentation ne correspondent pas.

## Données et comportement

Le module conserve en mémoire au maximum 80 événements : envoi par le chemin
mot de passe ou AppLogin, présence d'une réponse, code d'erreur de transport,
statut protocolaire et codes de retour de trois méthodes natives du trousseau.
La dernière réponse et la dernière erreur de trousseau inhabituelle restent
disponibles même si la liste atteint sa limite. Le code `-25300` reste dans le
rapport mais n'est pas présenté comme une erreur inhabituelle dans le panneau.

Lors de l'ouverture du panneau, il lit aussi la version d'iOS, les identifiants
de bundle déclarés et trois champs des entitlements XML du binaire signé :
application, équipe et groupes du trousseau. Cette lecture ne valide pas
cryptographiquement la signature ou le profil. Si le signateur n'embarque que
des entitlements DER, cette partie est explicitement marquée indisponible.

Les identifiants saisis, mots de passe, contenus du trousseau, jetons, en-têtes,
corps de requête et textes libres de réponse ne sont pas copiés dans le rapport.
Le module ne possède pas de transport réseau. L'export JSON est créé localement
lorsque l'utilisateur choisit de le partager ; le destinataire est choisi dans
la feuille de partage iOS. Les événements en mémoire disparaissent à la fermeture
du processus. Ce n'est pas un collecteur de traces du crash AutoFill.

Les arguments, pointeurs de sortie, callbacks, retours et exceptions natifs sont
conservés. Les observateurs ajoutent toutefois une petite charge d'exécution et
constituent une instrumentation temporaire, susceptible d'influencer un système
qui détecte les modifications runtime. Il faut donc interpréter ce test comme
une observation d'une variante instrumentée, pas comme une preuve de
comportement identique à l'application officielle.

## Construction et vérification

- Entrée exacte : la release `v12.81.0-native-baseline`, SHA-256
  `dd49ab63e079abac15391bfb7861d69fa876ec1b7d2a2a54b1ac801441e77c92`.
- Ajout d'un framework compilé depuis les sources lisibles dans
  `tools/login_diagnostics/`, avec le SDK iPhoneOS sur le runner macOS.
- Le binaire principal change uniquement pour ajouter sa dépendance dans
  l'espace libre de l'en-tête. Les autres commandes de chargement et tous les
  octets à partir de la première section restent identiques.
- 8 066 fichiers d'origine conservés à l'identique ; deux fichiers ajoutés.
  Aucun plist d'origine n'est modifié. SCRT et les autres anciens ajouts restent
  absents. Aucune substitution DeviceCheck ou d'identité n'est réintroduite.
- Des tests exécutent les sept observateurs avec le runtime Objective-C de
  macOS et des services de test : passage des objets et du `double`, callbacks
  de succès/échec, retours du trousseau, pointeur nul, exceptions, absence de
  secrets dans le JSON et limite de mémoire. Ils ne lancent pas Snapchat.
- Le packager valide l'architecture ARM64/iPhoneOS du framework, ses imports
  limités, les empreintes et tous les fichiers de l'IPA reconstruite avant
  publication. Les hash exacts figurent dans `SHA256SUMS.txt` et
  `login-runtime-diagnostic-result.json`.

Les restrictions de la base subsistent : six extensions contiennent encore des
segments marqués chiffrés, et l'équivalence à une IPA App Store originale n'est
pas certifiée. Le produit est non signé ; son login et son interface sur iPhone
doivent être observés lors de l'essai utilisateur.
