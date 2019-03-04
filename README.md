# Hours

Simple script to log hours (service hours, work hours, etc.)

## Commands

* `add, a` - add an entry
* `Nd` - remove an entry (N being entry's line number)
* `edit` - edit an entry
* `p` - list entries
* `n` - list entries with line numbers
* `organize, org` - organize entries by month + day
* `total, tot` - output total amount of hours
* `q` - exit

## Storage

By default, the script creates a file named "srvhrs" to store logged hours. You can use a different file by passing it as an argument, e.g. `./hours.sh ~/hoursfile`.

## Years

The script does not support years. Adding years *will* cause the script to not function properly. A solution to this is having separate logs for different years. These can be viewed together in order with `tail` if desired.
