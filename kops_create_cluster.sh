## Before using this script ref to kops-dom-srv-gce-setup.txt
#!/bin/bash
kops create cluster --name kubevpro.tchfoods.com --zones us-west1-a,us-west1-b --node-count 2 --node-size e2-highcpu-2 --master-size n2-highcpu-2 --dns-zone kubevpro.tchfoods.com --state gs://b1-state --project our-time-372214

