FROM alpine:3.8 as builder
SHELL ["/bin/sh", "-o", "pipefail", "-c"]
RUN addgroup -g 1000 -S elm && adduser -u 1000 -S elm -G elm
RUN apk add --no-cache ca-certificates=20171114-r3
RUN wget -O- https://github.com/elm/compiler/releases/download/0.19.0/binaries-for-linux.tar.gz | tar xz -C /bin

FROM scratch
USER elm
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder --chown=1000:1000 /home/elm /home/elm
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /bin/elm /bin/elm
ENTRYPOINT [ "/bin/elm" ]
