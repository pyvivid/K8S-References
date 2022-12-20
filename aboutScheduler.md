> We understand that Kubernetes has an algorithm that distributes pods across nodes evenly, as well as takes into consideration various conditions we specify through taints and tolerations and node affinity, et cetera.

> Kubernetes cluster can have multiple schedulers running at a time, with each of the Scheduler to manage their own set of applications. Say you have a specific application that requires its components to be placed on nodes after performing some additional checks. So you decide to have your own scheduling algorithm to place pods on nodes so that you can add your own custom conditions and checks in it.

> Kubernetes is highly extensible, allowing you to write your own Kubernetes scheduler program, package it and deploy it as the default scheduler or as an additional scheduler in the Kubernetes cluster.
