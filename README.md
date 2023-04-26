# Tencent Serveless Github Action (腾讯云云函数Github Action)


## Usage（用法）

This is how the step looks: (使用方式)
```
    - name: serverless scf deploy
      uses: coderwangke/tencent-serverless-action@main
```


This is a complete example inside a Github Workflow File for `Python`:（完整示例，适用于`Python`项目）


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

This is a complete example inside a Github Workflow File for `Java` with Gradle:（完整示例，适用于`Java`项目，请仔细看代码中的备注说明）

```
name: deploy serverless scf
on: #监听的事件和分支配置
  push:
    branches:
      - main
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v2
      - name: Set up JDK 11
        uses: actions/setup-java@v2
        with:
          java-version: '11'
          distribution: 'temurin'
          server-id: github # Value of the distributionManagement/repository/id field of the pom.xml
          settings-path: ${{ github.workspace }} # location for the settings.xml file
      - name: Build with Gradle # Gradle项目用这个
        uses: gradle/gradle-build-action@937999e9cc2425eddc7fd62d1053baf041147db7
        with:
          arguments: build
      - name: Build with Maven # Maven项目用这个
        run: mvn -B package --file pom.xml
      - name: create zip folder # 此步骤仅用于Java Web函数，用于存放jar和scf_bootstrap文件。Java事件函数只需要在Serverless.yml中指定Jar目录就好。
        run: mkdir zip
      - name: move jar and scf_bootstrap to zip folder # 此步骤仅用于Java Web函数，用于移动jar和scf_bootstrap文件。Java事件函数只需要在Serverless.yml中指定Jar目录就好。注意如果是Maven编译请修改下面的jar路径为/target。
        run: cp ./build/libs/XXX.jar ./scf_bootstrap ./zip
      - name: deploy serverless
        uses: woodyyan/tencent-serverless-action@main
        env: # 环境变量
          STAGE: dev #您的部署环境
          SERVERLESS_PLATFORM_VENDOR: tencent #serverless 境外默认为 aws，配置为腾讯
          TENCENT_SECRET_ID: ${{ secrets.TENCENT_SECRET_ID }} #您的腾讯云账号 sercret ID
          TENCENT_SECRET_KEY: ${{ secrets.TENCENT_SECRET_KEY }} #您的腾讯云账号 sercret key


```

This is a complete example inside a Github Workflow File for `NodeJS`:（完整示例，适用于`NodeJS`项目）


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
      - name: install dependency
        run: npm install
      - name: build
        run: npm build
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
