# Collaboration : branches, pull requests, revues

## Le cycle d'une fonctionnalité

1. **Issue** sur le tableau Kanban (colonne « À faire »), avec la user story et les critères d'acceptation.
2. **Branche** depuis `develop` : `feat/<numero>-<sujet>` ou `fix/<numero>-<sujet>`.
3. **Commits courts** au message explicite : `feat:`, `fix:`, `test:`, `docs:`, `chore:`.
4. **Tests** écrits avec la fonctionnalité ; `bin/ci` vert en local avant de pousser.
5. **Pull request** vers `develop`, avec le modèle de PR rempli ; carte en « En revue ».
6. **Revue** : relecture du code, des tests, de la fiche d'explication ; questions en commentaire.
7. **Fusion** une fois la CI verte et la revue approuvée ; carte en « Terminé ».
8. **Recette** : `develop` → `staging` ; vérification sur l'environnement de test.
9. **Production** : `staging` → `main` par PR ; déploiement automatique.

## Ce que vérifie une revue

- Le code fait ce que dit l'issue, rien de plus.
- Chaque action est autorisée (`authorize` / `policy_scope`) et testée (cas autorisé, cas refusé).
- Les paramètres reçus sont filtrés (strong params).
- Aucun texte en dur dans les vues : tout est dans `config/locales/fr.yml`.
- Aucun secret dans le code.
- La fiche `docs/explications/` existe et se comprend sans l'auteur.

## Pair programming

Deux rôles qui alternent toutes les 25 minutes : le **pilote** écrit, le **copilote** relit en direct, pose les questions et garde la vue d'ensemble. Avec un assistant IA, l'assistant propose et le développeur tient le rôle de copilote : il relit, questionne, fait tourner les tests et décide.

## Rétrospective (fin de lot)

Trois questions, 15 minutes : qu'est-ce qui a bien marché ? qu'est-ce qui nous a freinés ? que change-t-on au prochain lot ? La réponse à la troisième devient une issue.
