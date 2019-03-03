#!/bin/bash
function addhrs {
	echo "Date?"
	read date  
	echo "Amount of hours?"
	read hours
	echo "Description?"
	read description
	echo "$date - $hours - $description" >> srvhrs
}
function rmhrs {
	cat -n srvhrs
	echo "Remove which line?"
	printf ":"
	read line
	sed "${line}d" srvhrs > srvhrs.tmp
	echo "The new service hour log will be as follows:"
	cat -n srvhrs.tmp
	echo "Does this look okay? (y/n)"
	read resp
	if [ "$resp" == "y" ]; then
		mv srvhrs.tmp srvhrs
	else
		rm srvhrs.tmp	
	fi
}
function edithrs {
	cat -n srvhrs
	echo "Edit which line?"
	printf ":"
	read line
	awk "NR == $line" srvhrs > srvhrs.tmp
	editor srvhrs.tmp
	sed -i "${line}c\\$(cat srvhrs.tmp)" srvhrs 
	rm srvhrs.tmp
	echo "Finished editing."
}
function lshrs {
	echo "Current service hours"
	cat srvhrs
}
function total {
	tot=$((0))
	while read lines
	do
		temptot=$(echo $lines | awk '{print $4}')
		tot=$(($tot + $temptot))
	done < srvhrs
	echo "$tot"
}
[ ! -f srvhrs ] && touch srvhrs
lshrs
while true 
do
	printf ":"
	read command
	case "$command" in
		add)
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
		total)
			total
			;;
		exit)
			exit 0
			;;
		*)
			echo "Invalid command"
			;;
	esac
done
