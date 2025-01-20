#!/bin/bash
source ./csvActions.sh 
# Change depending on your cont dir 
CONT_DIR="$HOME/Desktop/content_for_system"

getContDirName(){
	dirs=($(ls $CONT_DIR))
	if [ -z "$1" ]; then
		for i in "${!dirs[@]}"; do
			echo "[$i] ${dirs[$i]}" >&2
		done

		read -p "Select a Directory (0-$(( ${#dirs[@]} - 1))): " chosen
		chosenCont="${dirs[$chosen]}"
	else
		chosenCont="$1"
	fi
}

getContDir(){
	# Change these switch statements to match your dir names
	case "$chosenCont" in
	"comedy_hub")
		contDir=$CONT_DIR/comedy_hub/prod_vids/twoVids_oneMain
		;;
	"cop.action.news")
		contDir=$CONT_DIR/cop.action.news/prod_vids/video_plus_sub
		;;
	"ITDrama")	
		contDir=$CONT_DIR/ITDrama/prod_vids/single_vid_plus_reddit
		;;
	"tellTale")
		contDir=$CONT_DIR/tellTale/prod_vids/single_vid_plus_reddit
		;;
	"test_twitch")
		contDir="$CONT_DIR/test_twitch/prod_vids/video_plus_sub"
		;;
	*)
		printf "$chosenAccount: non valid dir. \n"
		exit 1
		;;
	esac
}

checkFile(){
	if [ -e "$1" ]; then
		return 0
	else
		return 1
	fi
}

addToQ(){
	if [[ -n "$1" && -n "$2" && -n "$3" ]]; then
		if ! checkFile "$1"; then
			echo "File: $1, does not exist."
			exit 0
		elif ! checkInvFile "$1"; then
			echo "File is already Q'ed. "
			exit 0
		else
			invFilenames+=("$1")
			filenames+=("$1")
			dates+=("$2")
			times+=("$3")
		fi
	else
		echo "Selected Cont Dir: $chosenCont"
		echo "dir: $contDir"
		printf "\n$(ls --color=always -l | awk '{print $9, $6, $7, $8}')\n"

		while true; do
			boolGate=0
			read -e -p $'\nEnter the file name: ' filename
			if [ -z "$filename" ]; then
				break
			elif ! checkFile "$filename"; then
				echo "File does not exist. "
				boolGate=1
			elif ! checkInvFile "$filename"; then
				echo "File is already Q'ed. "
				boolGate=1
			fi

			if [ $boolGate -eq 0 ]; then
				read -e -p "Enter posting date ($(date +'%m/%d/%Y') -or- now): " date
				read -e -p "Enter posting time ($(date +'%H:%M:%S') -or- now): " time
				invFilenames+=("$filename")
				filenames+=("$filename")
				dates+=("$date")
				times+=("$time")
			fi
		done
	fi
}

listDirCont(){
	getContDirName "$1"
	getContDir 
	cd $contDir
	printf "\n$(ls --color=always -l | awk '{print $9, $6, $7, $8}')\n"
}

displayHelpText(){
    cat <<EOF

Usage:
./qSystem.sh <cont_dir> <fileName> <postDate> <postTime>
-or-
./qSystem.sh <cont_dir> Semi guided process.
-or-
./qSystem.sh		          Fully guided process.

Fields/ClI args:
<cont_dir>		            Dir name where file located.
<fileName>		            Name of file whithin dir.
<postDate>              Format: mm/dd/yyyy -or- "now"
<postTime>		            Format (24hr): hh:mm:ss -or- "now"

Flags:
-listQ			               List our Qed files.
-list <dir_name>	       Returns fileNames + Creation date/time.
-del <Filename>		       Delete an entry via fileName.
-h			                   List help text.

EOF
}

checkFlags(){
	case "$1" in
	"-listQ")
		readCsvAndDisplay
		exit 0
		;;
	"-list")
		listDirCont "$2"	
		exit 0
		;;
	"-del")
		deleteCsvEntry "$2"
		exit 0
		;;
	"-h")
		displayHelpText
		exit 0
		;;
	*)
		;;

	esac
}

main() {
	declare chosenCont
	declare contDir
	declare -a invFilenames
	declare -a filenames
	declare -a dates
	declare -a times

	checkFlags "$@"
	readCsvAndLoad
	getContDirName "$1"
	getContDir 
	cd $contDir
	addToQ "$2" "$3" "$4"
	writeToCsv
}
main "$@"






