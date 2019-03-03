#!/bin/bash
function addhrs {
	echo "Date?"
	read date  
	echo "Amount of hours?"
	read hours
	echo "Description?"
	read description
	echo "$date - $hours - $description" >> ${srvfile}
}
function rmhrs {
	cat -n ${srvfile}
	echo "Remove which line?"
	printf ":"
	read line
	sed "${line}d" ${srvfile} > ${srvfile}.tmp
	echo "The new service hour log will be as follows:"
	cat -n ${srvfile}.tmp
	echo "Does this look okay? (y/n)"
	read resp
	if [ "$resp" == "y" ]; then
		mv ${srvfile}.tmp ${srvfile}
	else
		rm ${srvfile}.tmp
	fi
}
function edithrs {
	cat -n ${srvfile}
	echo "Edit which line?"
	printf ":"
	read line
	awk "NR == $line" ${srvfile} > ${srvfile}.tmp
	${EDITOR:=xdg-open} ${srvfile}.tmp
	sed -i "${line}c\\$(cat ${srvfile}.tmp)" ${srvfile}
	rm ${srvfile}.tmp
	echo "Finished editing."
}
function lshrs {
	echo "Current service hours"
	cat ${srvfile}
}
function total {
	tot=$((0))
	while read lines
	do
		temptot=$(echo $lines | awk '{print $4}')
		tot=$(($tot + $temptot))
	done < ${srvfile}
	echo "$tot"
}
if [ "$#" -ne 0 ]; then
	srvfile="$1"
	[ ! -f ${srvfile} ] && touch ${srvfile}
else
	srvfile=srvhrs
	[ ! -f ${srvfile} ] && touch ${srvfile}
fi
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
