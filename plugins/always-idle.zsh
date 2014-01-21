# Always idle, useful for testing

notifyme-always-idle() {
    echo $(( $NOTIFYME_IDLE_SECS * 10 ))
}
