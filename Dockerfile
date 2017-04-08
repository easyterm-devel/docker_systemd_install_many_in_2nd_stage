FROM centos:latest
ENV container docker

ARG IREDMAIL_VERSION=0.9.6

RUN yum update -y; \
    yum install -y tar bzip2 wget

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /opt/iredmail

RUN wget -O - https://bitbucket.org/zhb/iredmail/downloads/iRedMail-"${IREDMAIL_VERSION}".tar.bz2 | \
    tar xvj --strip-components=1; \
    chmod +x iRedMail.sh; \
    systemctl set-default multi-user.target

ADD config .
ADD run.sh .
RUN chmod +x run.sh

COPY rc.local /etc/rc.local
COPY rc-local.service /lib/systemd/system/rc-local.service

RUN chmod +x /etc/rc.local; \
    cd /lib/systemd/system/multi-user.target.wants; \
    ln -s ../rc-local.service rc-local.service;

VOLUME [ "/sys/fs/cgroup" ]
# , "/tmp", "/run" ]

#RUN ln -s iredmail.sh /iredmail.sh # backwards compat
#ENTRYPOINT ["iredmail.sh"]

EXPOSE 80 443 25 587 110 143 993 995

CMD ["/usr/sbin/init"]
#CMD ["iredmail.sh"]
