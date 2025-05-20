FROM jdxcode/mise:2025.3.6
WORKDIR /src
USER root
COPY ./mise.toml mise.toml
RUN mise trust && mise install

# Additional tools/plugins.
# If the list additional tools outside of mise is growing,consider encapsulating them in a script.
RUN helm plugin install https://github.com/jkroepke/helm-secrets --version v4.6.4

ENTRYPOINT [ "" ]