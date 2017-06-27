FROM minio/minio:latest

RUN apk update && apk add --no-cache bind-tools jq bash curl

ADD minio-wrapper.sh /go/src/github.com/minio/minio-wrapper.sh

RUN chmod 755 /go/src/github.com/minio/minio-wrapper.sh

ENTRYPOINT ["/go/src/github.com/minio/minio-wrapper.sh"]
