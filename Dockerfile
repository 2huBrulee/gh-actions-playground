# syntax=docker/dockerfile:1

FROM golang:1.18-bullseye as build

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . .
RUN go build -o /server



FROM gcr.io/distroless/base

WORKDIR /
COPY --from=build /server /server

EXPOSE 8080
USER nonroot:nonroot

ENTRYPOINT ["/server"]