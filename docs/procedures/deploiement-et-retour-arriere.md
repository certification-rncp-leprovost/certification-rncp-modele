# Déploiement et retour arrière

## Déploiement (Scalingo)
1. Une fusion sur `main` déclenche la CI GitHub Actions.
2. Scalingo, relié au dépôt, déploie `main` automatiquement (déploiement automatique activé dans le tableau de bord de l'application).
3. Après le déploiement, `Procfile` lance `rails db:migrate` (`postdeploy`).
4. Vérification : `https://<domaine>/up` répond 200 ; parcours de connexion testé à la main.

Variables d'environnement à définir sur Scalingo : `RAILS_MASTER_KEY`, `APP_HOST`. `DATABASE_URL` est fournie par l'add-on PostgreSQL.

## Retour arrière
Si la production casse après un déploiement :
1. **Rétablir le service** : dans Scalingo, onglet *Deployments*, redéployer le déploiement précédent (ou `scalingo --app <app> deploy` d'une archive précédente).
2. **Si une migration est en cause** : `scalingo --app <app> run rails db:rollback`, seulement si la migration est réversible et n'a pas détruit de données.
3. **Corriger** sur une branche `fix/…`, avec un test qui reproduit le problème, puis suivre le cycle normal.
4. **Consigner** l'incident dans `docs/incidents/` : symptôme, cause racine, correction, filet ajouté.

## Notifications
- GitHub Actions envoie un e-mail en cas d'échec de la CI.
- Scalingo notifie le succès ou l'échec des déploiements (notifications de l'application, par e-mail).
