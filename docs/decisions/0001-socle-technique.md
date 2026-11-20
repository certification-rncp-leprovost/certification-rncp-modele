# 0001 — Socle technique : Rails 8, PostgreSQL, Devise, Pundit

**Date** : 20 novembre 2026 · **Statut** : adoptée

## Contexte
Il faut une base de travail prête avant l'épreuve, conforme aux attentes du titre : base relationnelle, authentification par une bibliothèque maintenue, sécurité dès le départ, front responsive.

## Décision
- **Ruby on Rails 8.1** : cadre étudié pendant la formation, conventions fortes, sécurité par défaut (protection CSRF, échappement HTML, requêtes paramétrées).
- **PostgreSQL** : base relationnelle demandée par le référentiel (PostgreSQL ou MySQL), même moteur en développement, en test et en production.
- **Devise** : authentification open source, maintenue, mots de passe chiffrés avec bcrypt, réinitialisation et confirmation prêtes.
- **Pundit** : autorisations explicites, une policy par modèle, testables.
- **Simple Form + Bootstrap 5** (compilé avec Sass via cssbundling) : formulaires lisibles, mise en page responsive sans CSS sur mesure.
- **Minitest** : framework de test par défaut de Rails, celui de la formation.

## Alternatives écartées
- RSpec : cité par le référentiel en exemple, mais Minitest est le standard Rails et celui de la formation ; pas de gain à changer la veille de l'examen.
- Tailwind : moins de composants prêts que Bootstrap pour produire vite une interface propre.
- Authentification générée par Rails 8 (`rails generate authentication`) : plus légère, mais sans inscription ni réinitialisation complètes ; Devise couvre plus, plus vite.

## Conséquences
- Toute nouvelle ressource passe par une policy Pundit.
- Le CSS se compile avec Node et Yarn (`bin/dev` le fait automatiquement).
