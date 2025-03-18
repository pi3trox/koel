# Usa un'immagine base con PHP e Composer
FROM php:8.0-cli

# Installa Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Installa Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia il codice dell'applicazione
COPY . /app
WORKDIR /app

# Installa le dipendenze PHP e JavaScript
RUN composer install
RUN npm install
RUN npm run prod

# Esponi la porta 8000 (usata da php artisan serve)
EXPOSE 8000

# Avvia il server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
