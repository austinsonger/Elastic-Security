for i in $(curl --silent --location --request GET 'https://<System Generated ID>.eastus2.azure.elastic-cloud.com:9243/api/detection_engine/rules/_find?per_page=5&filter=alert.attributes.enabled:true' --header 'kbn-xsrf: kibana' --header 'Content-Type: multipart/form-data' --header 'Authorization: Basic <Base64>' | jq .data[].id); do
echo "Updating Rule ID $i"
curl --silent --location --request PATCH 'https://<System Generated ID>.eastus2.azure.elastic-cloud.com:9243/api/detection_engine/rules' --header 'kbn-xsrf: kibana' --header 'Authorization: Basic <Base64>' --header 'Content-Type: application/json' --data-raw '{
    "id":'$i',
    "throttle": "rule", 
    "actions":[
        {
            "action_type_id": ".jira",
            "id": "<Action ID>",
            "params": {
                "subActionParams": {
                    "comments": [],
                    "incident": {
                        "issueType": "<Issue Type Number>",
                        "summary": "{{alertName}}",
                        "description": "h3. View Detection:\\n\\n[View Detection Alert|{{{context.results_link}}}]\\n\\nh4. Source\\n\\n{{#context.alerts}} \\n\\nSource IP Address: {{source.ip}}\\n\\nSource Port: {{source.port}}\\n\\n{{/context.alerts}}\\n\\n\\nh4. Destination\\n\\n{{#context.alerts}} \\n\\nDestination IP Address: {{destination.ip}}\\n\\nDestination Port: {{destination.port}}\\n\\n{{/context.alerts}}\\n\\n{code:json}\n{{#context.alerts}}{{{.}}}{{/context.alerts}}\n{code}"
                    }
                },
                "subAction": "pushToService"
            },
            "group": "default"
          }
        ]
}' | jq .

echo "Rule ID $i has been updated."
done
