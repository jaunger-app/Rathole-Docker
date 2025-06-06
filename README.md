# Rathole Docker Image

This directory contains a Dockerfile for building a containerized version of [rathole](https://github.com/rapiz1/rathole), a lightweight and secure reverse proxy.

## Required Parameters

- **Environment Variable `mode`**:  
  Set to either `server` or `client` to specify the operation mode.
- **Config File Mount**:  
  Mount your `config.toml` to `/rathole/config.toml` in the container using `-v /path/to/config.toml:/rathole/config.toml`.
- **Port Mapping (Server Mode, Behind NAT)**:  
    map port `2333` with `-p 2333:2333`.

## Usage

Start the Container

```yaml
# Example: Run as server
docker run -e mode=server -p 2333:2333 -v /path/to/config.toml:/rathole/config.toml jaunger/rathole-test:stable

# Example: Run as client
docker run -e mode=client -v /path/to/config.toml:/rathole/config.toml jaunger/rathole-test:stable
