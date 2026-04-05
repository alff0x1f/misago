#!/bin/bash
set -e

echo "[$(date)] Starting maintenance tasks..."

python manage.py deletemarkedusers
python manage.py prunecategories
python manage.py buildactivepostersranking
python manage.py clearattachments
python manage.py clearnotifications
python manage.py clearreadtracker
python manage.py clearsessions
python manage.py clearsocial
python manage.py invalidatebans
python manage.py removeoldips
python manage.py deleteinactiveusers
python manage.py expireuserdatadownloads
python manage.py prepareuserdatadownloads

echo "[$(date)] Maintenance tasks completed."
