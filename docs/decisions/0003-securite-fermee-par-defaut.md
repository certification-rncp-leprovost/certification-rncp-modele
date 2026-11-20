# 0003 — Sécurité fermée par défaut

**Date** : 20 novembre 2026 · **Statut** : adoptée

## Contexte
L'oubli d'une vérification d'accès est la faille la plus courante d'une application web (contrôle d'accès défaillant, premier risque du classement OWASP).

## Décision
Dans `ApplicationController` :
1. `before_action :authenticate_user!` : toute page demande une connexion, sauf exception déclarée (accueil).
2. `after_action :verify_authorized` : toute action doit appeler `authorize`, sinon Pundit lève une erreur. Un oubli casse les tests au lieu de passer en production.
3. `verify_policy_scoped` sur les listes (`index`) : on ne liste que ce que l'utilisateur a le droit de voir.
4. Un refus renvoie un message clair et la page précédente, jamais une erreur 500.

## Alternatives écartées
- Ouvrir par défaut et fermer au cas par cas : chaque oubli devient une faille silencieuse.

## Conséquences
- Une nouvelle page publique doit le dire explicitement (`skip_before_action :authenticate_user!`).
- Chaque contrôleur a sa policy et ses tests d'accès (autorisé / refusé).
