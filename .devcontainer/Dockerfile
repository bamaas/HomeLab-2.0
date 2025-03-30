FROM jdxcode/mise:2025.3.6
WORKDIR /src
USER root
COPY ./mise.toml mise.toml
RUN mise trust && mise install
ENTRYPOINT [ "" ]