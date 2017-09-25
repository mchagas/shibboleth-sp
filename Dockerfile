from ubuntu:16.04

RUN apt-get update && apt-get -y upgrade \
 && apt-get -y install apache2 libapache2-mod-php unzip curl


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
COPY entrypoint.sh /usr/local/bin/


# Permissions
RUN shib-keygen -f -u _shibd -h sp2-openam.gidlab.rnp.br -y 3 -e https://sp2-openam.gidlab.rnp.br/shibboleth -o /etc/shibboleth/
RUN  chmod 0700 /usr/local/bin/entrypoint.sh
# && chmod 0600 /etc/apache2/ssl
# && chmod 0700 -R /etc/shibboleth \

RUN a2enmod ssl headers rewrite \
 && a2ensite 000-default.conf shibboleth2.conf

CMD service apache2 stop
CMD service shib stop
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 80
EXPOSE 443
