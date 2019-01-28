# Assumptions:
# - This code is called by sourcing it as described in ../demo3_setup.cmd (same order for the scripts)
# - variables were initialized

subscriptionid=`az account show --output tsv --query id`
az group create --location $location --name $rg1

az group deployment create --name "deploy_$azmonworkspacename" \
    -g $rg1 --template-file ./demo3/azure_monitor_workspace.json \
    --parameters name="$azmonworkspacename" location=$location

az eventhubs namespace create -g $rg1 --name $ehnsname \
    --sku Standard --capacity 1 \
    --enable-auto-inflate True --maximum-throughput-units 2

az eventhubs eventhub create -g $rg1 --namespace-name $ehnsname \
    --name $ehname \
    --partition-count 4 --status Active

az eventhubs eventhub authorization-rule create -g $rg1 --namespace-name $ehnsname --eventhub-name $ehname --name SendPolicy --rights Send

ehconnectionstring=`az eventhubs eventhub authorization-rule keys list -g $rg1 --namespace-name $ehnsname --eventhub-name $ehname --name SendPolicy --query primaryConnectionString --output json`

logs=`cat << "EOF"
[
    {
        "category": "ArchiveLogs",
        "enabled": true,
        "retentionPolicy": {
            "days": 0,
            "enabled": false
        }
    },
    {
        "category": "OperationalLogs",
        "enabled": true,
        "retentionPolicy": {
            "days": 0,
            "enabled": false
        }
    },
    {
        "category": "AutoScaleLogs",
        "enabled": true,
        "retentionPolicy": {
            "days": 0,
            "enabled": false
        }
    }
]
EOF
`

metrics=`cat << "EOF"
[
    {
        "category": "AllMetrics",
        "enabled": true,
        "retentionPolicy": {
            "days": 0,
            "enabled": false
        },
        "timeGrain": null
    }
]
EOF
`
az monitor diagnostic-settings create \
    --resource "/subscriptions/${subscriptionid}/resourceGroups/${rg1}/providers/Microsoft.EventHub/namespaces/${ehnsname}" \
    --workspace $azmonworkspacename \
    --logs "$logs" \
    --metrics "$metrics" \
    --name $azmondiagname

az group deployment create --name "deploy_$adbsname" \
    -g $rg1 --template-file ./demo3/azure_databricks.json \
    --parameters workspaceName="$adbsname" location=$location

az group deployment create --name "deploy_$appinsightsname" \
    -g $rg1 --template-file ./demo3/azure_application_insights.json \
    --parameters name="$appinsightsname" location=$location

appinsightsinstrumentationkey=`az resource show -g $rg1 -n $appinsightsname --resource-type "Microsoft.Insights/components" --query properties.InstrumentationKey --output tsv`
echo $appinsightsinstrumentationkey

echo "please login to $DATABRICKS_HOST, choose $adbsname workspace (or connect from Azure portal) and generate a token, then set the value in _azmon1901_dbs_token"
