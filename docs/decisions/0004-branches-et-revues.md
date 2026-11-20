# 0004 — Branches develop / staging / main et revues de code

**Date** : 20 novembre 2026 · **Statut** : adoptée

## Contexte
Le référentiel (BC02) demande des branches dédiées au développement, au test et à la production, une procédure de PR et de revue documentée, et des branches principales protégées.

## Décision
- `develop` : intégration ; chaque fonctionnalité arrive par PR depuis `feat/…`.
- `staging` : environnement de test ; reçoit `develop` quand un lot est prêt à être recetté.
- `main` : production, déployée automatiquement ; ne reçoit que `staging` par PR relue avec CI verte.
- Une issue = une branche = une PR, avec le modèle `.github/pull_request_template.md`.

## Alternatives écartées
- Une seule branche `main` (trunk-based) : plus simple, mais ne montre pas la séparation test / production demandée.

## Conséquences
- Seul candidat sur le projet : la relecture obligatoire de `main` est faite par Silvère sur le travail produit avec l'assistant IA (voir `docs/collaboration.md`).
