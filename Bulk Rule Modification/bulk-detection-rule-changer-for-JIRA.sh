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
                        "description": "- *Number of Alerts*: {{state.signals_count}}\n- *Risk score*: {{context.rule.risk_score}}\n- *Severity*: {{context.rule.severity}}\n\n h2. Rule Details\n [View Detection Alert|{{{context.results_link}}}]\n- *Rule Description*: {quote}{{context.rule.description}}{quote}\n- *Rule Query*: {quote}{{context.rule.query}}{quote}\n\n h2. Source\n {{#context.alerts}}\n- *Source IP Address*: {noformat}{{source.ip}}{noformat}\n- *Source Port*: {noformat}{{source.port}}{noformat}\n {{/context.alerts}}\n\n h2. Destination\n {{#context.alerts}}\n- *Destination IP Address*: {noformat}{{destination.ip}}{noformat}\n- *Destination Port*: {noformat}{{destination.port}}{noformat}\n {{/context.alerts}}\n\n h3. Process\n {{#context.alerts}}\n- *Hash MD5*: {noformat}{{process.hash.md5}}{noformat}\n- *Hash SH1*: {noformat}{{process.hash.sha1}}{noformat}\n- *Hash SHA25*: {noformat}{{process.hash.sha256}}{noformat}\n- *Process Name*: {noformat}{{process.name}}{noformat}\n  - *Process Parent Executable*: {noformat}{{process.parent.executable}}{noformat}\n- *Process Parent Name*: {noformat}{{process.parent.name}}{noformat}\n {{/context.alerts}}\n\n h3. File\n {{#context.alerts}}\n- *File Name*: {noformat}{{file.name}}{noformat}\n- *File Owner*: {noformat}{{file.owner}}{noformat}\n- *File Path*: {noformat}{{file.path}}{noformat}\n- *File size*: {noformat}{{file.size}}{noformat}\n- *File Target Path*: {noformat}{{file.target_path}}{noformat}\n- *File Type*: {noformat}{{file.type}}{noformat}\n {{/context.alerts}}\n"
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
