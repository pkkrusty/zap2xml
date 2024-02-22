#!/bin/sh
while true; do
    DATE="$(date)"
    # shellcheck disable=SC2086
    /zap2xml.pl -u "$USERNAME" -p "$PASSWORD" -U -o "/data/$XMLTV_FILENAME" $OPT_ARGS
    echo "Last run time: $DATE"
    echo "Will run in $SLEEPTIME seconds"
    sleep "$SLEEPTIME"
done
