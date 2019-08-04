img_name := weshofmann/compile
container_name := compile-test
docker_flags := --name $(container_name) 
docker_vols := -v /tmp/src:/src -v /tmp/build:/build

all: build
		
start:
	docker run --rm -d $(docker_flags) $(docker_vols) $(img_name)

runshell:
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name) /bin/bash

stop:
	docker stop $(container_name)
	docker rm $(container_name)

run:
	docker run -it --rm $(docker_flags) $(docker_vols) $(img_name)

test:
	docker run -it --rm $(docker_flags)$(docker_vols) $(img_name) \
	  "git clone https://github.com/trapexit/mergerfs.git \
	    && cd mergerfs  \
	    && make -j4 STATIC=1 LTO=1 USE_XATTR=1 \
	    && make install" 

shell:
	docker exec -it $(container_name) /bin/bash

build:
	docker build -t $(img_name) .

deploy:
	docker push $(img_name)
