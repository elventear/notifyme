# OSX only. Uses http://growl.info via growlnotify

function notifyme-growl() {
    growlnotify -n "$1" -m "$2"
}

function {
    _notifyme-exists growlnotify || unset -f notifyme-growl
}
