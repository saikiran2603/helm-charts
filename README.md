# helm-charts

Helm chart for Hive-metastore with Database  

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

        helm repo add saikiran2603 https://saikiran2603.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
<alias>` to see the charts.

To install the <chart-name> chart:

    helm install my-hive-chart saikiran2603/hive-metastore

To uninstall the chart:

    helm delete my-hive-chart
    
## Docker Images 
    
View published docker images [here](https://hub.docker.com/u/neo2603)
    
