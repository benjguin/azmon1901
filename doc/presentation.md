# Presentation

## Introduction

Azure Monitor definition and rebranding

![](https://docs.microsoft.com/en-us/azure/azure-monitor/media/overview/overview.png)

Documentation is available at <https://docs.microsoft.com/en-us/azure/azure-monitor/>

## Monitor VMs, Network, apps

![](img/demo1/1.png)

![](img/demo1/2.png)

![](img/demo1/3.png)

![](img/demo1/4.png)

![](img/demo1/5.png)

![](img/demo1/6.png)

## Monitor Containers

![](img/demo2/1.png)

![](img/demo2/2.png)

![](img/demo2/3.png)

![](img/demo2/4.png)

## demo with Azure Databricks

![](img/demo3/001.png)

```py
from applicationinsights import TelemetryClient

instrumentationKey="415d6447-a144-4683-9362-a86f2a3f69ec"

def NewTelemetryClient (applicationId, operationId="",  
  parentOperationId=""):
  tc = TelemetryClient(instrumentationKey)
  tc.context.application.id = applicationId
  tc.context.application.ver = '0.0.1'
  tc.context.device.id = 'Databricks notebook'
  tc.context.operation.id = operationId
  tc.context.operation.parentId = parentOperationId
  return tc
```

```py
#setup other needed variables
telemetryClient = NewTelemetryClient("mon001", operationId, parentOperationId)
telemetryClient.context.operation.name = "Monitoring 001"
```

```py
import datetime

jobStartTime = datetime.datetime.now()
jobStartTimeStr = str(jobStartTime)
telemetryClient.track_event('StartJob', { 'StartTime': jobStartTimeStr,
  'caller':callerName})
telemetryClient.flush()
```

(...)

```py
jobEndTime = datetime.datetime.now()
jobEndTimeStr = str(jobEndTime)
jobDuration = jobEndTime - jobStartTime
jobDurationStr = str(jobDuration)

telemetryClient.track_metric('jobDurationSeconds', jobDuration.total_seconds())
telemetryClient.flush()
```

```py
telemetryClient.track_event('EndJob', { 'callerName': callerName, 'streamRate': streamRate, 'streamDuration': streamDuration,'startTime': jobStartTimeStr, 'endTime': jobEndTimeStr, 'duration': jobDurationStr})
telemetryClient.flush()
```

![](img/demo3/002.png)

```kql
search *
| summarize count() by $table

customEvents 
| order by timestamp asc

customMetrics
| order by timestamp asc
```

![](img/demo3/003.png)

![](img/demo3/004.png)

![](img/demo3/005.png)

![](img/demo3/006.png)

![](img/demo3/007.png)

![](img/demo3/008.png)

```kql
AzureMetrics
| summarize count() by MetricName

AzureMetrics
| where MetricName == "IncomingMessages" 
| where Average > 0
| project TimeGenerated , Minimum, Average, Maximum, Count
| order by TimeGenerated desc
| render timechart 
```

![](img/demo3/009.png)

![](img/demo3/010.png)

![](img/demo3/011.png)

![](img/demo3/012.png)

![](img/demo3/013.png)

![](img/demo3/014.png)

![](img/demo3/015.png)

## More in the repo	

<https://github.com/benjguin/azmon1901>

## Conclusion Q&A	

