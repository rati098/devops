FROM openjdk:11 AS BUILD_IMAGE
ARG GH_SSH_PRIVATE_KEY
RUN mkdir -p /root/.ssh && \
    echo "${GH_SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
RUN apt update && apt install maven -y
RUN git clone git@github.com:rati098/vrpofcpallbranches.git
RUN cd vrpofcpallbranches && git checkout docker &&  mvn install

FROM tomcat:9-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Ratikanta P"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vrpofcpallbranches/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]