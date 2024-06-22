# syntax=docker/dockerfile:1

FROM golang:1.21-alpine
# USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /go-service

CMD [ "/go-service" ]