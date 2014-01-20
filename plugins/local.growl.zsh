function notifyme-growl() {
    growlnotify -n $1 -m $2
}

function _notifyme-plugin() {
    which -s growlnotify > /dev/null && echo notifyme-growl || unset -f notifyme-growl
}
