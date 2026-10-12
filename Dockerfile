# The builder runs on the build host's own platform and cross-compiles for the target one, so a
# multi-platform build needs no emulation for the Go step.
FROM --platform=$BUILDPLATFORM golang:1.17.5-alpine3.15 AS builder
ARG TARGETOS
ARG TARGETARCH
COPY go.* /
RUN go mod download
COPY *.go /
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /k8s-pod-restart-info-collector /

FROM alpine:3.15
COPY --from=builder /k8s-pod-restart-info-collector /k8s-pod-restart-info-collector
CMD ["/k8s-pod-restart-info-collector"]
