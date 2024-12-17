FROM golang:1.23-alpine

WORKDIR /app

COPY pkg /app/pkg/
COPY go.mod go.sum ./cmd/yopass/main.go .

RUN go install github.com/jhaals/yopass/cmd/yopass@latest
RUN go build -o yopass main.go

COPY ./yopass_client/yopass_secret_test.sh .

RUN chmod +x yopass_secret_test.sh

CMD ["sh", "yopass_secret_test.sh"]
