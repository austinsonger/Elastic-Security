FROM jasonish/suricata:latest

COPY suricata.yaml /etc/suricata.dist/suricata.yaml

RUN chown -R suricata:suricata /etc/suricata.dist

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
