FROM minio/minio:latest

RUN apk update && apk add --no-cache bind-tools jq bash

ADD minio-wrapper.sh .

ENTRYPOINT ["minio-wrapper.sh"]