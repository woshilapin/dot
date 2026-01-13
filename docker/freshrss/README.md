Configuration
=============

When first launched, FreshRSS will ask for configuration.  This Docker Compose
setup is configured to use PostgreSQL.  Here are the credentials to configure to
it.

```
PostgreSQL host         : postgres
PostgreSQL database name: freshrss
PostgreSQL username     : freshrss
PostgreSQL password     : freshrss
```

To update FreshRSS
==================

First of all, stop the application.

```
docker-compose stop
```

Then edit `docker-compose.yml` to update the version of FreshRSS. Then you can
launch the application again.

```
docker-compose up -d
```
