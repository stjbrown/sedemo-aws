FROM alpine:3.8

RUN apk -v --update --no-cache add \
        git \
        vim \
        bash \
        jq \
        openssl \
        python3 \
        ansible \
        openssh \
        groff \
        less \
        && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade awscli botocore boto3 pexpect okta-awscli && \
    adduser -u 1001 -D -h /home/nsuser nsuser && \
    adduser -u 1002 -D -h /home/sedemo sedemo

USER sedemo
RUN mkdir -p /home/sedemo/.aws
VOLUME /home/sedemo/.ssh
COPY --chown=sedemo ./okta-aws-sedemo /home/sedemo/.okta-aws
COPY --chown=sedemo aws-sedemo /home/sedemo/.aws/
COPY --chown=sedemo transformCreds.py /home/sedemo/transformCreds.py
COPY --chown=sedemo getAWSCreds.sh /home/sedemo/getAWSCreds.sh
COPY --chown=sedemo files /home/sedemo/files/
RUN chmod +x /home/sedemo/transformCreds.py
RUN chmod +x /home/sedemo/getAWSCreds.sh

USER root
RUN cat /home/sedemo/.aws/netskope-cert-bundle.pem >> /usr/lib/python3.6/site-packages/certifi/cacert.pem 

WORKDIR /home/sedemo
