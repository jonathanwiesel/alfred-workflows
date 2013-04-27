. workflowHandler.sh
if [ "{query}" == "" ]
then
theReturn=`osascript << EOT
  try
    tell application "Finder" to set currentDir to (target of front Finder window) as text
        set curDirClean to (POSIX path of currentDir) as text
  on error
        set theMsg to "error"
    end try
EOT`

if [ $theReturn == "error" ]
then
  echo "No Finder window is open"
else
  dataDir=$(getDataDir)
  rm "$dataDir/settings"
  setPref "randomDir" "${theReturn}" 1
  shuffleFileName="randomOpener.dat"
  shuffleFile="$dataDir/$shuffleFileName"
  rm "${shuffleFile}"
    echo "$(find "${theReturn}" -type f \( ! -iname ".*" \) )" > "${shuffleFile}"
  echo "Directory configured: $theReturn"
fi
fi