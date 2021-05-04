FROM docker.elastic.co/beats/filebeat:7.12.0
COPY filebeat.yml /usr/share/filebeat/filebeat.yml
USER root
RUN chown filebeat:filebeat /usr/share/filebeat/filebeat.yml
RUN chmod 600 /usr/share/filebeat/filebeat.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh
USER filebeat
ENTRYPOINT ["/start.sh"]
