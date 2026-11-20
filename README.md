# Certification RNCP39261 · Dépôt modèle

Candidat : **Silvère Leprovost** · Titre *Concepteur développeur d'applications web* (RNCP39261, Le Wagon) · 25 et 26 novembre 2026

Ce dépôt est un **modèle** : il ne contient que la configuration et les règles de travail, aucune fonctionnalité. Le dépôt d'examen est créé à partir de lui (« Use this template ») au début des épreuves.

## Ce qui est prêt

| Élément | Rôle |
|---|---|
| Rails 8.1, PostgreSQL | Cadre de l'application, base relationnelle |
| Devise | Inscription, connexion, mots de passe chiffrés (bcrypt) |
| Pundit | Autorisations : une policy par modèle, vérifiée sur chaque action |
| Simple Form + Bootstrap 5 | Formulaires et mise en page responsive |
| Français par défaut | `config/locales/fr.yml`, rails-i18n, devise-i18n |
| Tests Minitest | Contrôleurs, intégration (connexion), système |
| GitHub Actions | Sécurité (Brakeman, bundler-audit), style (RuboCop), tests à chaque push |
| Production sur une base | Prêt pour Scalingo : `Procfile`, `DATABASE_URL` |
| `docs/` | Décisions, explications du code, usage de l'IA, procédures, livrables |

## Installer et lancer

```bash
git clone <url-du-depot>
cd <dossier>
bin/setup          # gems, paquets JS, base de données
bin/dev            # serveur + compilation CSS, http://localhost:3000
bin/rails test     # tests
bin/ci             # toute la chaîne de contrôle locale
```

Prérequis : Ruby (version dans `.ruby-version`), PostgreSQL, Node 22 et Yarn.

## Branches

| Branche | Rôle | Règle |
|---|---|---|
| `main` | Production, déployée automatiquement | protégée : PR relue et CI verte |
| `staging` | Test, recette avant production | fusion depuis `develop` |
| `develop` | Intégration du développement | fusion des branches de fonctionnalité |
| `feat/…`, `fix/…` | Une fonctionnalité ou une correction | une issue = une branche = une PR |

Procédure détaillée : [`docs/collaboration.md`](docs/collaboration.md).

## Documentation

- [`ETAT.md`](ETAT.md) : où en est le projet
- [`docs/decisions/`](docs/decisions/) : le pourquoi de chaque choix structurant
- [`docs/explications/`](docs/explications/) : le code expliqué, étape par étape
- [`docs/usage-ia.md`](docs/usage-ia.md) : comment l'assistant IA a été utilisé et contrôlé
- [`docs/procedures/grille-de-tests.md`](docs/procedures/grille-de-tests.md) : les tests minimum par ressource, avec gabarits
- [`docs/procedures/`](docs/procedures/) : créer le dépôt d'examen, déploiement, retour arrière, sauvegarde et restauration
- [`docs/livrables/`](docs/livrables/) : sources des livrables de chaque bloc
