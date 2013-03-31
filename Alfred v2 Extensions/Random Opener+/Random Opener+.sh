#!/bin/bash
# The directory you want to use.
DIR="$HOME/Documents/"

# Storage random file
shuffleFile="$HOME/temp/randomOpener.dat" 


if [ "{query}" == "reset" ]
then
  if [[ -d "${DIR}" ]]
  then
    rm "${shuffleFile}"
    echo "$(find "${DIR}" -type f \( ! -iname ".*" \) )" > "${shuffleFile}"
    echo "Shuffle file reset"
  else
    echo "Specified directory not present"
  fi
elif [ "{query}" == "count" ]
then
  echo "$( wc -l "$shuffleFile" | awk '{print $1'} )"" files remaining in shuffle file"
else
  if [[ -d "${DIR}" ]]
  then 
      # check if the shuffle file exist or is empty
      if [ ! -f "${shuffleFile}" ] || [[ ! -s "${shuffleFile}" ]] ; then
        echo "Generating shuffle file"
        echo "$(find "${DIR}" -type f \( ! -iname ".*" \) )" > "${shuffleFile}"
      fi

      num_files="$( wc -l "$shuffleFile" | awk '{print $1'} )"

      randomNumber="$((RANDOM%num_files+1))"

      aux="$(awk "NR==$randomNumber{print;exit}" $shuffleFile)"

      # delete line from file
      sed -i '' "$randomNumber d" $shuffleFile 

      open "${aux}"
  else
    echo "Specified directory not present"
  fi
fi
exit 0