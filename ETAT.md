# ÉTAT — Certification RNCP — mis à jour le 20/11 11:40

## Épreuve en cours
Aucune : dépôt modèle, préparation.

## Fait (dernier commit : voir `git log -1`)
- Application Rails 8.1 vierge : PostgreSQL, Devise (User), Pundit, Simple Form, Bootstrap, français.
- Page d'accueil publique, tout le reste fermé par défaut (connexion + policy obligatoires).
- 5 tests verts (accueil, connexion, refus d'un mauvais mot de passe).
- CI GitHub Actions : Brakeman, bundler-audit, RuboCop, tests, tests système.
- Production prévue sur une seule base (Scalingo).
- Documentation : décisions 0001 à 0004, procédures, gabarits de livrables.
- GitHub : dépôt public marqué « modèle », branches develop et staging, `main` protégée (PR + contrôles test, lint, scan_ruby), tableau « Certification RNCP - Kanban » de l'organisation.
- Contrôles automatiques : `bin/controles` (CI et `bin/ci`), `bin/recette` (journal des recettes), test système de connexion avec filets (exception serveur, console JS).
- Procédure du jour J : `docs/procedures/creer-le-depot-d-examen.md`.

## Décisions prises
- 0001 Socle technique Rails 8 + PostgreSQL + Devise + Pundit
- 0002 Une seule base en production
- 0003 Sécurité fermée par défaut
- 0004 Branches develop / staging / main
- 0005 Contrôles automatiques à chaque push

## En cours / prochaine étape
- Tester un premier déploiement Scalingo depuis le modèle.

## Problèmes ouverts
- Vérifier que la version de Ruby (`.ruby-version`) est installée sur le poste de Silvère.

## Critères non encore couverts
- Tous ceux qui dépendent du sujet (voir la page Pilotage).

## Livrables : prêt / à exporter / déposé
- Aucun (sujet inconnu).
