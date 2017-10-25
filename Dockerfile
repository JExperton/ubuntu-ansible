FROM ubuntu:16.04
RUN apt-get update \
	&& apt-get install -y sudo openssh-server openssh-client \
	&& apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:ansible/ansible \
	&& apt-get update \
	&& apt-get install -y ansible
RUN echo 'root:123456' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN touch /var/log/syslog
RUN mkdir /var/run/sshd
RUN mkdir /root/.ssh
EXPOSE 22
CMD service ssh start && /bin/bash
