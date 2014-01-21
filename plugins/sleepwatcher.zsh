notifyme-sleepwatcher() {
    echo $(( $(sleepwatcher -g)/10 ))
}

function {
    _notifyme-exists sleepwatcher || unset -f notifyme-sleepwatcher
}
