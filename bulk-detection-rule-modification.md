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



