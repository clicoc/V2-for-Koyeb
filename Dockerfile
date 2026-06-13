FROM nginx:latest
EXPOSE 7860
WORKDIR /app

USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 gettext-base &&\
    mkdir -p /var/log/nginx /var/lib/nginx /run/nginx /etc/nginx &&\
    chmod -R 777 /var/log/nginx /var/lib/nginx /run/nginx /etc/nginx /app &&\
    wget -O temp.zip $(wget -qO- "https://api.github.com/repos/v2fly/v2ray-core/releases/latest" | grep -m1 -o "https.*linux-64.*zip") &&\
    unzip temp.zip v2ray geoip.dat geosite.dat &&\
    mv v2ray v &&\
    rm -f temp.zip &&\
    chmod -v 755 v entrypoint.sh &&\
    echo 'ewogICAgImxvZyI6ewogICAgICAgICJsb2dsZXZlbCI6Indhcm5pbmciLAogICAgICAgICJhY2Nl\
c3MiOiIvZGV2L251bGwiLAogICAgICAgICJlcnJvciI6Ii9kZXYvbnVsbCIKICAgIH0sCiAgICAi\
aW5ib3VuZHMiOlsKICAgICAgICB7CiAgICAgICAgICAgICJwb3J0IjoxMDAwMCwKICAgICAgICAg\
...这里请保持你原来Dockerfile里的完整base64不变...' > config

USER 1000

ENTRYPOINT [ "./entrypoint.sh" ]
