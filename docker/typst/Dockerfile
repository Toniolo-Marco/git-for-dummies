# Use GitHub Actions Runner as the base image
FROM debian:stable-slim

ADD ./runner runner

WORKDIR /runner

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["bash", "-c"]

RUN ./bin/installdependencies.sh && apt-get install -y xz-utils jq curl \
    && apt-get autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && curl -L https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz -o typst.tar.xz \
    && tar -xf typst.tar.xz \
    && apt-get purge xz-utils -y \
    && mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/ \
    && rm -rf typst.tar.xz typst-x86_64-unknown-linux-musl

# Verify Typst installation
RUN typst --version

ADD --chmod=754 ./start.sh start.sh

ENTRYPOINT ["bash", "-c", "./start.sh"]

ENV RUNNER_MANAGER_TOKEN=""
ENV RUNNER_NAME=""
ENV REPO_NAME=""
ENV REPO_OWNER=""
ENV ACTIONS_RUNNER_INPUT_REPLACE=true
ENV RUNNER_ALLOW_RUNASROOT=true
