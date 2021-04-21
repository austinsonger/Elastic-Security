# Bulk Detection Rule Modification


## Encode elastic username and password

`username:password` 

> And you can go to https://www.base64encode.org to do this.

![](https://i.imgur.com/0hsvOwC.jpg)

#### Result

```
dXNlcm5hbWU6cGFzc3dvcmQ=
```

### Encoded Base64 Output

'Authorization: Basic (Encoded Base64)'

```bash
curl  -XGET https://(System Generated ID).eastus2.azure.elastic-cloud.com:9243/api/actions --header 'kbn-xsrf: kibana' --header 'Content-Type: multipart/form-data' --header 'Authorization: Basic (Encoded Base64)'
```

#### Example

'Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ='

**Load Elastic Action ID's**
```bash
curl  -XGET https://(System Generated ID).eastus2.azure.elastic-cloud.com:9243/api/actions --header 'kbn-xsrf: kibana' --header 'Content-Type: multipart/form-data' --header 'Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ='
```

**Output**

```json
[
   {
      "id": "(Action ID)",
      "actionTypeId": ".jira",
      "name": "JIRA",
      "config": {
         "apiUrl": "https://(JIRA Instance).atlassian.net",
         "projectKey": "SOC",
         "incidentConfiguration": null,
         "isCaseOwned": null
      },
      "isPreconfigured": false,
      "referencedByCount": 266
   },
   {
      "id": "(Action ID)",
      "actionTypeId": ".server-log",
      "name": "Monitoring: Write to Kibana log",
      "config": {},
      "isPreconfigured": false,
      "referencedByCount": 10
   },
   {
      "id": "(Action ID)",
      "actionTypeId": ".jira",
      "name": "Security Operations Center",
      "config": {
         "apiUrl": "https://(JIRA Instance).atlassian.net",
         "projectKey": "ES",
         "incidentConfiguration": {
            "mapping": [
               {
                  "actionType": "overwrite",
                  "source": "title",
                  "target": "summary"
               },
               {
                  "actionType": "overwrite",
                  "source": "description",
                  "target": "description"
               },
               {
                  "actionType": "append",
                  "source": "comments",
                  "target": "comments"
               }
            ]
         }
      },
      "isPreconfigured": false,
      "referencedByCount": 0
   }
]
```

You will need to switch certain variables with yours.


## JIRA Context That I wanted


```
- *Number of Alerts*: {{state.signals_count}}
- *Risk score*: {{context.rule.risk_score}}
- *Severity*: {{context.rule.severity}}

 h2. Rule Details
 [View Detection Alert|{{{context.results_link}}}]
- *Rule Description*: {quote}{{context.rule.description}}{quote}
- *Rule Query*: {quote}{{context.rule.query}}{quote}

 h2. Source
 {{#context.alerts}}
- *Source IP Address*: {noformat}{{source.ip}}{noformat}
- *Source Port*: {noformat}{{source.port}}{noformat}
 {{/context.alerts}}

 h2. Destination
 {{#context.alerts}}
- *Destination IP Address*: {noformat}{{destination.ip}}{noformat}
- *Destination Port*: {noformat}{{destination.port}}{noformat}
 {{/context.alerts}}

 h3. Process
 {{#context.alerts}}
- *Hash MD5*: {noformat}{{process.hash.md5}}{noformat}
- *Hash SH1*: {noformat}{{process.hash.sha1}}{noformat}
- *Hash SHA25*: {noformat}{{process.hash.sha256}}{noformat}
- *Process Name*: {noformat}{{process.name}}{noformat}
- *Process Parent Executable*: {noformat}{{process.parent.executable}}{noformat}
- *Process Parent Name*: {noformat}{{process.parent.name}}{noformat}
 {{/context.alerts}}

 h3. File
 {{#context.alerts}}
- *File Name*: {noformat}{{file.name}}{noformat}
- *File Owner*: {noformat}{{file.owner}}{noformat}
- *File Path*: {noformat}{{file.path}}{noformat}
- *File size*: {noformat}{{file.size}}{noformat}
- *File Target Path*: {noformat}{{file.target_path}}{noformat}
- *File Type*: {noformat}{{file.type}}{noformat}
 {{/context.alerts}}
```

#### JIRA in ndjson format

```
- *Number of Alerts*: {{state.signals_count}}\n- *Risk score*: {{context.rule.risk_score}}\n- *Severity*: {{context.rule.severity}}\n\n h2. Rule Details\n [View Detection Alert|{{{context.results_link}}}]\n- *Rule Description*: {quote}{{context.rule.description}}{quote}\n- *Rule Query*: {quote}{{context.rule.query}}{quote}\n\n h2. Source\n {{#context.alerts}}\n- *Source IP Address*: {noformat}{{source.ip}}{noformat}\n- *Source Port*: {noformat}{{source.port}}{noformat}\n {{/context.alerts}}\n\n h2. Destination\n {{#context.alerts}}\n- *Destination IP Address*: {noformat}{{destination.ip}}{noformat}\n- *Destination Port*: {noformat}{{destination.port}}{noformat}\n {{/context.alerts}}\n\n h3. Process\n {{#context.alerts}}\n- *Hash MD5*: {noformat}{{process.hash.md5}}{noformat}\n- *Hash SH1*: {noformat}{{process.hash.sha1}}{noformat}\n- *Hash SHA25*: {noformat}{{process.hash.sha256}}{noformat}\n- *Process Name*: {noformat}{{process.name}}{noformat}\n  - *Process Parent Executable*: {noformat}{{process.parent.executable}}{noformat}\n- *Process Parent Name*: {noformat}{{process.parent.name}}{noformat}\n {{/context.alerts}}\n\n h3. File\n {{#context.alerts}}\n- *File Name*: {noformat}{{file.name}}{noformat}\n- *File Owner*: {noformat}{{file.owner}}{noformat}\n- *File Path*: {noformat}{{file.path}}{noformat}\n- *File size*: {noformat}{{file.size}}{noformat}\n- *File Target Path*: {noformat}{{file.target_path}}{noformat}\n- *File Type*: {noformat}{{file.type}}{noformat}\n {{/context.alerts}}\n
```





#### The Full Scipt

```
  
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

```














