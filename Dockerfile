FROM golang:1.9-alpine

# Package dependencies
RUN apk add --update --no-cache git libc-dev gcc tree

# install dependency tool
RUN go get github.com/golang/dep && \
  go install github.com/golang/dep/cmd/dep

WORKDIR /go/src/github.com/AMFDPMTE/list-api

# Copy dep file
COPY Gopkg.lock .
COPY Gopkg.toml .
# Get dependencies
RUN dep ensure -v --vendor-only

# Copy remainder of the app
COPY . .

# Compile code
RUN go build

CMD ["./list-api"]
