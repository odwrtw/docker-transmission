## Installation

Copy the configuration files and edit them to suit your needs.

```sh
cp settings.json.example settings.json
cp docker-compose.yml.example docker-compose.yml
```

## UID && GID

You can set your user's UID and GID to write to the docker volumes with the proper rights. Just set the UID and GID environment vars in the docker-compose file.

## Build

```sh
docker-compose build
```

## Run

```sh
docker-compose up -d
```

