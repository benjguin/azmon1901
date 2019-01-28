# Assumptions:
# - This code is called by sourcing it as described in ../demo3_setup.cmd (same order for the scripts)
# - variables were initialized

az monitor action-group create -g $rg1 \
    --name "$alertactionname" \
    --action webhook webhook_example "$requestbinurl" \
    --action email email_example "$alertactionemail"

az group deployment create --name "deploy_$alert1rulename" \
    -g $rg1 --template-file ./demo3/azure_alert_rule.json \
    --parameters name="$alert1rulename" location="$location" actionGroupName="$alertactionname" appInsightsName="$appinsightsname"
