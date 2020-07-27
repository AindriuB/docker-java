FROM centos:7

ENV JAVA_PKG=jre-8u*-linux-x64.tar.gz
ENV JAVA_HOME=/usr/java/default 


ADD $JAVA_PKG /usr/java/

RUN export JAVA_DIR=$(ls -1 -d /usr/java/*) && \
    ln -s $JAVA_DIR /usr/java/latest && \
    ln -s $JAVA_DIR /usr/java/default && \
    alternatives --install /usr/bin/java java $JAVA_DIR/bin/java 20000 && \
    alternatives --install /usr/bin/keytool keytool $JAVA_DIR/bin/keytool 20000

RUN yum install -y wget
RUN wget https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.der  
RUN ${JAVA_HOME}/bin/keytool -trustcacerts -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -noprompt -importcert -alias letsencryptauthorityx3 -file lets-encrypt-x3-cross-signed.der  
