FROM ubuntu:16.04
RUN apt-get update \
	&& apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:ansible/ansible \
	&& apt-get update \
	&& apt-get -y install sudo openssh-server ansible
RUN echo 'root:123456' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir /var/run/sshd
RUN mkdir /root/.ssh
COPY ./templates/authorized_keys /root/.ssh/authorized_keys
RUN apt-get install -y nano
EXPOSE 22
CMD service ssh start && /bin/bash
