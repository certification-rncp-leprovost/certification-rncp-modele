# Sauvegarde et restauration de la base

## Sauvegardes automatiques
L'add-on PostgreSQL de Scalingo fait une sauvegarde quotidienne, conservée selon l'offre choisie. Elles se consultent dans le tableau de bord de la base, onglet *Backups*.

## Sauvegarde manuelle (avant une opération risquée)
```bash
# Ouvre un tunnel vers la base de production
scalingo --app <app> db-tunnel SCALINGO_POSTGRESQL_URL
# Dans un autre terminal, exporte la base au format PostgreSQL
pg_dump --format=custom --no-owner --no-acl \
  "postgres://<user>:<password>@127.0.0.1:10000/<base>" > sauvegarde-$(date +%F).dump
```

## Restauration
```bash
# Sur une base locale de test d'abord, pour vérifier la sauvegarde
createdb restauration_test
pg_restore --no-owner --no-acl --dbname=restauration_test sauvegarde-AAAA-MM-JJ.dump
```
En production, restaurer depuis l'onglet *Backups* de Scalingo (« Restore »), après avoir prévenu les utilisateurs.

## Vérifier qu'une sauvegarde est utilisable
Une sauvegarde qui n'a jamais été restaurée n'est pas une sauvegarde. Après chaque sauvegarde manuelle, la restaurer sur une base locale et compter les lignes des tables principales.
