FROM openjdk:17

ENV APP_NAME="pizza-app-backend-java"
ENV APP_VERSION="0. 0. 1-SNAPSHOT"
ENV PORT="3000"

RUN echo "App Name : $APP_NAME"
RUN echo "App Version : $VERSION"
RUN echo "App Port: $PORT"

EXPOSE 3000

ARG JAR_FILE=./*-jar

ADD ${JAR_FILE} spring_backend

ENTRYPOINT [ "java","-jar","/spring_backend" ]