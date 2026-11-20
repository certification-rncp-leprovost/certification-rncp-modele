# 02 — Les tests modèles du socle

## Ce que fait ce code
Il ajoute des tests qui servent d'exemples pour chaque niveau : le modèle User (validations), l'inscription (création valide qui ajoute un compte, création refusée qui ne change rien), l'accès protégé (visiteur renvoyé vers la connexion). Une clé de traduction manquante lève désormais une erreur en test et en développement.

## Pourquoi ce choix
Mercredi, chaque ressource reprend ces gabarits (`docs/procedures/grille-de-tests.md`) : on gagne du temps et chaque test a un objectif lisible, ce que demande le référentiel.

## Alternative écartée
Une gem de simulation d'API (WebMock) : un faux client passé au service suffit, sans dépendance de plus.

## Notions en jeu
- `assert_difference("User.count", 1)` : vérifie qu'une ligne a bien été ajoutée en base.
- `errors.added?(:email, :blank)` : vérifie la règle précise qui a refusé, pas seulement « invalide ».
- `raise_on_missing_translations` : un texte oublié dans `fr.yml` casse le test au lieu d'afficher « translation missing ».

## Fichiers touchés
`test/models/user_test.rb`, `test/integration/inscription_test.rb`, `test/integration/acces_test.rb`, `test/application_system_test_case.rb`, `config/environments/test.rb`, `config/environments/development.rb`, `docs/procedures/grille-de-tests.md`.

## Questions de jury
1. **Pourquoi tester un cas refusé ?** Une validation qui ne refuse jamais rien passe le test du cas valide ; seul le cas refusé prouve qu'elle protège la base.
2. **Qu'est-ce qu'un test d'accès croisé ?** Bob essaie de modifier la ressource d'Alice ; le test vérifie qu'il est refusé. C'est la faille d'autorisation la plus courante.
3. **Comment testez-vous une API d'IA sans la payer à chaque test ?** Le service reçoit son client en paramètre ; en test, on lui passe un faux client qui renvoie une réponse fixe, puis un client en panne pour vérifier la gestion d'erreur.
