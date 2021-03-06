from ubuntu:16.04

MAINTAINER GIdLab <gidlab@rnp.br>

RUN apt-get update && apt-get -y upgrade \
 && apt-get -y install apache2 curl libapache2-mod-php unzip vim


# Add Shibboleth 2.6 Switch Repository

RUN curl -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc \
 && gpg --with-fingerprint  SWITCHaai-swdistrib.asc \
 && apt-key add SWITCHaai-swdistrib.asc \
 && echo 'deb http://pkg.switch.ch/switchaai/ubuntu xenial main' | tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list > /dev/null \
 && apt-get update


# Install Shibboleth 2.6 Switch

RUN apt-get -y install --install-recommends shibboleth


# Case use volumes with docker-composer commnet this block

COPY etc-shibboleth /etc/shibboleth/
COPY sites-available /etc/apache2/sites-available/
COPY var-www /var/www/
COPY ssl /etc/ssl/
COPY entrypoint.sh /usr/local/bin/


# Permissions
#RUN shib-keygen -f -u _shibd -h sp2-openam.gidlab.rnp.br -y 3 -e https://sp2-openam.gidlab.rnp.br/shibboleth -o /etc/shibboleth/
# && chmod 0700 /usr/local/bin/entrypoint.sh
# && chmod 0600 /etc/apache2/ssl
# && chmod 0700 -R /etc/shibboleth \

RUN a2enmod ssl headers rewrite \
 && a2ensite 000-default.conf shibboleth2.conf

EXPOSE 80
EXPOSE 443

#CMD service apache2 stop
#CMD service shib stop

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
CMD ["/etc/init.d/shibd", "restart"]
RUN chown -R _shibd:_shibd /var/cache/shibboleth

#ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
