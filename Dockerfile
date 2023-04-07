#Dockerfile

#sudo docker build --no-cache --progress=plain --tag proekt7 .
#sudo docker images
#sudo docker run -d -p 8001:80 --name proekt7 --mount type=bind,src=/srv/app,dst=/srv/app proekt7
#sudo docker ps -a
#sudo docker logs proekt7

FROM python:3.8-slim-buster

WORKDIR /srv/app

COPY requirements.txt .

#Install required library libmysqlclient (and build-essential for building mysqlclient python extension)
#Need to have default-libmysqlclient-dev  before running pip instal mysqlclient
RUN set -eux && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y default-libmysqlclient-dev build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY web.py .
COPY web.conf ./conf

CMD [ "python3", "./web.py" ]