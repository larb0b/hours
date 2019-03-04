# Hours

Simple script to log hours (service hours, work hours, etc.)

## Commands

* `add, a` - add an entry
* `Nd` - remove an entry (N being entry's line number)
* `edit` - edit an entry
* `p` - list entries
* `n` - list entries with line numbers
* `org, o` - organize entries by month + day
* `total, t` - output total amount of hours
* `q` - exit

## Storage

By default, the script creates a file named "hrs" to store logged hours. You can use a different file by passing it as an argument, e.g. `./hours.sh ~/hoursfile`.
