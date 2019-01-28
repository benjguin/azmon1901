# Assumptions:
# - This code is called by sourcing it as described in ../demo3_setup.cmd (same order for the scripts)
# - variables were initialized

export DATABRICKS_TOKEN="$_azmon1901_dbs_token"

cp demo3/mon001.py /tmp/
# use of | (ASCII 0124) sign: cf https://stackoverflow.com/questions/16790793/how-to-replace-strings-containing-slashes-with-sed
sed -i -e "s|____appinsightsinstrumentationkey____|${appinsightsinstrumentationkey}|g" /tmp/mon001.py
sed -i -e "s|____ehconnectionstring____|${ehconnectionstring}|g" /tmp/mon001.py
databricks workspace import --language PYTHON /tmp/mon001.py /Shared/mon001.py 
rm /tmp/mon001.py
databricks jobs create --json-file ./demo3/mon001Job.json
