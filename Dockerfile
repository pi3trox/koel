# Usa un'immagine base con PHP e Composer
FROM php:8.0-cli

# Installa dipendenze di sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && docker-php-ext-install zip pdo_mysql mbstring exif pcntl bcmath gd curl

# Installa Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Installa Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Crea una directory per l'applicazione
WORKDIR /app

# Copia il codice dell'applicazione
COPY . .

# Installa le dipendenze PHP
RUN composer install --ignore-platform-reqs --no-scripts

# Installa le dipendenze JavaScript
RUN npm install

# Esponi la porta 8000 (usata da php artisan serve)
EXPOSE 8000

# Avvia il server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
