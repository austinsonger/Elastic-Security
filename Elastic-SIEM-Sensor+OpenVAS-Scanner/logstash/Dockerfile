FROM docker.elastic.co/logstash/logstash:7.9.2
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
ADD config/ /usr/share/logstash/config/
ADD pipeline/ /usr/share/logstash/pipeline/
USER root
RUN chown logstash:root -R /usr/share/logstash
USER logstash
