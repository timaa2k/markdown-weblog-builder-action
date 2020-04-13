FROM nixos/nix

RUN mkdir -p /build
COPY . .

ENTRYPOINT ["./entrypoint.sh"]
