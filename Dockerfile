FROM nixos/nix

COPY . /

ENTRYPOINT ["/entrypoint.sh"]
