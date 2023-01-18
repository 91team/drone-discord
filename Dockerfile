FROM golang:1.16 as builder

WORKDIR /opt/app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./

RUN GOARCH=amd64 GOOS=linux go build -ldflags "-X main.version=0.0.1 -X main.build=1" -a -o /drone-discord

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y ca-certificates

COPY --from=builder /drone-discord /

CMD ["/drone-discord"]
