# Emits http calls to the  https://pushover.net service

# Requires the API keys for Pushover in ~/.PUSHOVER_TOKEN exposed as
# PUSHOVER_APP_TOKEN and PUSHOVER_USER_KEY
#
# Example:
#
# PUSHOVER_USER_KEY=keyval
# PUSHOVER_APP_TOKEN=keyval

function notifyme-pushover() {
    (local -r TOKEN=~/.PUSHOVER_TOKEN
    source $TOKEN > /dev/null
    local MESSAGE="$1 $2"
    if [ -n "$PUSHOVER_APP_TOKEN" -a -n "$PUSHOVER_USER_KEY" ]; then
        test ${#MESSAGE} -gt 0 || return 1
        curl -s \
            -F "token=$PUSHOVER_APP_TOKEN" \
            -F "user=$PUSHOVER_USER_KEY" \
            -F "message=$MESSAGE" \
            https://api.pushover.net/1/messages.json > /dev/null
    fi)
}

function {
    local -r TOKEN=~/.PUSHOVER_TOKEN
    _notifyme-exists curl && [[ -f $TOKEN ]] ||  unset -f notifyme-pushover
}
