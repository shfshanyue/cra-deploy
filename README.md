# Docker 部署前端之 CRA 版

+ [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
+ [Compose file Reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)

另外，还有[Docker 部署前端之简单版](https://github.com/shfshanyue/simple-deploy)

## 配置文件概述

### Docker

+ [simple.Dockerfile](./simple.Dockerfile): 关于如何使用 Docker 进行最简化部署
+ [router.Dockerfile](./router.Dockerfile): 关于如何使用 Docker 部署并进行 nginx 配置
+ [oss.Dockerfile](./oss.Dockerfile): 关于如何使用 Docker 部署并将静态资源部署至 CDN
+ [docker-compose.yaml](./docker-compose.yaml): 关于如何使用 Docker 部署前端从简单到复杂
+ [domain.docker-compose.yaml](./domain.docker-compose.yaml): 关于如何使用 Docker 进行部署并配置域名
+ [preview.docker-compose.yaml](./preview.docker-compose.yaml): 关于如何使用 Docker 进行 Preview 部署

### CI

+ [ci.yaml](.github/workflows/ci.yaml): 如何通过 CI 配置 Lint/Test
+ [build.yaml](.github/workflows/build.yaml): 如何利用 CI Cache
+ [ci-env.yaml](.github/workflows/ci-env.yaml): 如何通过 CI 查看 Github Actions 的环境变量
+ [preview.yaml](.github/workflows/preview.yaml): 如何通过 CI 进行自动 Preview
+ [stop-preview.yaml](.github/workflows/stop-preview.yaml): 如何通过 CI 自动停止 Preview
+ [production.yaml](.github/workflows/production.yaml): 如何通过 CI 进行自动部署 (CD)

### npm scripts

``` js
{
  "scripts": {
    // 通过 ossutil 上传至 OSS
    "oss:cli": "",
    // 通过 rclone 上传至 OSS
    "oss:rclone": "",
    // 通过脚本命令上传至 OSS
    "oss:script": "node scripts/uploadOSS.mjs",
    // 通过脚本命令与定时任务自动清理冗余的 OSS 资源
    "oss:prune": "node scripts/deleteOSS.mjs"
  },
}
```

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