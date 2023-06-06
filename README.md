# Nextflow_docker_demo

Following the Nextflow/Docker demo from [Seqera labs tutorial](https://www.youtube.com/watch?v=Axiq1eslb3Q)

in the same directory as the main.nf file, run the following:
```
mkdir docker
cd docker
touch Dockerfile
```

create the Dockerfile with the necessary dependencies (ex: salmon)

```
FROM debian:latest

LABEL image.author.name "Nora Kearns"
LABEL image.author.email "your@email.here"

RUN apt-get update && apt-get install -y curl cowsay

ENV PATH=$PATH:/usr/games/

RUN curl -sSL https://github.com/COMBINE-lab/salmon/releases/download/v1.5.2/salmon-1.5.2_linux_x86_64.tar.gz | tar xz \
&& mv /salmon-*/bin/* /usr/bin/ \
&& mv /salmon-*/lib/* /usr/lib/
```

### Build the docker image
```
docker build -t my-image .
```

### Run the image in interactive mode
```
docker run -it my-image
```

### Mount your local file system to the docker daemon
- so that when you run a command using local data it can be accessed by the docker daemon, and the outputs will be visible on your local file system when docker shuts down.

```
docker run --volume $PWD:$PWD --workdir $PWD my-image \
  > salmon index -t data/ggal/transcriptome.fa -i transcriptom-index
```

### Upload container to docker hub
```
docker login
docker tag my-image norakearns/my-image
docker push norakearns/my-image
```

### Run a nextflow script with a docker container
```
nextflow run main.nf -with-docker norakearns/my-image
```

OR specify the following in the nextflow.config file
```
process.container = 'norakearns/my-image'
docker.runOptions = '-u $(id -u):$(id -g)' 
docker.enabled = true
```



