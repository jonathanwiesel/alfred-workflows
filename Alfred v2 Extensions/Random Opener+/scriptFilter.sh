. workflowHandler.sh
dataDir=$(getDataDir)

# Storage random file
shuffleFileName="randomOpener.dat"

shuffleFile="$dataDir/$shuffleFileName"

if [[ -e "${shuffleFile}" ]]
then
cat << EOB

  <?xml version="1.0"?>

  <items>

	<item valid="YES" arg="open" autocomplete="open">
    <title>open</title>
    <subtitle>Open random file</subtitle>
    <icon>open.png</icon>
  </item>

	<item valid="YES" arg="current" autocomplete="current">
    <title>current</title>
    <subtitle>Open random file in the current Finder's window</subtitle>
		<icon>folder.png</icon>
  </item>

  <item valid="YES" arg="reset" autocomplete="reset">
    <title>reset</title>
    <subtitle>Reset the shuffle file</subtitle>
    <icon>reset.png</icon>
  </item>

  <item valid="NO" arg="count">
    <title>$( wc -l "$shuffleFile" | awk '{print $1'} )</title>
    <subtitle>Remaining files in shuffle file</subtitle>
    <icon>count.png</icon>
  </item>

	<item valid="YES" arg="deletelast" autocomplete="deletelast">
		<title>deletelast</title>
		<subtitle>Delete the last opened file by Random Opener</subtitle>
		<icon>delete.png</icon>
	</item>

  </items>

EOB
else

cat << EOB

  <?xml version="1.0"?>

  <items>

	<item valid="NO" arg="count">
      <title>Cannot count files.</title>
      <subtitle>Shuffle file has not been created. Run randomsetup to specify directory</subtitle>
      <icon>count.png</icon>
    </item>

  </items>

EOB
fi
