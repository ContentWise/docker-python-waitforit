FROM golang AS waitforit
RUN go get github.com/ContentWise/waitforit

FROM python:2
COPY --from=waitforit /go/bin/waitforit /usr/local/bin/waitforit