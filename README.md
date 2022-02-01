# Docker 部署前端之 CRA 版

+ [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
+ [Compose file Reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)

另外，还有[Docker 部署前端之简单版](https://github.com/shfshanyue/simple-deploy)

## 简单版

此版本，已解决了构建缓存，并通过多阶段构建。

``` bash
$ docker-compose up --build simple
```
## 路由版

此版本，通过 `nginx.conf` 解决了客户端路由的问题。

``` bash
$ docker-compose up --build route
```
## 云服务

此版本，将静态咨询传至 OSS，此时需要提供两个环境变量: `ACCESS_KEY_ID` 与 `ACCESS_KEY_SECRET`。

``` bash
$ docker-compose up --build oss
```
