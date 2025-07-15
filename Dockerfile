FROM cgr.dev/chainguard/glibc-dynamic:latest-dev AS dev-container

FROM ghcr.io/simonkowallik/irulescan@sha256:ddf62a70606f3f52133ddb2c5fc4fe43de3ae0d3094def48ca237390a94a659d AS irulescan-container

#FROM cgr.dev/chainguard/glibc-dynamic:latest as target-container
FROM scratch
COPY --from=irulescan-container / /

# busybox for entrypoint.sh
COPY --from=dev-container /bin/busybox /bin/busybox
# busybox command aliases
COPY --from=dev-container /bin/sh /bin/sh
COPY --from=dev-container /bin/cat /bin/cat
COPY --from=dev-container /usr/bin/realpath /usr/bin/realpath
# busybox depends on libxcrypt
COPY --from=dev-container /usr/lib/libcrypt.so* /usr/lib/
# sbom
COPY --from=dev-container /var/lib/db/sbom/busybox* /var/lib/db/sbom/
COPY --from=dev-container var/lib/db/sbom/libxcrypt* /var/lib/db/sbom/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
