# 使用 JDK 17 的基础镜像
FROM openjdk:17-jdk-slim

# 设置工作目录
WORKDIR /app

# 将 Maven 构建的 JAR 包复制到容器中
COPY target/demo-0.0.1-SNAPSHOT.jar /app/app.jar

# 暴露容器端口
EXPOSE 8080

# 启动应用程序
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
