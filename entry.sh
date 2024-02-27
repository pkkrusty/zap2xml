#!/bin/sh
unset RETRY_INTERVAL
while true; do
    RUN_TIME="$(date '+%s')"
    # shellcheck disable=SC2086
    /zap2xml.pl -u "$USERNAME" -p "$PASSWORD" -U -o "/data/$XMLTV_FILENAME" $OPT_ARGS
    printf 'Run time: '
    date -d "@$RUN_TIME" '+%F %T %Z'
    MOD_TIME="$(date -r "/data/$XMLTV_FILENAME" '+%s')"
    if test "$MOD_TIME" -gt "$RUN_TIME"; then
        echo "Will run again in $SLEEPTIME seconds."
        unset RETRY_INTERVAL
        sleep "$SLEEPTIME"
    elif [ -z "$RETRY_INTERVAL" ]; then
        echo 'This run did not complete successfully, trying again...'
        RETRY_INTERVAL='30'
    else
        echo "This run did not complete successfully, trying again in $RETRY_INTERVAL seconds..."
        sleep "$RETRY_INTERVAL"
        RETRY_INTERVAL="$(( RETRY_INTERVAL * 2 ))"
        if test "$RETRY_INTERVAL" -gt "$SLEEPTIME"; then
            RETRY_INTERVAL='30'
        fi
    fi
done
