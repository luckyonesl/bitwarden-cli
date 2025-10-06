# bitwarden-cli

This repository creates a small container used in conjunction with the external secrets provider.

## Automated Build and Release

This project uses GitHub Actions to automatically:
- Build the Docker image on every push to master/main
- Test the Docker image to ensure it works correctly
- Publish the image to GitHub Container Registry (ghcr.io)
- Create releases when version tags are pushed

### Container Registry

The Docker images are automatically published to:
```
ghcr.io/luckyonesl/bitwarden-cli
```

### Pulling the Image

Pull the latest image:
```bash
docker pull ghcr.io/luckyonesl/bitwarden-cli:latest
```

Pull a specific version:
```bash
docker pull ghcr.io/luckyonesl/bitwarden-cli:v1.0.0
```

## Usage

Run the container with the required environment variables:

```bash
docker run -d \
  -e BW_CLIENTID=your_client_id \
  -e BW_CLIENTSECRET=your_client_secret \
  -e BW_PASSWORD_FILE=/secrets/password \
  -e BW_SERVER=https://your.bitwarden.server \
  -v /path/to/password:/secrets/password \
  -p 8087:8087 \
  ghcr.io/luckyonesl/bitwarden-cli:latest
```

### Required Environment Variables

- `BW_CLIENTID`: Bitwarden API client ID
- `BW_CLIENTSECRET`: Bitwarden API client secret
- `BW_PASSWORD_FILE`: Path to file containing the master password
- `BW_SERVER`: URL of your Bitwarden server

### Ports

The container exposes port 8087 for the Bitwarden CLI server.

## Creating a Release

To create a new release:

1. Tag the commit with a version number:
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. The GitHub Actions workflow will automatically:
   - Build the Docker image
   - Push it to the container registry with the version tag
   - Create a GitHub release with release notes

## Development

### Building Locally

Build the Docker image locally:
```bash
docker build -t bitwarden-cli:local .
```

### Testing Locally

Test the image (note: you'll need valid credentials):
```bash
docker run --rm bitwarden-cli:local bw --version
```

