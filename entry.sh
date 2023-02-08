#!/bin/sh
while true; do
    RUN_TIME="$(date '+%s')"
    # shellcheck disable=SC2086
    /zap2xml.pl -u "$USERNAME" -p "$PASSWORD" -U -o "/data/$XMLTV_FILENAME" $OPT_ARGS
    printf 'Run time: '
    date -d "@$RUN_TIME" '+%F %T %Z'
    MOD_TIME="$(date -r "/data/$XMLTV_FILENAME" '+%s')"
    if test "$MOD_TIME" -gt "$RUN_TIME"; then
        echo "Will run again in $SLEEPTIME seconds."
        sleep "$SLEEPTIME"
    else
        echo 'This run did not complete successfully.'
        echo 'Pausing for 30 seconds and trying again...'
        sleep 30
    fi
done
