FROM alpine:3.3

ENV TERRAFORM_VERSION 0.8.4
ENV GLIBC_VERSION 2.23-r3

RUN apk add --update wget ca-certificates unzip git bash && \
    wget -q "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
    apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk && \
    wget -q -O /terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip /terraform.zip -d /bin && \
    apk del --purge wget ca-certificates unzip && \
    rm -rf /var/cache/apk/* /terraform.zip glibc-${GLIBC_VERSION}.apk

RUN adduser -h /var/jenkins_home -s /bin/bash -G nogroup -D -H -u 1000 terraform

RUN apk -Uu add bash tzdata groff less python py-pip

RUN \
        mkdir -p /aws && \
        pip install awscli && \
        apk --purge -v del py-pip && \
        rm /var/cache/apk/*


USER terraform

WORKDIR /data

ENTRYPOINT ["/bin/terraform"]

CMD ["--help"]
