# Rathole Docker Image

This directory contains a Dockerfile for building a containerized version of [rathole](https://github.com/rapiz1/rathole), a lightweight and secure reverse proxy.

## Required Parameters

- **Environment Variable `mode`**:  
  Set to either `server` or `client` to specify the operation mode.
- **Config File Mount**:  
  Mount your `config.toml` to `/rathole/config.toml` in the container using `-v /path/to/config.toml:/rathole/config.toml`.
- **Port Mapping (Server Mode, Behind NAT)**:  
    map port `2333` with `-p 2333:2333`.

## Important

Run the Container in the Correct Docker Network
To allow the Rathole container to communicate with other containers (for example,
Jellyfin), make sure that all containers run in the same Docker
network. This is necessary because Rathole uses container hostnames
to route traffic between containers.

When configuring the server side, you must forward the ports so that you can access the
services on the local system where the traffic is being tunneled. Otherwise, you will only
be able to access the ports exposed inside the Rathole container itself, not the actual
local services.

## Usage

Start the Container

```yaml
# Example: Run as server
docker run -e mode=server -p 2333:2333 -v /path/to/config.toml:/rathole/config.toml jaunger/rathole-test:stable

# Example: Run as client
docker run -e mode=client -v /path/to/config.toml:/rathole/config.toml jaunger/rathole-test:stable
```

## Example Docker Compose and config.toml snippet with Jellyfin (client side)

### Docker Compose file

```yaml
version: "3.9"
services:
  jellyfin:
    image: jellyfin/jellyfin
    ports:
      - "8096:8096"
    networks:
      - internalnet

  rathole:
    image: jaunger/rathole-test:stable
    environment:
      - mode=client
    ports:
      - "2333:2333"
    volumes:
      - /config/config.toml:/rathole/config.toml
    networks:
      - internalnet

networks:
  internalnet:
```

### config.toml (client side)

```toml
[client]
remote_addr = "server-ip:2333"
#default_token = "test"

[client.services.jellyfin]
token = "token"
local_addr = "jellyfin:8096
```

## Example Docker Compose snippet with Jellyfin (server side)

```yaml
version: "3.9"
services:
  rathole:
    image: jaunger/rathole-test:stable
    ports:
      - "2333:2333"
      - "8096:8096"
    environment:
      - mode=server
    volumes:
      - "/config/config.toml:/rathole/config.toml"
```

### config.toml (server side)

```toml
[server]
bind_addr = "0.0.0.0:2333"
#default_token = "test"

[server.services.jellyfin]
token = "token"
bind_addr = "0.0.0.0:8096"
```
