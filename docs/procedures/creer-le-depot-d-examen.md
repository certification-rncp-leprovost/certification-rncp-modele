# Créer le dépôt d'examen depuis le modèle (jour J, 10 minutes)

Un dépôt créé depuis un modèle reprend les fichiers et les branches, mais **pas** les réglages : la protection de `main`, le tableau Kanban et les accès sont à refaire.

1. **Créer le dépôt** : page du modèle → *Use this template* → *Create a new repository*.
   - Propriétaire : `certification-rncp-leprovost`.
   - Nom : celui imposé par le sujet, sinon `certification-rncp39261-<nom-de-l-app>`.
   - Visibilité : **Public** (le jury ouvre le lien sans compte ; protection de branche gratuite).
   - Cocher **Include all branches** (pour récupérer `develop` et `staging`).
2. **Protéger `main`** : *Settings → Branches → Add rule* → motif `main` → *Require a pull request before merging* (sans approbation obligatoire : candidat seul) → *Require status checks to pass* : `test`, `lint`, `scan_ruby`.
3. **Branche par défaut** : laisser `main`.
4. **Kanban** : relier le dépôt au projet « Certification RNCP - Kanban » de l'organisation (*Projects → Link a project*), ou créer un nouveau projet depuis le modèle Kanban, nommé « Certification RNCP - Kanban - <app> ».
5. **Application Claude** : déjà installée sur toute l'organisation, rien à faire.
6. **Mettre à jour** `README.md` (nom de l'application, lien de production) et `ETAT.md` (épreuve en cours).
7. **Vérifier** : un push sur une branche déclenche la CI ; elle passe au vert.
