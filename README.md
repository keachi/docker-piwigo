# Piwigo

Host and share your photos with Piwigo.

Piwigo is photo gallery software for the web, built by an active community of users and developers.

Extensions make Piwigo easily customizable. Icing on the cake, Piwigo is free and opensource.

Browse the demo to discover Piwigo features on gallery side and change graphical theme on the fly.

## ENVIRONMENT

### DATABASE

* **MYSQL\_HOST**:
  MySQL Server.
  Default: ``db``,
  Possible Values: "FQDN or IP"
* **MYSQL\_USER**:
  MySQL User.
  Default: ``piwigo``,
  Possible Values: "&lt;string&gt;"
* **MYSQL\_PASSWORD**:
  MySQL Password.
  Default: "&lt;empty&gt;",
  Possible Values: "&lt;string&gt;"
* **MYSQL\_BASE**:
  MySQL Database.
  Default: ``piwigo``,
  Possible Values: "&lt;string&gt;"
* **MYSQL\_PREFIX**:
  MySQL Table Prefix.
  Default: "&lt;empty&gt;",
  Possible Values: "&lt;string&gt;"

## DOCKER COMPOSE

```YAML
version: '2'

volumes:
  db:
  data:
  upload:

services:

  db:
    image: mariadb
    restart: always
    volumes:
      - db:/var/lib/mysql
    env_file:
      - db.env

  app:
    image: keachi/piwigo
    restart: always
    links:
      - db
    depends_on:
      - db
    expose:
      - 80/tcp
    volumes:
      - data:/var/www/html/_data
      - upload:/var/www/html/upload
```
