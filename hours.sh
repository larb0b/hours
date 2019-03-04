#!/bin/sh
set -eu
addhrs() {
	printf "Date?\n"
	read date
	printf "Amount of hours?\n"
	read hours
	printf "Description?\n"
	read description
	echo "$date | $hours | $description" >> "${srvfile}"
}
rmhrs() {
	line="$(echo "${command%d}" | sed 's/[^0-9]*//g')"
	if [ -z "$line" ]; then
		echo "d syntax: Nd"
	else
		sed "${line}d" "${srvfile}" > "${srvfile}".tmp
		mv "${srvfile}".tmp "${srvfile}"
	fi
}
edithrs() {
	line="$(echo "${command%e}" | sed 's/[^0-9]*//g')"
	if [ -z "$line" ]; then
		echo "e syntax: Ne"
	else 
		awk "NR == $line" "${srvfile}" > "${srvfile}".tmp
		if [ -z "${EDITOR:-}" ]; then
			if command -v xdg-open > /dev/null; then
				EDITOR=xdg-open
			else
				EDITOR=vi
			fi
		fi
		$EDITOR "${srvfile}".tmp
		{
			sed "$line,\$d" "${srvfile}"
			cat "${srvfile}".tmp
			sed "1,${line}d" "${srvfile}"
		} > "${srvfile}".stmp
		mv "${srvfile}".stmp "${srvfile}"
		rm "${srvfile}".tmp
	fi
}
lshrs() {
	printf "Current hours:\n"
	if [ "${command:-}" = "n" ]; then
		cat -n "${srvfile}"
	else
		cat "${srvfile}"
	fi
}
total() {
	tot=$((0))
	while read lines
	do
		temptot=$(printf "$lines" | cut -d'|' -f2)
		tot=$(echo "$tot + $temptot" | bc)
	done < "${srvfile}"
	echo "$tot"
}
switchsf() {
	srvfile="$(echo "$command" | awk '{print $2}')"
	if [ ! -f "${srvfile}" ]; then
		touch "${srvfile}"
	fi
}
orghrs() {
	sort -M "${srvfile}" -o "${srvfile}"
}
if [ "$#" -ne 0 ]; then
	srvfile="$1"
	[ ! -f "${srvfile}" ] && touch "${srvfile}"
else
	srvfile=hrs
	[ ! -f "${srvfile}" ] && touch "${srvfile}"
fi
lshrs
while true 
do
	printf ":"
	read command
	case "$command" in
		a)
			addhrs
			;;
		p)
			lshrs
			;;
		n)
			lshrs
			;;
		s*)
			switchsf
			;;
		*d)
			rmhrs
			;;
		*e)
			edithrs
			;;
		t)
			total
			;;
		o)
			orghrs
			;;
		q)
			exit 0
			;;
		*)
			printf "Invalid command\n"
			;;
	esac
done
