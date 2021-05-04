#!/bin/bash
NODE=$1
echo ${NODE}
for POD in $( oc get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' --field-selector spec.nodeName=$NODE --all-namespaces )
do
  oc adm top pods --all-namespaces | grep $POD 
done	
