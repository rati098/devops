FROM nginx:1.25.5
ARG TEMPLATE_URL=https://www.tooplate.com/zip-templates/2134_gotto_job.zip
ARG FOLDER=2134_gotto_job
RUN apt update && apt install unzip -y && curl -o web.zip $TEMPLATE_URL && unzip web.zip && cp -rf $FOLDER/* /usr/share/nginx/html
