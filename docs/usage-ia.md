# Usage de l'assistant IA

## Outil
Claude (Anthropic), en deux conversations aux rôles séparés : l'une produit le code, l'autre explique, rédige les livrables écrits et contrôle la cohérence entre les deux.

## Bonnes pratiques appliquées
- **Le développeur décide.** L'assistant propose ; chaque proposition est relue, testée et comprise avant d'être gardée.
- **Petites étapes.** Une fonctionnalité à la fois, tests compris, fiche d'explication à chaque commit.
- **Contrôles automatiques.** Tests, RuboCop, Brakeman et bundler-audit tournent à chaque push : le code produit par l'IA passe les mêmes contrôles que le reste.
- **Traçabilité.** Les décisions sont écrites (`docs/decisions/`) ; ce journal dit ce qui a été produit avec l'IA et ce qui a été corrigé ou refusé.

## Limites connues et parades
| Limite | Parade |
|---|---|
| Code plausible mais faux | Tests écrits avec la fonctionnalité, relecture ligne à ligne |
| Failles de sécurité (accès oublié, injection) | Sécurité fermée par défaut (décision 0003), Brakeman en CI |
| Accessibilité oubliée | Vérification WCAG dans la revue : contrastes, libellés, navigation au clavier |
| Ignorance du contexte métier | Le besoin est écrit dans l'issue avant de demander du code |
| Fuite de données | Aucune clé, aucun mot de passe, aucune donnée personnelle réelle donnés à l'assistant |

## Journal
| Date | Ce que l'IA a produit | Ce que le développeur a décidé, corrigé ou refusé |
|---|---|---|
| 20/11 | Squelette du dépôt modèle, configuration, documentation | Choix de l'organisation GitHub, des noms, de la visibilité publique, de Scalingo ; relecture de la configuration |
| 20/11 | Contrôles automatiques, filets des tests système, mise à jour des actions GitHub | Choix de la configuration RuboCop officielle de Rails, sans rien du template Le Wagon ; liste des tests à valider ensemble |
