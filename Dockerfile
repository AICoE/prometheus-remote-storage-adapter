#FROM scratch
FROM alpine

COPY ./remote_storage_adapter /remote_storage_adapter

EXPOSE 9201

ENTRYPOINT ["/remote_storage_adapter"]
CMD ["-influxdb-url=http://influxdb:8086/", "-influxdb.database=prometheus", "-influxdb.retention-policy=autogen"]
