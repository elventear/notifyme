function notifyme-pushover() {
    local MESSAGE
    MESSAGE="$@"
    if [ -n "$PUSHOVER_APP_TOKEN" -a -n "$PUSHOVER_USER_KEY" ]; then
        test ${#MESSAGE} -gt 0 || return 1
        curl -s \
            -F "token=$PUSHOVER_APP_TOKEN" \
            -F "user=$PUSHOVER_USER_KEY" \
            -F "message=$MESSAGE" \
            https://api.pushover.net/1/messages.json > /dev/null
    fi
}

function _notifyme-plugin() {
    test -f ~/.PUSHOVER_TOKEN && source ~/.PUSHOVER_TOKEN || unset -f notifyme-pushover
}
