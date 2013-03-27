#!/bin/bash
# The directory you want to use.
DIR="/Volumes/LaCie/system/system/"

# Storage random file
shuffleFile="/tmp/randomOpener.dat" 


if [[ -d "${DIR}" ]]
then 
    # check if the shuffle file exist or is empty
    if [ ! -f "${shuffleFile}" ] || [[ ! -s "${shuffleFile}" ]] ; then
      echo "$(find "${DIR}" -type f \( ! -iname ".*" \) )" > "${shuffleFile}"
      echo "Generating shuffle file"
    fi

    num_files="$( wc -l "$shuffleFile" | awk '{print $1'} )"

    randomNumber="$((RANDOM%num_files+1))"

    aux="$(awk "NR==$randomNumber{print;exit}" $shuffleFile)"

    # delete line from file
    sed -i '' "$randomNumber d" $shuffleFile 

    open "${aux}"
else
  echo "No such directory"
fi

exit 0