## Usage

Create a directory for the configuration on the host, e.g if you're bob create `/home/bob/.config/transmission`.

```sh
docker run \
        --detach \
        --hostname "transmission" \
        --name "transmission" \
        --user "$(id -u):$(id -g)" \
        --restart "unless-stopped" \
        --volume "/home/bob/.config/transmission:/home/transmission/config" \
        --volume "/home/bob/downloads/:/home/transmission/downloads" \
        odwrtw/transmission:latest
```

If you want to configure transmission, launch the container, it will create all the default configuration files. Stop the container and modify those files and launch the container again.
