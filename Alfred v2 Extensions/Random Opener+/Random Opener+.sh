#!/bin/bash
. workflowHandler.sh

DIR=$(getPref "randomDir" 1)
if [ "${DIR}" ]
then
  dataDir=$(getDataDir)
  shuffleFileName="randomOpener.dat"
  lastFileName="lastFile.dat"
  shuffleFile="$dataDir/$shuffleFileName"
  lastFile="$dataDir/$lastFileName"

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

  elif [ "{query}" == "current" ]
  then
osascript << EOF
tell application "Finder"
  set theArray to {}
  if window 1 exists then
    set theItems to every file of window 1
    repeat with i from 1 to count of theItems
      set filepath to item i of theItems as text
      set end of theArray to POSIX path of filepath
    end repeat
    if (count of theArray) is greater than 0 then
      set theRandom to random number from 1 to count of theArray
      set singleFile to item theRandom in theArray
      do shell script "open " & quoted form of singleFile
      return
    else
      set x to "Folder is empty or it contains only folders"
    end if
  else
    set x to "No Finder window is open"
  end if
end tell
EOF
  elif [ "{query}" == "deletelast" ]
  then
    if [ ! -f "${lastFile}" ] || [[ ! -s "${lastFile}" ]] ; then
      echo "No record for last file"
    else
      aux="$(awk "NR==1{print;exit}" "$lastFile")"
      rm "${aux}"
      sed -i '' "1 d" "$lastFile"
      echo "File ${aux} deleted"
    fi
  else
    if [[ -d "${DIR}" ]]
    then
        # check if the shuffle file exist or is empty
        if [ ! -f "${shuffleFile}" ] || [[ ! -s "${shuffleFile}" ]] ; then
          echo "New shuffle file generated"
          echo "$(find "${DIR}" -type f \( ! -iname ".*" \) )" > "${shuffleFile}"
        fi

        num_files="$( wc -l "$shuffleFile" | awk '{print $1'} )"

        randomNumber="$((RANDOM%num_files+1))"
        aux="$(awk "NR==$randomNumber{print;exit}" "$shuffleFile")"
        # delete line from file
        sed -i '' "$randomNumber d" "$shuffleFile"

        # add last opened to lastfile
        echo "${aux}" > "${lastFile}"

        open "${aux}"
    else
      echo "Specified directory not present"
    fi
  fi
else
  echo "No directory configured. Please run randomsetup"
fi
exit 0
