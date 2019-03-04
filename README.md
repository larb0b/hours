# Hours

Simple script to log hours (service hours, work hours, etc.)

## Commands

* `a` - add an entry
* `Nd` - remove an entry (N being entry's line number)
* `Nc` - edit an entry
	* you can add an entry with your $EDITOR/xdg-open editor by using `Nc` on the next empty line
* `p` - list entries
* `n` - list entries with line numbers
* `e` - switch current file
* `o` - organize entries by month + day
* `t` - output total amount of hours
* `q` - exit

## Storage

By default, the script creates a file named "hrs" to store logged hours. You can use a different file by passing it as an argument, e.g. `./hours.sh ~/hoursfile`.
