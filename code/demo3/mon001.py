# Databricks notebook source
# MAGIC %md
# MAGIC 
# MAGIC # Monitoring to Application insights

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC most of this code comes from <https://msdn.microsoft.com/en-us/magazine/mt846727.aspx>

# COMMAND ----------

from applicationinsights import TelemetryClient

instrumentationKey="____appinsightsinstrumentationkey____"

def NewTelemetryClient (applicationId, operationId="",  
  parentOperationId=""):
  tc = TelemetryClient(instrumentationKey)
  tc.context.application.id = applicationId
  tc.context.application.ver = '0.0.1'
  tc.context.device.id = 'Databricks notebook'
  tc.context.operation.id = operationId
  tc.context.operation.parentId = parentOperationId
  return tc

# COMMAND ----------

dbutils.widgets.text("callerName", "unknown_caller", "caller name")
dbutils.widgets.text("streamRate", "1", "stream rate (rows per second)")
dbutils.widgets.text("streamDuration", "30", "stream duration in seconds")

# COMMAND ----------

callerName = dbutils.widgets.get("callerName")
streamRate = int(dbutils.widgets.get("streamRate"))
streamDuration = int(dbutils.widgets.get("streamDuration"))
operationId = "sampleOperationId"
parentOperationId = "sampleParentOperationId"

#setup other needed variables
telemetryClient = NewTelemetryClient("mon001", operationId, parentOperationId)
telemetryClient.context.operation.name = "Monitoring 001"

# COMMAND ----------

import datetime

jobStartTime = datetime.datetime.now()
jobStartTimeStr = str(jobStartTime)
telemetryClient.track_event('StartJob', { 'StartTime': jobStartTimeStr,
  'caller':callerName})
telemetryClient.flush()

# COMMAND ----------

from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql import *
from pyspark.sql.streaming import *

from time import sleep

# COMMAND ----------

df1=spark.readStream \
  .format("rate") \
  .option("rampUpTime", "0s") \
  .option("numPartitions", 4) \
  .option("rowsPerSecond", streamRate) \
  .load()

# COMMAND ----------

df1.createOrReplaceTempView("df1")

# COMMAND ----------

# MAGIC %sql
# MAGIC 
# MAGIC create or replace temp view df2 as
# MAGIC select CONCAT('{"timestamp":', timestamp, ', "value":', value, '}') as body
# MAGIC from df1;

# COMMAND ----------

df2 = spark.sql("select * from df2")

# COMMAND ----------

# Set up the Event Hub config dictionary with default settings
writeConnectionString = ____ehconnectionstring____
ehWriteConf = {
  "eventhubs.connectionString" : writeConnectionString
}

ds=df2.writeStream \
  .format("eventhubs") \
  .outputMode("update") \
  .options(**ehWriteConf) \
  .trigger(processingTime="2 seconds") \
  .option("checkpointLocation", "/checkpoint/" + callerName + "/" + str(jobStartTime.timestamp()) + "/") \
  .start()


# COMMAND ----------

sleep(streamDuration)

# COMMAND ----------

ds.stop()

# COMMAND ----------

jobEndTime = datetime.datetime.now()
jobEndTimeStr = str(jobEndTime)
jobDuration = jobEndTime - jobStartTime
jobDurationStr = str(jobDuration)

telemetryClient.track_metric('jobDurationSeconds', jobDuration.total_seconds())
telemetryClient.flush()

# COMMAND ----------

telemetryClient.track_event('EndJob', { 'callerName': callerName, 'streamRate': streamRate, 'streamDuration': streamDuration,'startTime': jobStartTimeStr, 'endTime': jobEndTimeStr, 'duration': jobDurationStr})
telemetryClient.flush()
