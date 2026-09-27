# Base sans les injections identifiées

La demande du 27 septembre 2026 remplace la conservation du spoof par sa
suppression. `tools/restore_native.py` produit maintenant une base distincte
de la révision analysée auparavant. L’IPA livrée sous le nom
`Snapchat_Core_nettoyee_unsigned.ipa` est mise à jour avec ce résultat.

**Le spoof est retiré, y compris les substitutions DeviceCheck.** Aucun patch
de cohérence Shield n’est appliqué à cette reconstruction : le framework qui
contenait ces fonctions est supprimé en entier.

## Changements

| Élément | Résultat |
| --- | --- |
| `SCRT.framework` | Framework complet supprimé : hooks IDFV/IDFA, DeviceCheck, Gestalt/exemptions, runtime, réseau, logs, protections et code dormant des ajouts. |
| `SKEngine.dylib` | Module ajouté supprimé. |
| `CydiaSubstrate.framework` | Framework ajouté supprimé. |
| `optool/` | Outillage embarqué supprimé. |
| Binaire `Snapchat` | Les deux dernières dépendances faibles SCRT/SKEngine sont retirées. Les autres commandes de chargement restent identiques ; aucun import ne référence les ordinaux 114/115 retirés. |
| Bundle principal | `CFBundleIdentifier` restauré à `com.toyopagroup.picaboo`, conformément aux champs `ApplicationIdentifier` et `SCKeychainAccessIdentifier` déjà présents dans la source. |
| Six extensions | Même préfixe de bundle rétabli, avec leurs suffixes existants. Cette reconstruction des IDs n’est pas une comparaison avec une référence App Store indépendante. |
| Version minimale déclarée | Plist principal corrigé de `10.0` à `12.4`, valeur de `LC_BUILD_VERSION.minos` dans le binaire. Les six extensions avaient déjà des valeurs cohérentes avec leurs binaires. |
| Autres ressources et exécutables | Conservés à l’identique de l’archive source. |

Le retrait de SCRT enlève également le code de remplacement des API matérielles,
des identifiants, du trousseau, des champs de connexion et des fonctions runtime
qui avait été analysé. Aucune valeur de substitution, aucun faux jeton, aucun
hook de remplacement supplémentaire n’est ajouté à la base.

45 fichiers sont supprimés et 8 sont modifiés : le seul en-tête du binaire
principal et 7 plists. Les 8 059 autres fichiers sont identiques à la source.
L’IPA finale contient 8 067 fichiers, pour 237 330 887 octets non compressés.
Les sections et offsets LINKEDIT du binaire principal ne bougent pas ; tous les
octets après sa table initiale de chargement restent identiques à la source.

## Validation

La recette est liée aux empreintes exactes de l’archive source et des fichiers
modifiés. Elle refuse une autre build, un import pointant vers une bibliothèque
retirée, une préimage inattendue ou une destination existante. Elle reconstruit
le ZIP puis relit chaque fichier pour vérifier taille, CRC et SHA-256.

Une inspection indépendante avec `macholib` vérifie les huit Mach-O conservés,
les dépendances restantes, l’absence des fichiers retirés et le corps inchangé
du binaire principal. La seule dépendance embarquée conservée des extensions
est `ExtensionsSharedDependencies.framework`. Les références connues aux
injections étudiées ne sont plus présentes dans ces huit binaires.

Les tests couvrent la suppression des deux dépendances sans renumérotation,
le refus d’imports liés à ces dépendances, les seuls champs plist modifiés et
une reconstruction complète sur une archive de test. Ce dernier test échoue
si la fonction d’application du spoof est appelée. Les tests historiques des
anciennes révisions restent exécutés pour préserver la reproductibilité.

Les résultats détaillés sont dans
[native-baseline-result.json](native-baseline-result.json) et
[native-baseline-verification.json](native-baseline-verification.json).

## Limites de la remise à l’origine

L’entrée de travail était déjà une IPA modifiée. Aucune IPA officielle de cette
même build n’a été fournie pour comparaison. Les signatures, profils de
distribution et certains éléments avaient été retirés avant cet audit. Leur
contenu original ne peut pas être reconstitué à partir de cette archive.

**Cette base est sans les injections identifiées ; elle n’est pas certifiée
identique à l’originale App Store.** Les éventuelles modifications antérieures
du binaire principal, hors injections observées, ne peuvent pas être exclues
sans référence indépendante.

Les six exécutables d’extensions gardent leur `cryptid=1` et leur plage de
chiffrement source. Ce marquage peut empêcher leur utilisation après une simple
re-signature. Il n’est pas effacé artificiellement ; aucun déchiffrement n’est
effectué. Le résultat reste **non signé, non testé sur iPhone**, sans validation
d’installation, de connexion ou de fonctionnement des extensions.

Cette opération agit sur les fichiers de l’IPA. Elle n’efface pas les préférences
ou éléments du trousseau d’une installation déjà présente sur un appareil.

## Reproduction

```sh
python3 tools/restore_native.py Snapchat_DeviceCheck_etude_unsigned.ipa Snapchat_Core_nettoyee_unsigned.ipa --report native-baseline-result.json
python3 -m unittest discover -s tests -v
```

Le `Payload/` versionné demeure le matériau historique d’analyse v3 avec ses
empreintes et son binaire principal Git LFS de référence. Il n’est pas la nouvelle
base prête à rezipper. Utiliser la recette ci-dessus ou l’IPA reconstruite livrée.
L’ancienne recette `tools/clean_ipa.py` conserve volontairement le noyau spoof
pour reproduire l’étape précédente ; elle ne correspond plus à la demande actuelle.

| Fichier | SHA-256 |
| --- | --- |
| IPA source | `416aa57047ef1aaa77d03d1ca4c69759412b11d8141da877306be94d2bf633e9` |
| Base sans injections | `dd49ab63e079abac15391bfb7861d69fa876ec1b7d2a2a54b1ac801441e77c92` |
| Binaire principal sans dépendances ajoutées | `aaed5609d43bbccbede0eb27646a0215959deb5fc2b258f4e714a6efd1b97b50` |

L’archive livrée fait 94 365 812 octets. La compression peut varier avec la version
de zlib ; les empreintes individuelles des fichiers de la recette font référence.
