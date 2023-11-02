## Left Side Operation Right Side Value
## Operation Convention UpperCase

FROM 		registry.access.redhat.com/ubi8:latest
MAINTAINER 	David<david@redhat.com>
LABEL 		description="This is a custom httpd container image" \
		purpose="Hust a Build Image Demo"
#USER		root
RUN		yum install httpd -y && \
		useradd user1 && \
		useradd default && \
		yum install bind-utils -y && \
		yum clean all && \
		sed -ie 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf && \
		chown -R apache:apache /etc/httpd/logs/ && \ 
		chown -R apache:apache /run/httpd/

ARG 		MYVER="1.16.8"

EXPOSE		8080
ENV		var1=value1 \
		var2=value2 \
		var3=another-$MYVER

ADD		index.html /var/www/html
ADD 		https://assets.ubuntu.com/v1/b93fecb3-ubuntu-manuals-lockup.svg /var/www/html
ADD		me.tar.gz	/tmp

COPY		another.html /var/www/html
COPY		me.tar.gz /var/www/html/
WORKDIR		/var/www/html/
COPY		me.html .
USER		apache

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]

#ENTRYPOINT	["/usr/bin/date", "+%D"]
#ENTRYPOINT	["/usr/bin/date"]
#CMD		["+%D"]
#CMD		["/usr/bin/date","+%D"]
