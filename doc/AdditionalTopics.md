# Presentation

## Data

<https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview>

![](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/media/log-query-overview/queries-overview.png)

![](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/media/log-query-overview/queries-tables.png)

## Service dependencies

### dependency map

dependency map:
- <https://docs.microsoft.com/en-us/azure/azure-monitor/insights/vminsights-overview>

### dependencies in applications

dependencies in AppInsights:
- <https://docs.microsoft.com/en-us/azure/azure-monitor/app/asp-net-dependencies#diagnosis>

```C#
var startTime = DateTime.UtcNow;
var timer = System.Diagnostics.Stopwatch.StartNew();
try
{
    success = dependency.Call();
}
finally
{
    timer.Stop();
    telemetry.TrackDependency("myDependency", "myCall", startTime, timer.Elapsed, success);
    // The call above has been made obsolete in the latest SDK. The updated call follows this format:
    // TrackDependency (string dependencyTypeName, string dependencyName, string data, DateTimeOffset startTime, TimeSpan duration, bool success);
}
```

```Kusto
dependencies
    | where timestamp > ago(1d) and  client_Type != "Browser"
    | join (requests | where timestamp > ago(1d))
      on operation_Id
```

### Azure Resource Graph

<https://docs.microsoft.com/en-us/azure/governance/resource-graph/overview>

## Query the data

- <https://docs.microsoft.com/en-us/azure/kusto/query/>
- <https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/examples>
- [Analyze data in Azure Data Explorer using KQL magic for Jupyter Notebook](https://azure.microsoft.com/en-us/blog/analyze-data-in-azure-data-explorer-using-kql-magic-for-jupyter-notebook/) ![](https://azurecomcdn.azureedge.net/mediahandler/acomblog/media/Default/blog/02a47d86-007f-4bb6-8ec7-61f67a87eebb.png)

## custom portal

- Azure dashboards

## Monitor ...

- VMs
- Apps
- containers



## Integration

Power BI:
 - <https://docs.microsoft.com/en-us/azure/azure-monitor/platform/powerbi>
 - <https://docs.microsoft.com/en-us/azure/azure-monitor/app/export-power-bi>
 
Grafana:
- <https://docs.microsoft.com/en-us/azure/azure-monitor/platform/grafana-plugin>

ITSM:
- <https://docs.microsoft.com/en-us/azure/azure-monitor/platform/itsmc-overview>
    - ServiceNow
    - System Center Service Manager
    - Provance
    - Cherwell

Export Activity or diagnostic logs to Blob Storage or stream it to Event Hubs
- <https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-logs-stream-event-hubs>
- <https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostic-logs-stream-event-hubs>

- Application Insights to storage, then Stream Analytics
- <https://docs.microsoft.com/en-us/azure/azure-monitor/app/export-telemetry>
- <https://docs.microsoft.com/en-us/azure/azure-monitor/app/export-stream-analytics> ![](https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/export-stream-analytics/020.png)

## Workspaces and Application Insights

How to create new workspaces


How to query from different workspaces:
- <https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/cross-workspace-query>
- <https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/app-expression>
- <https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/workspace-expression>

```
union Update, workspace("contosoretail-it").Update, workspace("b459b4u5-912x-46d5-9cb1-p43069212nb4").Update
| where TimeGenerated >= ago(1h)
| where UpdateState == "Needed"
| summarize dcount(Computer) by Classification
```

create a function called `applicationsScoping` 

```
// crossResource function that scopes my Application Insights resources
union withsource= SourceApp
app('Contoso-app1').requests, 
app('Contoso-app2').requests,
app('Contoso-app3').requests,
app('Contoso-app4').requests,
app('Contoso-app5').requests
```

```
applicationsScoping 
| where timestamp > ago(12h)
| where success == 'False'
| parse SourceApp with * '(' applicationName ')' * 
| summarize count() by applicationName, bin(timestamp, 1h) 
| sort by count_ desc 
| render timechart
```

## Metrics

duration as expressed in the `timeGrain` column (e.g. PT1M) follows [ISO_8601](https://en.wikipedia.org/wiki/ISO_8601)

## Endpoint monitoring

TBD

## Alerts

- [Smart Groups](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-smartgroups-overview)

## Configure and manage from the command line

- <https://docs.microsoft.com/en-us/azure/azure-monitor/platform/cli-samples>

## demo

## management solutions

<https://docs.microsoft.com/en-us/azure/azure-monitor/insights/solutions-inventory>

## Pricing

<https://azure.microsoft.com/en-us/pricing/details/monitor/>

<https://azure.microsoft.com/en-us/blog/introducing-a-new-way-to-purchase-azure-monitoring-services/>

<https://docs.microsoft.com/en-us/azure/azure-monitor/platform/usage-estimated-costs>
