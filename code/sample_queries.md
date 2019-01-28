# Sample Queries

## Find the workspaces

```bash
az resource list --resource-type Microsoft.OperationalInsights/workspaces
```

## discover logs and metrics

```
search * 
| limit 100
```


```
search * 
| summarize count() by $table
```


## on my subscription

```
search *
| summarize count() by $table

workspace('oms-west-europe').Usage | limit 10

workspace('oms-west-europe').AzureMetrics | limit 10

workspace('defaultworkspace-b4ed3d75-dd0d-4660-aacd-7cb2d1bed125-weu').Usage | limit 10

workspace('defaultworkspace-b4ed3d75-dd0d-4660-aacd-7cb2d1bed125-weu').Operation | limit 10

union
workspace('oms-west-europe').Usage, 
workspace('oms-west-europe').AzureMetrics, 
workspace('defaultworkspace-b4ed3d75-dd0d-4660-aacd-7cb2d1bed125-weu').Usage,
workspace('defaultworkspace-b4ed3d75-dd0d-4660-aacd-7cb2d1bed125-weu').Operation
| search *
| summarize count() by $table
```