NOTIFYME_IDLE_SEC=60

get-idle-seconds () {
    echo $(( $(sleepwatcher -g)/10 ))
}

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
    local NAME=$1
    local MESSAGE=$2
    notifyme-local $NAME $MESSAGE
    if [ $(get-idle-seconds) -ge $NOTIFYME_IDLE_SEC ]; then
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

function _notifyme-init() {
    _notifyme-source-plugins 'local' NOTIFYME_LOCAL
    _notifyme-source-plugins 'remote' NOTIFYME_REMOTE
}

_notifyme-init

unset -f _notifyme-init
unset -f _exists
