FROM ruby:3.2.3

# Устанавливаем системные зависимости, Node.js и Yarn
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    postgresql-client \
    vim && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Создаем и настраиваем рабочую директорию
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Копируем зависимости и устанавливаем гемы
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Копируем весь код проекта
COPY . .

# Копируем и делаем исполняемым entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Настраиваем переменные окружения
ENV RAILS_ENV=development
ENV DATABASE_URL=postgres://postgres@postgres:5432/covena_ai_development

# Собираем фронтенд-зависимости (если используется)
RUN if [ -f package.json ]; then yarn install; fi
RUN if [ -f bin/rails ]; then rails assets:precompile; fi

# Открываем порт для веб-сервера
EXPOSE 3000

# Команда для запуска сервера
CMD ["rails", "server", "-b", "0.0.0.0"]
