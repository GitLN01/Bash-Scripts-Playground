#!/bin/bash

# 10. Write a script to monitor a directory and send a Slack notification in??devops-test??channel if a new file is added. (Webhook URL za slack channel:??https://hooks.slack.com/services/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

MONITOR_DIR=$(pwd)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"

send_slack_notification()
{
	local filename=$1
	local payload=$(cat <<EOF
{
    "text": "A new file has been added: *$filename*",
    "blocks": [
        {
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": ":file_folder: *File Alert*\nA new file has been detected in the monitored directory: \`$filename\`."
            }
        },
        {
            "type": "context",
            "elements": [
                {
                    "type": "mrkdwn",
                    "text": "Directory: $MONITOR_DIR"
                }
            ]
        }
    ]
}
EOF
    )
	curl -X POST -H "Content-type: application/json" --data "$payload" "$SLACK_WEBHOOK_URL" || echo "Failed to send Slack notification for this file: $filename"
}

if [[ ! -d "$MONITOR_DIR" ]]; then
	echo "Error: Directory $MONITOR_DIR doesnt exist"
	exit 1
fi

echo "Monitoring directory: $MONITOR_DIR"

processed_files=$(mktemp)

ls "$MONITOR_DIR" > "$processed_files" 2>/dev/null

while true; do
    current_files=$(ls "$MONITOR_DIR" 2>/dev/null)

    for file in $current_files; do
        if ! grep -Fxq "$file" "$processed_files"; then
            echo "New file detected: $file"
            send_slack_notification "$file"
            echo "$file" >> "$processed_files"
        fi
    done

    sleep 2
done
	 
