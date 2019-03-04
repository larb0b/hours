# Hours

Simple script to log hours (service hours, work hours, etc.)

## Commands

* `add, a` - add an entry
* `rm` - remove an entry
* `edit` - edit an entry
* `ls` - list entries
* `organize, org` - organize entries by month + day
* `total, tot` - output total amount of hours
* `exit, quit, q` - exit

## Storage

By default, the script creates a file named "srvhrs" to store logged hours. You can use a different file by passing it as an argument, e.g. `./hours.sh ~/hoursfile`.

## Years

The script does not support years. Adding years *will* cause the script to not function properly. A solution to this is having separate logs for different years. These can be viewed together in order with `tail` if desired.

## Portability

This script is aimed to be very portable. The least portable function of the script is `edithrs` as some sed implementations will not understand line 42.
