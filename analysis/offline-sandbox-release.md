# SnapLab 0.1 — laboratoire entièrement local

Cette release contient **une application de test distincte**, compilée depuis
les sources `tools/offline_sandbox/`. Ce n'est pas l'ancienne IPA Snapchat
réparée, ni une connexion à son service. Elle permet de tester un profil fictif,
un DeviceCheck simulé et une interface UIKit propre sans les anciens ajouts.

## Installer et tester

1. Signer `SnapLab_Offline_unsigned.ipa` puis l'installer comme une application
   séparée. iOS 15 ou ultérieur est requis.
2. Utiliser **Remplir la démo** ou saisir `demo` et `sandbox`.
3. Choisir le scénario **Autorisé**, **Bloqué** ou **Erreur**, puis lancer le
   test local. Ces états concernent uniquement le simulateur interne.
4. Pour tester le clavier : passer du premier champ au mot de passe avec
   **Suivant**, puis utiliser **Accéder** pour fermer le clavier et exécuter
   le scénario. Le mot de passe reste masqué.

Le profil affiché est `iPhone 12 mini / iPhone13,1 / SIM12MINI002`. Il s'agit
d'une fixture dans le modèle local ; l'application ne modifie aucune réponse
matérielle d'iOS. Le service simulé ne produit aucun jeton Apple ou Snapchat.

N'utiliser que les identifiants de démonstration. Les champs ne sont ni
journalisés, ni enregistrés dans le trousseau, ni envoyés sur un réseau.
Réinitialiser efface les champs locaux ; quitter le processus les abandonne.

## Clavier et portée des vérifications

Les champs utilisent les API UIKit publiques, les types de contenu username
et password, le masquage natif et le guide de disposition du clavier. Aucun
hook de classe privée, modification de mémoire CoreFoundation ou remplacement
de SecureTextEntry n'est utilisé. L'interface ne réécrit pas les champs pendant
la saisie et n'affiche pas de boîte de dialogue lors de la fermeture du clavier.

Le workflow exécute les assertions du modèle avec le runtime Apple, compile
l'application pour iPhone et pour le simulateur, puis vérifie les scénarios,
le passage du focus, la soumission et la conservation du masquage dans UIKit.
Il vérifie également les imports, l'absence de code de test dans le binaire
iPhone et tous les fichiers de l'IPA. Les résultats exacts sont joints à la
release ; leur présence ne vaut pas test sur un iPhone physique.

**Le remplissage automatique via Face ID réel n'est pas testé par ces assertions.
Le crash et le refus `ErrBlocked` de l'ancienne IPA restent non résolus.** Cette
cible séparée fournit un contrôle propre pour les comparer. Elle ne remplace
aucune release précédente et n'altère pas l'installation existante.
