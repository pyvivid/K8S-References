
## Validate Cluster
## alias validate='./clustervalidate.sh'
## Above line will create a temp command to just run # validate and we can run the below command multiple times to verify.
#!/bin/bash
kops validate cluster --state gs://inft-kops-state
