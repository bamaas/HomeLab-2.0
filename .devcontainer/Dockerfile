FROM jdxcode/mise:2025.3.6
WORKDIR /src
USER root
COPY .mise/config.toml mise.toml
RUN mise trust && \
    mise settings experimental=true && \
    mise install
ENTRYPOINT [ "" ]