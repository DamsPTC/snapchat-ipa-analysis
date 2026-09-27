
## Correctifs de cohérence du spoof

Le spoof existant est conservé. Les modifications de SCRT sont limitées à :

- Valider l’UUID mémorisé avant de le réutiliser. Une valeur absente ou invalide
  est remplacée une seule fois et enregistrée ; un UUID valide reste inchangé.
- Effectuer les effacements automatiques du hook de connexion **après** la
  réussite de la vérification propre au composant. Ce contrôle n’est pas la
  validation du mot de passe par Snapchat. Les effacements restent présents.
- Utiliser le même profil `iPhone13,1 / iOS 17.5.1` dans les deux constructeurs
  de User-Agent. Leur initialisateur reste désactivé ; ce correctif est latent.
- Remplacer les anciennes constantes iPhone X des listes d’exemption par un
  profil fictif iPhone 12 mini : build `21F90`, série `SIM12MINI001`,
  UDID `00008101-0000000000000001`. Ces identifiants sont inventés pour le test.

Le profil est documenté dans
[tools/spoof_fix/iphone12-mini.json](tools/spoof_fix/iphone12-mini.json).
Les valeurs série/UDID/modèle servent à comparer l’appareil à une liste
d’exemption interne ; elles ne remplacent pas les informations renvoyées par iOS.

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
