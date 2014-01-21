#notifyme

## Installation

Using [antigen](https://github.com/zsh-users/antigen) (required):

* In your `~/.zshrc` declare the configuration in the environment variables:
	* `NOTIFYME_LOCAL`
	* `NOTIFYME_REMOTE`
	* `NOTIFYME_IDLE`
	* `NOTIFYME_IDLE_SECS`

followed by the following line to initialize plugin:
	
    antigen bundle elventear/notifyme

## Configuration

The following environmental variables need to be declared before the plugin is enabled. 

### `NOTIFYME_LOCAL` & `NOTIFYME_REMOTE`

ZSH arrays containing the names of the notification plugins to trigger a notification event. Plugins declared in an array are activated in sequential order.
 
`NOTIFYME_LOCAL` notifications happen always when a notification is triggered.

`NOTIFYME_REMOTE` notifications happen only if the computer has been determined to be in idle state. 

For available plugins see files within the `plugins/` subdirectory.

### `NOTIFYME_IDLE`

ZSH array containing the names of utilities to determine if the computer is in idle state state. 

For available plugins see files within the `plugins/` subdirectory.

### `NOTIFYME_IDLE_SECS`

Variable containing the amount of seconds that the computer needs to be unused in order to determine that is in indue state.


## Usage

To emit a new notification call:

    > notifyme name message 

Where:

* `name`: identifier for the type of event
* `message: text explaining specific event 

Example `.zshrc`:
        
        # Env variables with configuration settings	
	NOTIFYME_LOCAL=(growl)
	NOTIFYME_REMOTE=(pushover)
	NOTIFYME_IDLE=(sleepwatcher)
	NOTIFYME_IDLE_SECS=60
	
        # Initialize antigen bundle
	antigen bundle elventear/notifyme

        # Wrapped function that will use notifyme to report return status	
	function gradle {
    	    local reason
    	    local e
    	    $HOME/.gvm/gradle/current/bin/gradle $@ 
    	    e=$?
    	    if [ $e -eq 0 ]; then 
            	reason=success
    	    else
            	reason=failure
    	    fi
    	    notifyme gradle "${PWD##*/} $reason: gradle $@"
    	    return $e
	}	
