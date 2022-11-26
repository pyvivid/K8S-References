# Edit the file below, as required for creating the cluster.
#!/bin/bash
kops create cluster --name kubevpro.tchfoods.com --zones us-west1-a,us-west1-b --node-count 2 --node-size e2-highcpu-2 --master-size n2-highcpu-2 \
	--dns-zone kubevpro.tchfoods.com \
	--state gs://inft-kops-state \
	--project responsive-lens-363316
