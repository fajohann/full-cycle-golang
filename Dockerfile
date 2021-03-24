FROM golang:1.16.0-alpine AS builder

WORKDIR /go/src

COPY main.go .

RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags "-s -w -extldflags '-static'" -o app main.go
RUN apk add upx
RUN upx ./app

FROM scratch
COPY --from=builder /go/src/app /app

CMD ["./app"]