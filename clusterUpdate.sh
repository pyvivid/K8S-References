## Edit the command according to the cluster name and the bucket name
#!/bin/bash
kops update cluster --name kubevpro.tchfoods.com --state gs://inft-kops-state --yes --admin
