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


check composer 
    - docker compose ps
check php and composer
    - docker compose exec php php -v
check composer version
    - docker compose exec php composer --version
tes Nginx 
    - docker compose run --rm nginx nginx -t


PHP 8.3.33
Magento CLI 2.4.8-p3

connect the musql
    - docker compose exec mysql mysql -u root -p

docker compose exec php bin/magento setup:install --base-url=http://localhost:8080/ --db-host=mysql --db-name=myPouch --db-user=root --db-password='initial#01' --admin-firstname=Admin --admin-lastname=User --admin-email=admin@example.com --admin-user=admin --admin-password='Admin123456!' --language=en_US --currency=USD --timezone=Asia/Kolkata --use-rewrites=1

while file permission issues

docker compose exec php sh -c "mkdir -p var/page_cache var/cache var/log generated pub/static pub/media && chmod -R 777 var generated pub/static pub/media"

http://localhost:8080/admin_fp72ohu
    Username: admin
    Password: Admin123456!

cmds
docker compose exec php bin/magento setup:upgrade
docker compose exec php bin/magento setup:di:compile
docker compose exec php bin/magento setup:static-content:deploy -f en_US
docker compose exec php bin/magento cache:flush
docker compose restart php nginx
docker compose exec php bin/magento cache:status
docker compose exec php bin/magento indexer:reindex

docker compose exec php bin/magento module:disable Magento_AdminAdobeImsTwoFactorAuth Magento_TwoFactorAuth

docker compose exec php bin/magento info:adminuri
docker compose logs --tail=100 php
docker compose exec php sh -c "tail -100 var/log/system.log"
docker compose exec php sh -c "tail -100 var/log/exception.log"