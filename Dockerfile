FROM gliderlabs/alpine:3.3
COPY openvpn_exporter /
ENTRYPOINT ["/openvpn_exporter"]
