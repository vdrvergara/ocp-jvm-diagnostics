# JVM Diagnostics for JBoss EAP 7.0

## Introduction

Execute the script gather-ocp-diagnostic-data.sh with the deployment config name as parameter in the namespace that you want the diagnostics done.

deploymentconfig=application-test

  ./gather-ocp-diagnostic-data.sh application-test
  
The permission for executing the terminal in the container and copy files to the container must be available.
