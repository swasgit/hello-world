# Install Java.
#FROM dockerfile/java:oracle-java8
FROM cogniteev/oracle-java:java8


RUN echo "Starting the runtime ..."
MAINTAINER Travelport Hospitality

# Define working directory.
WORKDIR /travelport

ADD target/*.jar /travelport/
#ADD src/main/resources/docker/AppServerAgent-4.1.4.3 /AppServerAgent-4.1.4.3

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# SpringBoot will use this start embedded Tomcat
ENV SERVER_PORT=37960

# This will be overridden by the specific deployment scripts like devEnvrionment.sh, qaEnvironment.sh etc
ENV JAVA_ARGS="-Xms512m -Xms512m -XX:NewSize=128m -XX:MaxNewSize=128m -XX:SurvivorRatio=8 -XX:MaxTenuringThreshold=2 -XX:+UseParallelGC"

CMD java $APP_D_AVL_SVC_ARGS $JAVA_ARGS -jar /travelport/${project.artifactId}-${project.version}.jar
