# Start by building the application.
FROM golang:1.17-bullseye as build


WORKDIR /go/src/app

RUN git clone --depth 1 https://github.com/fcambus/rrda /go/src/app

RUN go get -d -v ./...

RUN go build -o /go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/base-debian11
COPY --from=build /go/bin/app /
CMD ["/app"]