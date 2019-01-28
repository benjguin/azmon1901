# Assumptions:
# - This code is called by sourcing it as described in ../demo3_setup.cmd (same order for the scripts)
# - variables were initialized
# - jq is installed (sudo apt install jq)

# deploy as described here: https://github.com/aliencube/RequestBin-on-Azure-App-Service
az appservice plan create -g $rg1 --sku B1 \
    --is-linux \
    --location $location  --name $appsvcplanname \
    --output jsonc

az webapp create -g $rg1 --name $requestbinname \
    --plan $appsvcplanname \
    --deployment-container-image-name "aliencube/requestbin_with_redis:latest" \
    --output jsonc

newbin=`curl --request POST --data '' "https://${requestbinname}.azurewebsites.net/api/v1/bins"`
newbinname=`echo $newbin | jq -r '.name'`
requestbinurl="https://${requestbinname}.azurewebsites.net/${newbinname}"
