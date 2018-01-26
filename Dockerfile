FROM java:8
VOLUME /tmp
ADD move.jar move.jar
RUN bash -c 'touch /move.jar'
EXPOSE 8090
ENTRYPOINT ["java","-Xms32m","-Xmx64m","-Djava.security.egd=file:/dev/./urandom","-jar","/move.jar"]
