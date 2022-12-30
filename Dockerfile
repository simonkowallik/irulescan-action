FROM ghcr.io/simonkowallik/irulescan:latest

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
