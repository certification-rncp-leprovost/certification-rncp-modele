# 00 — Le socle de l'application

## Ce que fait ce code
L'application démarre avec une page d'accueil publique et un système de comptes (inscription, connexion, déconnexion). Tout le reste est fermé : il faut être connecté, et chaque action doit vérifier les droits de l'utilisateur.

## Pourquoi ce choix
Fermer par défaut transforme un oubli de sécurité en erreur visible dans les tests, au lieu d'une faille silencieuse en production (décision 0003).

## Alternative écartée
Ouvrir par défaut et protéger page par page : plus rapide au début, mais chaque oubli devient une faille.

## Notions Rails en jeu
- `before_action` : code exécuté avant chaque action du contrôleur.
- `after_action` : code exécuté après ; ici, vérifier qu'on a bien appelé `authorize`.
- Devise : `authenticate_user!`, `current_user`, `user_signed_in?`.
- Pundit : `authorize @objet` (une ressource), `policy_scope(Modele)` (une liste).
- i18n : les textes affichés sont dans `config/locales/fr.yml`, appelés par `t(".cle")`.

## Fichiers touchés
`app/controllers/application_controller.rb`, `app/controllers/pages_controller.rb`, `app/views/layouts/application.html.erb`, `app/views/shared/`, `config/locales/fr.yml`, `config/routes.rb`, `test/`.

## Questions de jury
1. **Que se passe-t-il si un développeur oublie `authorize` dans une action ?** Pundit lève `AuthorizationNotPerformedError` : le test de cette action échoue, l'oubli est repéré avant la production.
2. **Différence entre authentification et autorisation ?** L'authentification vérifie qui tu es (Devise). L'autorisation vérifie ce que tu as le droit de faire (Pundit).
3. **Pourquoi un lien « Aller au contenu » invisible ?** Pour l'accessibilité : au clavier, il permet de sauter le menu et d'aller directement au contenu (WCAG).
