# Tencent Serveless Github Action (腾讯云云函数Github Action)


## Usage（用法）

This is how the step looks: (使用方式)
```
    - name: serverless scf deploy
      uses: woodyyan/tencent-serverless-action@main
```
And this is a complete example inside a Github Workflow File:（完整示例）

```
# 当代码推动到 main 分支时，执行当前工作流程
# 更多配置信息: https://docs.github.com/cn/actions/getting-started-with-github-actions
name: deploy serverless scf
on: #监听的事件和分支配置
  push:
    branches:
      - main 
jobs:
  deploy:
    name: deploy serverless scf
    runs-on: ubuntu-latest
    steps:
      - name: clone local repository
        uses: actions/checkout@v2
      - name: deploy serverless
        uses: woodyyan/tencent-serverless-action@main
        env: # 环境变量
          STAGE: dev #您的部署环境
          SERVERLESS_PLATFORM_VENDOR: tencent #serverless 境外默认为 aws，配置为腾讯
          TENCENT_SECRET_ID: ${{ secrets.TENCENT_SECRET_ID }} #您的腾讯云账号 sercret ID，请在Settings-Secrets中配置
          TENCENT_SECRET_KEY: ${{ secrets.TENCENT_SECRET_KEY }} #您的腾讯云账号 sercret key，请在Settings-Secrets中配置

```


License
The Dockerfile and associated scripts and documentation in this project are released under MIT license.