FROM alpine as builder
RUN apk update --no-cache && apk add gcc musl-dev
COPY pause.c /root/pause.c
WORKDIR /root
RUN gcc pause.c -o pause -static && strip -s pause

FROM alpine as base
COPY --from=builder /root/pause /root/pause
WORKDIR /root
CMD ["./pause"]
