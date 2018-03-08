#FROM scratch
FROM centos:centos7

COPY ./remote_storage_adapter /remote_storage_adapter

EXPOSE 9201

CMD /remote_storage_adapter -influxdb-url=${INFLUXDB_URL:-http://influxdb:8086/} -influxdb.database=${INFLUXDB_DATABASE:-prometheus} -influxdb.retention-policy=autogen

