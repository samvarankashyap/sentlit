# A super-simple "hello world" server that exposes port 8080
#
# VERSION               0.1.0
FROM ubuntu
MAINTAINER Joshua Conner <joshua.conner@gmail.com>

# create user
#RUN groupadd web
#RUN useradd -d /home/bottle -m bottle

# make sure sources are up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install gcc-4.9
#RUN pip install gunicorn
#RUN apt-get update && apt-get install -y python-dev && apt-get clean
# install pip and hello-world server requirements
RUN apt-get install python-pip -y
#ADD main.py /home/bottle/main.py
#ADD views /home/bottle/views
#ADD static /home/bottle/static
#RUN pip install gevent
RUN pip install gunicorn
RUN apt-get install python-gevent -y
ADD . /app
WORKDIR /app
RUN pip install bottle
RUN pip install -U nltk
RUN /usr/bin/python2.7 -m nltk.downloader all

# in case you'd prefer to use links, expose the port
EXPOSE 8080
#ENTRYPOINT ["/usr/bin/python2.7", "/home/bottle/main.py"]
CMD ["gunicorn","-b","0.0.0.0:8080","-w","3","-k","gevent","--log-file","-","--log-level","debug","--access-logfile","-","main:app"]
#USER bottle
