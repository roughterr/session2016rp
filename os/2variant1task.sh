#!/bin/bash
#Shell-програма переглядає каталог, ім'я якого вказане параметром Shell-програми і виводить імена каталогів, що зустрілися.
#Потім здійснює перехід в батьківський каталог, який стає поточним, і повторюються вказані дії доти, доки поточним каталогом не стане кореневий каталог.

FULLPATH=$1
cd $FULLPATH

while true 
do
	#виводить на екран ім’я поточного каталогу (без повного шляху)
	echo `basename "$FULLPATH"`
	#виводить на екран імена підкаталогів
	for element in ${FULLPATH}/*; do
		if [ -d ${element} ]; then
			echo "	`basename ${element}`"
		fi
	done
	if [ "${FULLPATH}" = "/" ]; then
		break
	else
		cd ..
		FULLPATH=`pwd`
	fi
done
