FROM alpine:3.5

ENV TERRAFORM_VERSION 0.9.6
ENV GLIBC_VERSION 2.25-r0

RUN apk add -Uu bash tzdata groff less python py-pip wget ca-certificates unzip git bash && \
    wget -q "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
    apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk && \
    wget -q -O /terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip /terraform.zip -d /bin && \
    mkdir -p /aws && \
    pip install awscli && \
    apk del --purge wget ca-certificates unzip py-pip && \
    rm -rf /var/cache/apk/* /terraform.zip glibc-${GLIBC_VERSION}.apk

RUN adduser -h /var/jenkins_home -s /bin/bash -G nogroup -D -H -u 1000 terraform

USER terraform

VOLUME /data

WORKDIR /data

ENTRYPOINT ["/bin/terraform"]

CMD ["--help"]
