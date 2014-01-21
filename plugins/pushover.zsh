# Emits http calls to the  https://pushover.net service

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

function {
    local TOKEN=~/.PUSHOVER_TOKEN
    _notifyme-exists curl && [[ -f $TOKEN ]] && source $TOKEN > /dev/null ||  unset -f notifyme-pushover
}
