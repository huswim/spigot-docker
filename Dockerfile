FROM amazoncorretto:22-alpine-jdk

ENV VERSION=1.21
ENV BUILD_PATH=/build
ENV SERVER_PATH=/minecraft

RUN apk add git

# Build spigot
RUN mkdir ${BUILD_PATH}
WORKDIR ${BUILD_PATH}

ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar BuildTools.jar

RUN java -jar BuildTools.jar --rev ${VERSION}

# setup server folderdo
RUN mkdir ${SERVER_PATH}
RUN mv spigot-${VERSION}.jar ${SERVER_PATH}/spigot.jar

WORKDIR ${SERVER_PATH}
RUN rm -r ${BUILD_PATH}

# run spigot
RUN java -jar spigot.jar
RUN sed -i 's/eula=false/eula=true/g' eula.txt

WORKDIR /
COPY ./run.sh /run.sh
RUN chmod +x run.sh

CMD [ "./run.sh" ]
# CMD [ "java", "-jar", "spigot.jar" ]