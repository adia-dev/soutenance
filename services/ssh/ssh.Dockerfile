FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y openssh-server vim curl zsh git postgresql-client

RUN useradd -ms /bin/bash moderator
RUN echo 'moderator:Modo@1234' | chpasswd
RUN mkdir /run/sshd

RUN echo 'root:Docker!' | chpasswd

RUN mkdir /home/moderator/.ssh
COPY modo.pub /home/moderator/.ssh/authorized_keys

RUN chown moderator:moderator /home/moderator/.ssh/authorized_keys && \
    chmod 600 /home/moderator/.ssh/authorized_keys

RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowUsers moderator" >> /etc/ssh/sshd_config

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
