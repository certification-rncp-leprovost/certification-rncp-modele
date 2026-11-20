# Règles pour Claude — Certification RNCP39261

1. Avant toute action, lire `ETAT.md`, puis le skill `certif-rncp-le-wagon` s'il est disponible.
2. Méthode de développement : skills `rails-methode` et `rails-controles`.
3. À chaque commit : une fiche `docs/explications/NN-sujet.md` (ce que fait le code, pourquoi, alternative écartée, notion Rails, fichiers touchés, 3 questions de jury avec réponse).
4. Tout choix structurant : une note `docs/decisions/NNNN-titre.md`.
5. Tout usage notable de l'IA : une ligne dans `docs/usage-ia.md`.
6. Mettre à jour `ETAT.md` à chaque commit.
7. Aucun push, merge ou déploiement sans le go explicite de Silvère.
8. Code lisible sans l'IA : conventions Rails, noms explicites, commentaires sur le pourquoi, textes dans `config/locales/fr.yml`.
9. Chaque action de contrôleur appelle `authorize` (ou `policy_scope` pour une liste) : `verify_authorized` le vérifie.
