#!/bin/bash

#Variables#

HOSTNAME="$(hostname)"
TARGET="VBRSCANRT-001"
SCRIPT_NAME="$0"
IP="192.168.18.1"
STATE_FILE="/tmp/host_state"
SLACK_URL="https://hooks.slack.com/services/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"
EMAIL="lazar.nikitovic@delsystems.net"


send_slack () {
        [ -z "$SLACK_URL" ] && echo "Unable to send slack because SLACK_URL variable is empty!" && return 1;
        FORMATED_MESSAGE=$(echo "$1" | sed 's/"/\\"/g' | sed "s/'/\\'/g" )
        curl -s -X POST "$SLACK_URL" -H 'Content-type: application/json' --data '{"text":"'"$HOSTNAME: $SCRIPT_NAME: $FORMATED_MESSAGE"'"}' >/dev/null
}

send_email () {
    SUBJECT="[$HOSTNAME] Alert: $TARGET status change"
    BODY="$1"
    echo -e "Subject: $SUBJECT\n\n$BODY" | msmtp "$EMAIL"
}

ping -c 5 -i 0.2 -W 1 "$IP" &>/dev/null
STATE=$?

if [ -f "$STATE_FILE" ]; then
    PREV_STATE=$(cat "$STATE_FILE")
else
    PREV_STATE="unknown"
fi

if [ "$STATE" != "$PREV_STATE" ]; then
    if [ "$STATE" -eq 0 ]; then
        MSG="$TARGET ($IP) is reachable."
    else
        MSG="$TARGET ($IP) is unreachable!"
    fi

    send_slack "$MSG"
    send_email "$MSG"

    echo "$STATE" > "$STATE_FILE"
fi
