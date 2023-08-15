FROM python:3

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y supervisor
RUN apt-get install -y vim
RUN apt-get install -y netcat-openbsd
RUN rm /etc/nginx/sites-available/default && rm /etc/nginx/nginx.conf

ADD . /app

COPY ./build/nginx.conf /etc/nginx/nginx.conf

COPY ./build/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./build/supervisor.d/ /etc/supervisor/conf.d

EXPOSE 80 

WORKDIR /app

RUN pip install .

ENTRYPOINT [ "supervisord" ]
CMD [ "-c", "/etc/supervisor/supervisord.conf" ]
