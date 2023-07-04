FROM nginx:1.19

RUN apt update
RUN apt install unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/defaultconf.d/default.conf
#COPY test.conf /etc/nginx/conf.d/test.conf
COPY 404.html /var/defaultwww/index.html
COPY reload.sh /reload.sh
COPY clear.sh /clear.sh