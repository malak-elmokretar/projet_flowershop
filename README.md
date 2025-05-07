
# Projet E6 : Site de e-commerce

Projet effectué au cours de la deuxième année de [BTS SIO](https://www.onisep.fr/ressources/univers-formation/formations/post-bac/bts-services-informatiques-aux-organisations-option-b-solutions-logicielles-et-applications-metiers) dans le cadre de l'épreuve E6. Site de e-commerce pour un fleuriste fictif localisé en PACA spécialisé dans la vente de fleurs locales et biologiques.
## Lessons Learned

What did you learn while building this project? What challenges did you face and how did you overcome them?


## Documentation

[Documentation](https://linktodocumentation)


## License

[MIT](https://choosealicense.com/licenses/mit/)


## Roadmap

- Additional browser support

- Add more integrations


## Technologies utilisées

**Client:** Twig, JavaScript, Bootstrap, CSS

**Serveur:** PHP, SQL (MySQL)

## Outils utilisés

Sur `Windows`

- **WampServer** (versions : **WAMPServer** version 3.3.5, **PHPMyAdmin** version 5.2.1, **PHP** version 8.3.6)

- **Git** (Version : 2.49.0) et **Github**
## Run Locally

Sur `Windows`

Installer [WAMP SERVER](https://www.wampserver.com/) [(Voir les paramètres)](#)

Cloner le projet

```bash
  git clone https://github.com/malak-elmokretar/projet_flowershop.git
```

Go to the project directory

```bash
  cd projet_flowershop
```

Installer les dépendances dans le dossier `.\lib`

```bash
  cd .\lib
```

Installer Composer

```bash
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL;
unlink('composer-setup.php'); exit(1); }"
  php composer-setup.php
  php -r "unlink('composer-setup.php');" 
```

Installer TWIG

```bash
composer require "twig/twig:^3.0"
```

Démarrer le serveur

***Déploiement de la base de données***

Dans **PHPMyAdmin**, créer un utilisateur autre que root
```bash
  CREATE USER 'malak'@'%' IDENTIFIED WITH caching_sha2_password BY '***'; // insérer le nom de l'utilisateur et son mot de passe que vous souhaitez
  GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, FILE, REFERENCES, ALTER, CREATE VIEW, EVENT, TRIGGER, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON *.* TO 'test'@'%';ALTER USER 'test'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
```

Récupérer le fichier `.\bd\flowers.sql`

Dans **PHPMyAdmin**, créer une base de données `flowers`
```bash
CREATE DATABASE "flowers";
```

Cliquer sur la base de données créée puis cliquer sur *Importer* et importer le fichier `.\bd\flowers.sql`

***Déploiement du site***

Depuis la racine du projet, coller le projet dans `C:\wamp64\www\`

```bash
xcopy . C:\wamp64\www\projet_flowershop /E
```

Dans votre **navigateur**, rechercher l'adresse 
`http://localhost/add_vhost.php`

Remplir l'input "Nom du Virtual Host" : Flowershop

Remplir l'input "Chemin complet absolu du dossier VirtualHost" : `C:\wamp64\www\projet_flowershop`

Cliquer sur "Démarrer la création ou la modification du VirtualHost"

Dans Outils, cliquer sur Redémarrage DNS

Vous pouvez maintenant rechercher sur votre **navigateur** `http://projet_flowershop/public` !
## Features

- Inscription et connexion sécurisées
- Espace administrateur : gestion (modification) des utilisateurs et des produits

## Optimizations

What optimizations did you make in your code? E.g. refactors, performance improvements, accessibility


## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)


## Projet lié

Ce projet est lié au deuxième projet de l'épreuve E5 : l'application mobile Administrateur.

[Retrouvez l'application mobile ici](https://github.com/malak-elmokretar/projet_flowershop_application_mobile)


## Support et feedback

Pour toute demande de support, vous pouvez me contacter par e-mail: elmokretarmalak25@gmail.com.

Si vous souhaitez faire un feedback, contacter par e-mail: elmokretarmalak25@gmail.com.