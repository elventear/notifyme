_notifyme-get-idle-seconds() {
    echo $(( $(sleepwatcher -g)/10 ))
}

_notifyme-is-idle() {
    test $(get-idle-seconds) -ge $NOTIFYME_IDLE_SEC   
}


