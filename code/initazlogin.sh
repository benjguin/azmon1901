# check if az login was done before starting this script, and if so then connect to the correct subscription
loggedin=`az account show -s "$subscription" --output json | grep "$subscription" | wc -l`
while [ $loggedin -eq 0 ]
do
    az login
    loggedin=`az account show -s "$subscription" --output json | grep "$subscription" | wc -l`
done
az account set -s "$subscription"
az account show
