Dockerfile for Hashicorp Consul
===============================

### Pull the image
```bash
$ docker pull lancechen/consul
```

### Start a Consul server

#### Start a dev server

```bash
$ docker run -d -p 8500:8500 --name dev-consul lancechen/consul
```
