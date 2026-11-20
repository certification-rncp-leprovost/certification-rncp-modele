# 0002 — Une seule base de données en production

**Date** : 20 novembre 2026 · **Statut** : adoptée

## Contexte
Rails 8 prévoit par défaut quatre bases en production : l'application, le cache (Solid Cache), la file de tâches (Solid Queue) et les WebSockets (Solid Cable). L'hébergeur (Scalingo) fournit une seule base PostgreSQL par application, via `DATABASE_URL`.

## Décision
- Une seule base en production, lue dans `DATABASE_URL`.
- Cache en mémoire (`:memory_store`), tâches de fond dans le processus web (`:async`), WebSockets en mémoire (`async`).
- Gems Solid Cache, Solid Queue et Solid Cable retirées.

## Alternatives écartées
- Quatre bases : quatre add-ons à payer et à configurer, sans bénéfice à l'échelle d'une application d'examen.
- Solid Queue dans la base principale : possible, mais demande de convertir ses schémas en migrations ; à faire si l'application a besoin de tâches qui survivent à un redémarrage.

## Conséquences
- Une tâche de fond en cours est perdue si le serveur redémarre : acceptable pour des e-mails de notification.
- Réversible : réinstaller Solid Queue si le besoin apparaît.
