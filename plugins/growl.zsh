function notifyme-growl() {
    growlnotify -n $1 -m $2
}

# init
function _notifyme-plugin() {
    which -s growlnotify > /dev/null && echo notifyme-growl || unset -f notifyme-growl
}
