# 01 — Les contrôles automatiques

## Ce que fait ce code
À chaque push, GitHub Actions vérifie la sécurité (Brakeman, bundler-audit), le style (RuboCop), les règles de la méthode (`bin/controles`), puis joue les tests, dont un parcours de connexion dans un vrai navigateur. Une PR vers `main` ne peut pas être fusionnée si ces contrôles sont rouges.

## Pourquoi ce choix
Le code produit avec l'IA passe les mêmes contrôles que le reste ; les erreurs mécaniques sont attrapées par la machine, et la relecture humaine se concentre sur la logique (décision 0005).

## Alternative écartée
Relire à l'œil seulement : lent, et les mêmes erreurs repassent.

## Notions en jeu
- **CI** (intégration continue) : chaque modification est vérifiée automatiquement sur un serveur neutre.
- **Test système** : Capybara pilote Chrome sans écran, clique et remplit les formulaires comme un utilisateur.
- **`show_exceptions = :none`** en test système : une erreur serveur fait échouer le test au lieu d'afficher une page d'erreur.

## Fichiers touchés
`.github/workflows/ci.yml`, `config/ci.rb`, `bin/controles`, `bin/recette`, `test/application_system_test_case.rb`, `test/system/connexion_test.rb`.

## Questions de jury
1. **Que se passe-t-il si un test échoue sur une PR ?** La CI est rouge, GitHub bloque la fusion vers `main` : rien n'arrive en production.
2. **Pourquoi un test système en plus des tests d'intégration ?** Il vérifie le lien entre le front et le back dans un vrai navigateur (JavaScript, Turbo, formulaires). Les tests d'intégration sont plus rapides et couvrent les variantes.
3. **Comment prouver que les tests passaient à un moment donné ?** `bin/recette` écrit dans le journal la commande, le résultat et le commit testé.
