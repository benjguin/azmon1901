# variables starting by an underscore are set in the .profile
# e.g. 
# export _example="value for variable _example"
#
# These variables are:
# - _azure_subscription: the name of the Azure subscription we want to use. e.g. "Azure consumption"
# - _azmon1901_suffix: a short suffix that will help people using the same scripts have different resource names. Some resources have to have unique names. e.g. "my007"
# - _azmon1901_path: the local path to the root of this repo. e.g. "/mnt/c/dev/GitHub/azmon1901a"
# - _my_email: e-mail address where alerts will be sent

# you can change the following varibales to better fit your environment. You can also reuse those values.

subscription="$_azure_subscription" # the name of your Azure subscription. It can contain spaces.
location="westeurope" # Azure region where everything will be deployed
rg1="a_azmonrg_$suffix" # resource group name where the resources will be deployed
suffix="$_azmon1901_suffix" # A suffix that make your names unique
storage1name="azmonstor$suffix" # Storage account
adbsname="adbs$suffix" # Azure Databricks workspace name
appinsightsname="appinsights$suffix" # Name of the Application Insights workspace
ehnsname="azmehns$suffix" # Event Hubs namespace
ehname="azmeh$suffix" # Event Hub
azmonworkspacename="azmwksp$suffix" # Azure Monitor Workspace
azmondiagname="azmdiags$sufix" # diagnostics settings name
appsvcplanname="appsvcplan$suffix"
requestbinname="rqbin$suffix"
alertactionemail="$_my_email"
alertactionname="alertactiongrp$suffix"
alert1rulename="alert1$suffix"

export DATABRICKS_HOST="https://${location}.azuredatabricks.net"
