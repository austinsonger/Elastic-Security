# Elastic SIEM Sensor + OpenVAS Scanner

## Includes:
- Filebeat
- Heartbeat
- Logstash
- Suricata
- OpenVAS (OpenVAS scanner that can be connected to a Greenbone Vulnerability Manager)


```
├── docker-compose.yml
├── filebeat
│   ├── Dockerfile
│   ├── filebeat.yml
│   └── start.sh
├── heartbeat
│   ├── Dockerfile
│   ├── heartbeat.yml
│   └── start.sh
├── logstash
│   ├── config
│   │   └── logstash.yml
│   └── Dockerfile
└── suricata
    ├── Dockerfile
    ├── start.sh
    └── suricata.yaml
```
