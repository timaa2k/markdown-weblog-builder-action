FROM nixos/nix

RUN mkdir -p /build

COPY . /build

ENTRYPOINT ["/build/entrypoint.sh"]
