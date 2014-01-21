function notifyme-growl() {
    growlnotify -n $1 -m $2
}

function {
    _notifyme-exists growlnotify || unset -f notifyme-growl
}
