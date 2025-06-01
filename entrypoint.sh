#!/bin/bash
set -e

# Проверяем доступность базы данных
until PGPASSWORD=$PG_USER_PASSWORD psql -h "$PG_HOST" -U "$PG_USER_NAME" -d "covena_ai_development" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# Выполняем миграции
rails db:migrate

# Запускаем основной процесс
exec "$@"
