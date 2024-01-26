## This code is to delete the cluster
#!/bin/bash
kops delete cluster --name kubevpro.tchfoods.com --state gs://b1-state --yes
