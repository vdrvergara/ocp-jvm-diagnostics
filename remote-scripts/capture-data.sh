#!/bin/sh
FOLDER=$1
PID_KEYWORD=$2

#PID=$(ps -ef | grep $PID_KEYWORD | grep -v grep | awk '{print $2}')
#PID=$(ps -ef | grep spring-boot | grep -v grep | awk '{print $2}')
PID=$(ps -ef | grep $PID_KEYWORD | head -1 | awk '{print $2}')
if [ -z "$PID" ]
then 
  echo "***** ERROR ****"
  echo "Invalid PID returned. Please check $PID_KEYWORD and ensure application is currently running."
  echo 
else 
  echo " * Gathering data for Process id=$PID  "
fi
echo

echo "POD: Capturing sequence of thread dumps "
echo "---------------------------------------"
/home/jboss/$FOLDER/remote-scripts/ocp_high_cpu_linux_jstack.sh $FOLDER $PID
if [ $? != 0 ]
then
  echo "***** ERROR ****"
  echo "Error capturuing thread dumps for pid=$PID."
  echo "This run of the script will not gather all the required data."
else
  echo "Done."
fi
echo

echo "POD: Taking heap dump"
#echo "======================================="
echo "---------------------------------------"
jmap -dump:format=b,file=$FOLDER/heap.hprof $PID
if [ $? != 0 ]
then
  echo "***** ERROR ****"
  echo "Error taking JVM heap dump of the Spring Boot container  with pid $processId."
  echo "This run of the script will not gather all the required data."
else
  echo "Done."
fi
echo

#echo "Capture SOS Report "
#sosreport --batch --ticket-number=TBD --name=customer

