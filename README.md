# Shibboleth Service Provider

This repository is a helper to install and configure [Shibboleth] Service Provider.
Esse repositório serve como ajuda para instalar e configurar um Provedor de Serviço (SP) [Shibboleth]. Essa versão utiliza o Shibboleth SP empacotado pela [Switch] para Debian/Ubuntu, diferentemente da versão da [UniconLabs] que usa o pacote oficial para Red Hat/CentOS.

## Shibboleth

## Docker Shibboleth

Use [Docker] for build image and run container Shibboleth Service Provider 2.6

### Build image

This step create a image using a Dockerfile.

```
$ docker build --tag="organization/image-name" "Dockerfile-path"
```

Example:
```
$ docker build --tag="gidlab/shibboleth-sp2.6" docker-shibboleth-sp
```

### Run Container

Now we can run a container using a Docker Image

```
$ docker run -d --name="container-name" -p "HostPort:ContainerPort" "tagname"
```

Example
```
$ docker run -d --name="Shibboleth SP 2.6" -p 80:80 -p 443:443 gidlab/shibboleth-sp2.6
```
[Internet2]: https://www.internet2.edu/products-services/trust-identity/shibboleth/
[Shibboleth]: https://wiki.shibboleth.net/confluence/#all-updates
[Switch]: https://www.switch.ch/
[Docker]: https://www.docker.com/what-docker
