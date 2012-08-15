#!/bin/bash
# The directory you want to use.
DIR="/Users/your_user/Documents/"
aux="$DIR"

IFS='
'
if [[ -d "${DIR}" ]]
then 
	while [[ -d "${aux}" ]]; do
  		file_matrix=($(ls "${DIR}"))
  		num_files=${#file_matrix[*]}
  		aux="${DIR}/${file_matrix[$((RANDOM%num_files))]}"
  		if [[ -d "${aux}" ]]
  		then
			DIR="$aux"
  		else
  			open "${aux}"
  		fi
	done
else
	echo "No such directory"
fi

exit 0