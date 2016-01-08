FROM debian:stable
MAINTAINER Lance Chen <cyen0312@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV CONSUL_VERSION 0.6.1
ENV CONSUL_CHECKSUM_FILENAME consul_${CONSUL_VERSION}_SHA256SUMS
ENV CONSUL_CHECKSUM_SIGNATURE_FILENAME consul_${CONSUL_VERSION}_SHA256SUMS.sig
ENV CONSUL_FILENAME consul_${CONSUL_VERSION}_linux_amd64.zip
ENV HASHICORP_SECURITY_GPG_KEY 91A6E7F85D05C65630BEF18951852D87348FFC4C

RUN apt-get update \
    && apt-get install -y curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gpg --keyserver hkp://pgp.mit.edu --recv-keys $HASHICORP_SECURITY_GPG_KEY \
    && curl -q -O https://releases.hashicorp.com/consul/${CONSUL_VERSION}/{$CONSUL_CHECKSUM_FILENAME,$CONSUL_CHECKSUM_SIGNATURE_FILENAME,$CONSUL_FILENAME} \
    && gpg --verify $CONSUL_CHECKSUM_SIGNATURE_FILENAME \
    && grep $CONSUL_FILENAME $CONSUL_CHECKSUM_FILENAME | sha256sum -c - \
    && unzip $CONSUL_FILENAME consul -d /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/consul"]
CMD ["agent", "-dev", "-client=0.0.0.0"]
