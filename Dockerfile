# hub.docker.com/r/itsjustcon/nuclide-remote-docker
# ===============================
# HOW TO BUILD:
#     docker build --tag=itsjustcon/nuclide-remote-docker .
# HOW TO DEPLOY:
#     docker push itsjustcon/nuclide-remote-docker

FROM node
MAINTAINER Connor Grady <conair360@gmail.com>

# OpenSSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:admin' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
#EXPOSE 22
EXPOSE 2222
#EXPOSE 9091
#EXPOSE 10022
#CMD [ '/usr/sbin/sshd', '-D' ]

# Watchman
RUN apt-get update && apt-get install -y python-dev &&\
    git clone https://github.com/facebook/watchman.git &&\
    cd watchman &&\
    git checkout v4.6.0 &&\
    ./autogen.sh &&\
    ./configure &&\
    make && make install

# Nuclide Server
RUN npm install -gq nuclide
#expose 9090
#expose 10090
expose 2290

WORKDIR /usr/src/app
VOLUME /usr/src/app

#CMD [ "/usr/sbin/sshd", "-D" ]
CMD /usr/sbin/sshd -D -p 2222
#CMD ["/usr/sbin/sshd", "-D", "-p", "2222"]
