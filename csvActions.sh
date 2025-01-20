#!/bin/bash
scriptDir=$(dirname "$(realpath "$0")")
csvFile="$scriptDir/fileQ.csv"
header="accountName, filename, postDate, postTime"  # Global header variable

checkInvFile(){
	inputFilename=$(echo "$1" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/^"\(.*\)"$/\1/')

	for file in "${invFilenames[@]}"; do 
		file=$(echo "$file" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/^"\(.*\)"$/\1/')
		if [[ "$file" == "$inputFilename" ]]; then
		    return 1  
		fi
	done

	return 0  
}

checkIfCsvExist(){
	if ! checkFile "$csvFile"; then
		echo "$header" > "$csvFile" 
	fi
}

readCsvAndDisplay(){
	checkIfCsvExist

	# Update to match global header!
	tail -n +2 "$csvFile" | while IFS=, read -r accountName videoID postDate postTime; do
		echo "Account Name: $accountName"
		echo "Filename: $videoID"
		echo "Post Date: $postDate"
		echo "Post Time: $postTime"
		echo "-------------------------"
	done
}

# Function to read the CSV file and load video IDs into an array
readCsvAndLoad(){
	checkIfCsvExist
	
	# Update to match global header!
	while IFS=, read -r accountName videoID postDate postTime; do
		invFilenames+=("$videoID")
	done < "$csvFile"
}

writeToCsv(){
	checkIfCsvExist
	
	# Update to match global header!
	for i in "${!filenames[@]}"; do
		echo "\"$chosenAccount\", \"${filenames[$i]}\", \"${dates[$i]}\", \"${times[$i]}\"" >> "$csvFile"
	done
}

deleteCsvEntry(){
    local targetFilename="$1"  
    local tempFile="$scriptDir/temp_fileQ.csv" 

    echo "Deleting entry with filename: $targetFilename"

    checkIfCsvExist
   
    awk -F, -v target="$targetFilename" 'NR == 1 || $2 !~ target' "$csvFile" > "$tempFile"

    mv "$tempFile" "$csvFile"
}

