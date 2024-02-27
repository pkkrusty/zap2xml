#!/bin/sh

download() {
    RETRY_INTERVAL='30'
    while true; do
        RUN_TIME="$(date '+%s')"
        # shellcheck disable=SC2086
        /zap2xml.pl -u "$1" -p "$2" -U -o "$3" $OPT_ARGS
        printf 'Run time: '
        date -d "@$RUN_TIME" '+%F %T %Z'
        if [ -f "$3" ]; then
            MOD_TIME="$(date -r "$3" '+%s')"
        else
            MOD_TIME='0'
        fi
        if test "$MOD_TIME" -lt "$RUN_TIME"; then
            echo "This run did not complete successfully, trying again in $RETRY_INTERVAL seconds..."
            sleep "$RETRY_INTERVAL"
            RETRY_INTERVAL="$(( RETRY_INTERVAL * 2 ))"
            if test "$RETRY_INTERVAL" -gt "$SLEEPTIME"; then
                RETRY_INTERVAL='30'
            fi
        else
            echo 'Run successful.'
            break
        fi
    done
}

while true; do
    download "$USERNAME" "$PASSWORD" "/data/$XMLTV_FILENAME"
    echo "Will run again in $SLEEPTIME seconds."
    unset RETRY_INTERVAL
    sleep "$SLEEPTIME"
done
