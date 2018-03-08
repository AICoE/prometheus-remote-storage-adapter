DOCKER_ID_USER := aicoe
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H-%M-%SZ)
COMMIT_ID := $(shell git log --pretty=format:'%h' -n 1)
GO_FLAGS := -a -ldflags "-w -X main.buildDate=$(BUILD_DATE) -X main.commitId=$(COMMIT_ID)"

.PHONY:
all: remote_storage_adapter

clean:
	rm remote_storage_adapter

remote_storage_adapter:
	GOOS=linux GOARCH=amd64 go build $(GO_FLAGS) github.com/prometheus/prometheus/documentation/examples/remote_storage/remote_storage_adapter

docker: remote_storage_adapter
	@echo "Updating the local Docker image"
	docker build -t prometheus-remote-storage-adapter:latest .

pushimage: docker
	@echo "Pushing image to ${DOCKER_ID_USER}/prometheus-remote-storage-adapter"
	docker tag prometheus-remote-storage-adapter:latest $(DOCKER_ID_USER)/prometheus-remote-storage-adapter
	docker push $(DOCKER_ID_USER)/prometheus-remote-storage-adapter
