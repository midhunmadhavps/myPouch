cd C:\Projects\

mkdir Docker
mkdir Docker\Nginx 
mkdir Docker\PHP 
mkdir Docker\MySQL 
mkdir Docker\OpenSearch 
mkdir Docker\Redis 
mkdir src
mkdir Docker\PHP\Dockerfile.yml
mkdir Docker\Nginx\default.conf

C:\Projects\myPouch
│
├── docker-compose.yml
│
├── docker
|   ├── Nginx
|   ├── PHP
|   ├── MySQL
|   ├── OpenSearch
|   └── Redis
|           ↓
|       Magento
|           ↓
|       myPouch
|
│
└── src


myPouch
│
├── Nginx 1.30
├── PHP 8.5
├── Magento Open Source 2.4.9
├── MySQL 8.4
├── OpenSearch 3
├── Valkey 9
└── RabbitMQ 4.3

Step 1 — Create docker-compose.yml 
You are already inside: C:\Projects\myPouch
Run: notepad docker-compose.yml
RUN: docker compose build php

cd "C:\Users\midhun.s\expressjsproject\myPouch\Docker\PHP"
New-Item -ItemType File -Name Dockerfile

cd "C:\Users\midhun.s\expressjsproject\myPouch"
docker compose build php
creating PHP image built. => get a message ( ✔ Image mypouch-php Built )

Now we'll start the Docker services.
docker compose up -d
docker compose ps

login in magento and create the access keys
RUN :- docker compose exec php bash

open and root 
    You should see something like: root@xxxxxxxx:/var/www/html#
    composer config --global http-basic.repo.magento.com YOUR_PUBLIC_KEY YOUR_PRIVATE_KEY
    ls -la
    composer create-project \
    --repository-url=https://repo.magento.com/ \
    magento/project-community-edition=2.4.8-p3 \
    .