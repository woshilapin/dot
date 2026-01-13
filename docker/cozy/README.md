Initialization
==============

This Cozy is launch on Docker with multiple containers orchestrated with Docker
Compose.

Launch it with

```
docker-compose up
```

Then initialize it with

```
docker exec -it cozy_controller_1 cozy-init.sh
```

Daily maintenance
=================

To stop the containers, you can hit `CTRL-C` when it is has been launched with
in a non-daemon mode.  To launch it in daemon mode, you can use the `-d` option.

```
docker-compose up -d
```

You can then stop it with

```
docker-compose stop
```

Note: every `docker-compose` should be launched from the folder where
`docker-compose.yml` file is.  If not, you can specify which file should be used
with `--file /path/to/docker-compose.yml`.
