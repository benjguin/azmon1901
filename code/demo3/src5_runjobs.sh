# Assumptions:
# - This code is called by sourcing it as described in ../demo3_setup.cmd (same order for the scripts)
# - variables were initialized

export DATABRICKS_TOKEN="$_azmon1901_dbs_token"
jobid=`databricks jobs list | grep mon001Job | awk '{print $1}'`
databricks jobs run-now --job-id $jobid --notebook-params '{"callerName":"demo3_setup_01", "streamRate": "10", "streamDuration": "120"}'
databricks jobs run-now --job-id $jobid --notebook-params '{"callerName":"demo3_setup_02", "streamRate": "2", "streamDuration": "90"}'
