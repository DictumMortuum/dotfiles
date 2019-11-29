FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t eg_sshd .
# docker run -d -P --name test_sshd eg_sshd
# docker port test_sshd 22
#0.0.0.0:49154
# ssh root@localhost -p 49154

# cleanup
# docker container stop test_sshd
# docker container rm test_sshd
# docker image rm eg_sshd
