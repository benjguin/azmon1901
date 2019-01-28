# resources

## Documentation

- [Azure Monitor documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/)
    - [Branding changes](https://docs.microsoft.com/en-us/azure/azure-monitor/azure-monitor-rebrand)
    - [What is Azure Monitor?](https://docs.microsoft.com/en-us/azure/azure-monitor/overview)
- From Azure Portal:
    - <https://aka.ms/AzMonOverview>

## Recent Videos (since Ignite 2018, Sept 24-28)

- Azure Friday:
    - [Full-stack end-to-end monitoring with Azure Monitor](https://azure.microsoft.com/en-us/resources/videos/azure-friday-full-stack-end-to-end-monitoring-with-azure-monitor/)
    - [Unified alerts in Azure Monitor](https://azure.microsoft.com/en-us/resources/videos/azure-friday-unified-alerts-in-azure-monitor/)
- Ignite 2018:
    - [Everything about Azure Monitor telemetry and building integration with ITSM and SIEM tools](https://azure.microsoft.com/en-us/resources/videos/ignite-2018-everything-about-azure-monitor-telemetry-and-building-integration-with-itsm-and-siem-tools/)
    - [Full stack monitoring across application, infrastructure and network with Azure Monitor](https://azure.microsoft.com/en-us/resources/videos/ignite-2018-full-stack-monitoring-across-application-infrastructure-and-network-with-azure-monitor/)
    - [Monitor your infrastructure and analyze operational logs at scale with Azure Monitor](https://azure.microsoft.com/en-us/resources/videos/ignite-2018-monitor-your-infrastructure-and-analyze-operational-logs-at-scale-with-azure-monitor/)
    - [Strategies for migrating infrastructure monitoring from SCOM to Azure Alerts](https://myignite.techcommunity.microsoft.com/sessions/67191#ignite-html-anchor)
    - [What's new in System Center 2019](https://myignite.techcommunity.microsoft.com/sessions/64683#ignite-html-anchor)

## Trainings

- [Query Language Course and Pluralsight](https://aka.ms/KQLPluralsight)
- [Microsoft Hands On Labs](https://www.microsoft.com/handsonlabs)
    - Reviewing Service and Resource Health - VLMS0022
    - Deep Analysis with Microsoft Azure Log Analytics - VLMS0024
    - Monitor and Analyze Cloud Resources with Log Analytics and Application Insights - VLMS0035

## Screen shots

<https://docs.microsoft.com/en-us/azure/azure-monitor/app/website-monitoring>

![](https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/website-monitoring/user-flows.png)

## sandbox environment

[public Log Analytics Demo Playground](https://portal.loganalytics.io/demo#/discover/home)

or:

From the [Azure portal](https://portal.azure.com), 
- create a Log Analytics workspace
    - choose `Per GB (Standalone)` pricing tier.
- create a new "Upgrade Readiness" solution that you deploy to the workspace you just created
- go to the solution (in the same resource group as the workspace)
- select `Upgrade Readiness Settings`
- `Demo Mode`: select `Enabled`, then `Save`
- [more info](https://techcommunity.microsoft.com/t5/Windows-Analytics-resources/Windows-Analytics-Overview-Decks/m-p/173891#M1)

