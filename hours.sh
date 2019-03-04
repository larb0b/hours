#!/bin/sh
set -eu
addhrs() {
	printf "Date?\n"
	read date
	printf "Amount of hours?\n"
	read hours
	printf "Description?\n"
	read description
	echo "$date - $hours - $description" >> "${srvfile}"
}
rmhrs() {
	cat -n "${srvfile}"
	printf "Remove which line?\n:"
	read line
	sed "${line}d" "${srvfile}" > "${srvfile}".tmp
	printf "The new service hour log will be as follows:\n"
	cat -n "${srvfile}".tmp
	printf "Does this look okay? (y/n)\n"
	read resp
	if [ "$resp" = "y" ]; then
		mv "${srvfile}".tmp "${srvfile}"
	else
		rm "${srvfile}".tmp
	fi
}
edithrs() {
	cat -n "${srvfile}"
	printf "Edit which line?\n:"
	read line
	awk "NR == $line" "${srvfile}" > "${srvfile}".tmp
	if [ -z "${EDITOR:-}" ]; then
		if command -v xdg-open > /dev/null; then
			EDITOR=xdg-open
		else
			EDITOR=vi
		fi
	fi
	$EDITOR "${srvfile}".tmp
	sed -i "${line}c\\$(cat "${srvfile}".tmp)" "${srvfile}"
	rm "${srvfile}".tmp
	printf "Finished editing.\n"
}
lshrs() {
	printf "Current hours:\n"
	cat "${srvfile}"
}
total() {
	tot=$((0))
	while read lines
	do
		temptot=$(printf "$lines" | awk '{print $4}')
		tot=$(($tot + $temptot))
	done < "${srvfile}"
	echo "$tot"
}
orghrs() {
	sort -M "${srvfile}" -o "${srvfile}"
}
if [ "$#" -ne 0 ]; then
	srvfile="$1"
	[ ! -f "${srvfile}" ] && touch "${srvfile}"
else
	srvfile=srvhrs
	[ ! -f "${srvfile}" ] && touch "${srvfile}"
fi
lshrs
while true 
do
	printf ":"
	read command
	case "$command" in
		add|a)
			addhrs
			;;
		ls)
			lshrs
			;;
		rm)
			rmhrs
			;;
		edit)
			edithrs
			;;
		total|tot)
			total
			;;
		organize|org)
			orghrs
			;;
		exit|quit|q)
			exit 0
			;;
		*)
			printf "Invalid command\n"
			;;
	esac
done
