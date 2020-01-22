#!/bin/bash

grafana_host="http://localhost:3000"
prometheus_host="http://localhost:9090"

# Below is the definition of the data source
payload="$( mktemp )"
cat <<EOF >"${payload}"
{
"name": "prometheus",
"type": "prometheus",
"isDefault": true,
"typeLogoUrl": "",
"access": "proxy",
"url": "${prometheus_host}",
"basicAuth": false,
"withCredentials": false,
"jsonData": {
    "tlsSkipVerify":true,
    "httpHeaderName1":"Authorization"
  }
}
EOF

# POST the data source definition to Grafana
curl --insecure -H "Content-Type: application/json" -u admin:admin "${grafana_host}/api/datasources" -X POST -d "@${payload}"

