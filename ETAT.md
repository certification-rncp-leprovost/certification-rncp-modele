# ÉTAT — Certification RNCP — mis à jour le 20/11 10:30

## Épreuve en cours
Aucune : dépôt modèle, préparation.

## Fait (dernier commit : voir `git log -1`)
- Application Rails 8.1 vierge : PostgreSQL, Devise (User), Pundit, Simple Form, Bootstrap, français.
- Page d'accueil publique, tout le reste fermé par défaut (connexion + policy obligatoires).
- 5 tests verts (accueil, connexion, refus d'un mauvais mot de passe).
- CI GitHub Actions : Brakeman, bundler-audit, RuboCop, tests, tests système.
- Production prévue sur une seule base (Scalingo).
- Documentation : décisions 0001 à 0004, procédures, gabarits de livrables.

## Décisions prises
- 0001 Socle technique Rails 8 + PostgreSQL + Devise + Pundit
- 0002 Une seule base en production
- 0003 Sécurité fermée par défaut
- 0004 Branches develop / staging / main

## En cours / prochaine étape
- Protéger `main`, créer `develop` et `staging`, tableau Kanban.
- Tester un premier déploiement Scalingo depuis le modèle.

## Problèmes ouverts
- Vérifier que la version de Ruby (`.ruby-version`) est installée sur le poste de Silvère.

## Critères non encore couverts
- Tous ceux qui dépendent du sujet (voir la page Pilotage).

## Livrables : prêt / à exporter / déposé
- Aucun (sujet inconnu).
