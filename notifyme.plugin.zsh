function notifyme-remote() {
    local plugin_name
    local plugin_func
    for plugin_name in $NOTIFYME_REMOTE; do
        plugin_func=notifyme-$plugin_name
        _notifyme-exists $plugin_func || continue
        $plugin_func $1 $2
    done
}

function notifyme-local() {
    local plugin_name
    local plugin_func
    for plugin_name in $NOTIFYME_LOCAL; do
        plugin_func=notifyme-$plugin_name
        _notifyme-exists $plugin_func || continue        
        $plugin_func $1 $2
    done
}

function notifyme-is-idle() {
    local plugin_name
    local plugin_func
    for plugin_name in $NOTIFYME_IDLE; do
        plugin_func=notifyme-$plugin_name
        _notifyme-exists $plugin_func || continue
        test $($plugin_func) -ge $NOTIFYME_IDLE_SEC && return 0
    done
    return 1
}

function notifyme() {
    test -z $1 && test -z $2 && return 1
    local NAME=$1
    local MESSAGE=$2
    notifyme-local $NAME $MESSAGE
    if notifyme-is-idle; then
        notify-remote $NAME $MESSAGE
    fi
}

function _notifyme-exists {
    whence $1 > /dev/null
}

# init
function {
    local plugins=$location/plugins
    local plugin
    for plugin in $NOTIFYME_LOCAL; do
        source $plugins/$plugin.zsh
    done
    for plugin in $NOTIFYME_REMOTE; do
        source $plugins/$plugin.zsh
    done
    for plugin in $NOTIFYME_IDLE; do
        source $plugins/$plugin.zsh
    done
}
