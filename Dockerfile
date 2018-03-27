FROM golang:1.9

WORKDIR /go/src/github.com/SiftScience/ecr-login
ADD . .
RUN go get -d
RUN go build ./ecr-login.go 

FROM bitnami/minideb:stretch

ADD certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /go/src/github.com/SiftScience/ecr-login/ecr-login /usr/bin/ecr-login

CMD [ "ecr-login" ]
