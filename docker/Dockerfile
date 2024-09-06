# Use GitHub Actions Runner as the base image
FROM ghcr.io/actions/actions-runner:latest

# Install Curl
RUN sudo apt-get update && sudo apt-get install -y curl xz-utils \
    && sudo apt-get clean \
    && sudo rm -rf /var/cache/apt/archives/*

# Install Typst
RUN curl -L https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz -o typst.tar.xz \
    && tar -xf typst.tar.xz \
    && sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/ \
    && rm -rf typst.tar.xz typst-x86_64-unknown-linux-musl

# Verify Typst installation
RUN typst --version

# Set entrypoint for GitHub runner
ENTRYPOINT ["/runner/entrypoint.sh"]
