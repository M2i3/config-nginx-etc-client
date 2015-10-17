IMAGE_NAME=m2i3/config-nginx-etc-client

build:
	docker build -t $(IMAGE_NAME) ./
	
