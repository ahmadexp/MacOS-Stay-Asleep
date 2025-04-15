#!/bin/bash

# Check if the system just woke up recently (within the last 1 minute)
recentWake=$(pmset -g log | grep " Wake " | tail -1 | awk -F';' '{print $1}')
wakeTimestamp=$(date -j -f "%m/%d/%y %H:%M:%S" "$recentWake" "+%s" 2>/dev/null)

if [ -z "$wakeTimestamp" ]; then
  exit 0
fi

currentTimestamp=$(date "+%s")
timeDiff=$((currentTimestamp - wakeTimestamp))

# If wake was more than 60 seconds ago, skip
if [ "$timeDiff" -gt 60 ]; then
  exit 0
fi

# Check if the internal display is offline
internalDisplayStatus=$(ioreg -n AppleBacklightDisplay | grep IODisplayPowerState | awk '{print $NF}')

# 0 = off (likely lid closed), 1 = dim, 2 = on
if [ "$internalDisplayStatus" = "0" ]; then
  echo "Lid appears to be closed, putting system back to sleep."
  pmset sleepnow
else
  echo "Lid is open or display is active. Not sleeping."
fi
