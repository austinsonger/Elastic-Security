FROM docker.elastic.co/beats/heartbeat:7.12.0
COPY heartbeat.yml /usr/share/heartbeat/heartbeat.yml
USER root
RUN chown heartbeat:heartbeat /usr/share/heartbeat/heartbeat.yml
RUN chmod 600 /usr/share/heartbeat/heartbeat.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh
USER heartbeat
ENTRYPOINT ["/start.sh"]
