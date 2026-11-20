# 0005 — Contrôles automatiques à chaque push

**Date** : 20 novembre 2026 · **Statut** : adoptée

## Contexte
Le code est produit en grande partie avec un assistant IA. Les erreurs mécaniques (style en ligne, `html_safe`, paramètres trop larges, erreurs avalées, autorisation oubliée) reviennent souvent dans du code généré et passent facilement une relecture rapide.

## Décision
Chaque push lance, dans GitHub Actions et dans `bin/ci` en local :
1. **Sécurité** : Brakeman (failles dans le code), bundler-audit (failles connues dans les gems).
2. **Style** : RuboCop, configuration officielle de Rails (`rubocop-rails-omakase`).
3. **Contrôles de la méthode** : `bin/controles` (vues, Ruby, styles, contrôleurs, robustesse, autorisations). Une exception se justifie sur la ligne : `controles: ok <raison>`.
4. **Tests** : unitaires et d'intégration (`bin/rails test`), puis tests système dans un vrai navigateur, avec deux filets : une exception serveur fait échouer le test, une erreur dans la console JavaScript aussi.

`bin/recette` lance ces vérifications et écrit une ligne horodatée dans `docs/journal/recettes.jsonl` (commande, résultat, commit) : la preuve que les tests passaient, écrite par la machine.

## Alternatives écartées
- Se fier aux tests seuls : ils ne voient pas une règle CSS en ligne ni un `rescue nil`.
- Configuration RuboCop maison : la configuration officielle de Rails est le standard partagé, sans débat de style.

## Conséquences
- `main` n'accepte une PR que si `test`, `lint` et `scan_ruby` sont verts.
- Un contrôle rouge se corrige ou se justifie dans le code, jamais en le désactivant.
