from ubuntu:16.04

RUN apt-get update && apt-get -y upgrade \
 && apt-get -y install apache2 curl


# Add Shibboleth 2.6 Switch Repository

RUN curl -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc \
 && gpg --with-fingerprint  SWITCHaai-swdistrib.asc \
 && apt-key add SWITCHaai-swdistrib.asc \
 && echo 'deb http://pkg.switch.ch/switchaai/ubuntu xenial main' | tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list > /dev/null \
 && apt-get update


# Install Shibboleth 2.6 Switch

RUN apt-get -y install --install-recommends shibboleth


# Case use volumes with docker-composer commnet this block

COPY conf /etc/shibboleth/
COPY sites-enabled /etc/apache2/sites-enabled/
COPY entrypoint.sh /usr/local/bin/


# Permissions
RUN chmod 0700 /usr/local/bin/entrypoint.sh \
 && chmod 0700 -R /etc/shibboleth \
 && chmod 0700 -R /etc/apache2/sites-enabled/

RUN a2enmod ssl

CMD /usr/local/bin/entrypoint.sh
