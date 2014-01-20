function notifyme-remote() {
    for plugin_name in $NOTIFYME_REMOTE; do
        $plugin_name $1 $2
    done
}

function notifyme-local() {
    for plugin_name in $NOTIFYME_LOCAL; do
        $plugin_name $1 $2
    done
}

function notifyme() {
    test -z $1 && test -z $2 && return 1
    local NAME=$1
    local MESSAGE=$2
    notifyme-local $NAME $MESSAGE
    if _notifyme-is-idle; then
        notify-remote $NAME $MESSAGE
    fi
}

function _exists {
    whence $1 > /dev/null
}

function _notifyme-source-plugins() {
    local plugin_file
    local -a plugin_names

    for plugin_file in plugins/$1.*.zsh; do
        source $plugin_file
        _exists _notifyme-plugin && plugin_names+=($(_notifyme-plugin))
    done 
        
    _exists _notifyme-plugin && unset -f _notifyme-plugin

    set -A $2 $plugin_names
}

# init
function {
    source plugins/is.idle.zsh
    _notifyme-source-plugins 'local' NOTIFYME_LOCAL
    _notifyme-source-plugins 'remote' NOTIFYME_REMOTE
}

unset -f _notifyme-source-plugins
unset -f _exists
