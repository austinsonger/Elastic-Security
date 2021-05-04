#!/usr/bin/env bash

IDS_INTERFACE=${IDS_INTERFACE:-eno1}

su -c "suricata-update" suricata

/docker-entrypoint.sh -i $IDS_INTERFACE $@
