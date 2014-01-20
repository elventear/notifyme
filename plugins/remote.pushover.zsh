function notifyme-pushover() {
    local MESSAGE="$1 $2"
    if [ -n "$PUSHOVER_APP_TOKEN" -a -n "$PUSHOVER_USER_KEY" ]; then
        test ${#MESSAGE} -gt 0 || return 1
        curl -s \
            -F "token=$PUSHOVER_APP_TOKEN" \
            -F "user=$PUSHOVER_USER_KEY" \
            -F "message=$MESSAGE" \
            https://api.pushover.net/1/messages.json > /dev/null
    fi
}

# init
function _notifyme-plugin() {
    source ~/.PUSHOVER_TOKEN > /dev/null && echo notifyme-pushover || unset -f notifyme-pushover
}
