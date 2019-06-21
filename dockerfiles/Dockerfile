FROM ubuntu:bionic
RUN apt update && apt install gpg ca-certificates gpg-agent --no-install-recommends -y
COPY qgis-2017.gpg.key /tmp/qgis-2017.gpg.key
RUN echo "deb  http://qgis.org/debian bionic main" >> /etc/apt/sources.list && \
echo "deb-src  http://qgis.org/debian bionic main" >> /etc/apt/sources.list && \
gpg --import /tmp/qgis-2017.gpg.key && gpg --fingerprint CAEB3DC3BDF7FB45 && gpg --export --armor CAEB3DC3BDF7FB45 | apt-key add -
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install apache2 xvfb qgis-server python-qgis python-fcgi libapache2-mod-fcgid -y --no-install-recommends
RUN a2enmod rewrite && a2enmod headers && sed -i -e "s/^Listen 80/Listen 8080/" /etc/apache2/ports.conf && \
sed -i -e "s/^Listen 443/Listen 8443/" /etc/apache2/ports.conf && \
sed -ri -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' /etc/apache2/apache2.conf && \
rm -rf /etc/apache2/sites-enabled/* /etc/apache2/sites-available/* /var/www/html/*
COPY qgis.conf /etc/apache2/sites-enabled/qgis.conf
COPY seguridad.conf /etc/apache2/conf-enabled/seguridad.conf
COPY world /tmp/world
RUN apt remove gpg gpg-agent -y && rm -rf /etc/localtime && \
mkdir -p /var/run/apache2 /home/qgis /var/log/qgis/ && \
touch /etc/localtime /etc/timezone && \
chown 33:33 -R /usr/lib/qgis /tmp/world /usr/share/qgis /etc/timezone /etc/localtime /home/qgis /var/log/qgis/ /var/www/html/ /usr/lib/cgi-bin/ /etc/localtime /etc/timezone /var/run/apache2 /etc/apache2 /var/log/apache2 && \
apt autoremove -y && apt clean && apt autoclean && rm -rf /var/lib/{apt,dpkg,cache,log}
COPY run.sh /usr/bin/run.sh
EXPOSE 8080
WORKDIR /etc/apache2
USER 33
VOLUME ["/home/qgis"]
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["apachectl", "-DFOREGROUND"]
