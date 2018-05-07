FROM python:2
ARG WAITFORIT_VERSION=2.2.0

ENV MILLIS_BETWEEN_WAIT_RETRIES=2000
ENV SECONDS_TO_WAIT=86400

ENV ELASTICSEARCH_WAIT_FOR_STATUS=yellow

COPY run.sh /opt/

RUN wget -q -O /usr/local/bin/waitforit https://github.com/maxcnunes/waitforit/releases/download/v${WAITFORIT_VERSION}/waitforit-linux_amd64 && chmod +x /usr/local/bin/waitforit

ENTRYPOINT [ "/opt/run.sh"]
CMD ["python", "--version"]