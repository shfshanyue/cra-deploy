# Docker 部署前端之 CRA 版

+ [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
+ [Compose file Reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)

另外，还有[Docker 部署前端之简单版](https://github.com/shfshanyue/simple-deploy)

## 简单版

此版本，已解决了构建缓存，并通过多阶段构建。

``` bash
$ docker-compose up --build simple
```
## 路由修复版

此版本，通过 `nginx.conf` 解决了客户端路由的问题。

``` bash
$ docker-compose up --build route
```
## CDN/OSS 版

此版本，将静态咨询传至 OSS，此时需要提供两个环境变量: `ACCESS_KEY_ID` 与 `ACCESS_KEY_SECRET`。

``` bash
$ docker-compose up --build oss
```

## Preview 版

当往分支 feature-xxx 提交代码时，将会自动部署一个供该分支测试的地址: `feature-xxx.cra.shanyue.tech`

**Preview**

``` bash
$ cat preview.docker-compose.yaml | COMMIT_REF_NAME=$(git rev-parse --abbrev-ref HEAD) envsubst > temp.docker-compose.yaml

$ docker-compose -f temp.docker-compose.yaml up --build
```

**Stop Preview**

``` bash
$ cat preview.docker-compose.yaml | COMMIT_REF_NAME=$(git rev-parse --abbrev-ref HEAD) envsubst > temp.docker-compose.yaml

$ docker-compose stop
```

## kubernetes 版

``` bash
$ kubectl apply -f k8s-app.yaml
```

## k8s Preview 版

``` bash
$ cat k8s-preview-app.yaml | COMMIT_REF_NAME=$(git rev-parse --abbrev-ref HEAD) envsubst > temp.k8s-app.yaml

$ kubectl apply -f temp.k8s-app.yaml
```