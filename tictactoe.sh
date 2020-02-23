#!/bin/bash
moves=("." "." "." "." "." "." "." "." ".")
#moves=("0" "1" "2" "3" "4" "5" "6" "7" "8")

function display2() {

  	col=$( tput cols )
    row=$( tput lines )
    

  	tput clear
    tput bold

    tput cup $((($row/2) -1 )) $((($col/2) - 4))
    echo "${moves[0]} | ${moves[1]} | ${moves[2]}"
    tput cup $((($row/2) ))  $((($col/2) - 4))
	echo "${moves[3]} | ${moves[4]} | ${moves[5]}"
	tput cup $((($row/2) + 1 ))  $((($col/2) - 4))
	echo "${moves[6]} | ${moves[7]} | ${moves[8]}"
}

function gameWon(){
	if [ "${moves[0]}" != "." ] && [ "${moves[0]}" == "${moves[1]}" ] && [ "${moves[1]}" == "${moves[2]}" ]; then
		gameWon=1
		winMove=${moves[0]}
	fi

	if [ "${moves[3]}" != "." ] && [ "${moves[3]}" == "${moves[4]}" ] && [ "${moves[4]}" == "${moves[5]}" ]; then
		gameWon=1
		winMove=${moves[3]}
	fi
	
    if [ "${moves[6]}" != "." ] && [ "${moves[6]}" == "${moves[7]}" ] && [ "${moves[7]}" == "${moves[8]}" ]; then
		gameWon=1
		winMove=${moves[6]}
	fi

	if [ "${moves[0]}" != "." ] && [ "${moves[0]}" == "${moves[3]}" ] && [ "${moves[3]}" == "${moves[6]}" ]; then
		gameWon=1
		winMove=${moves[0]}
	fi

	if [ "${moves[1]}" != "." ] && [ "${moves[1]}" == "${moves[4]}" ] && [ "${moves[4]}" == "${moves[7]}" ]; then
		gameWon=1
		winMove=${moves[1]}
	fi
	
    if [ "${moves[2]}" != "." ] && [ "${moves[2]}" == "${moves[5]}" ] && [ "${moves[5]}" == "${moves[8]}" ]; then
		gameWon=1
		winMove=${moves[2]}
	fi

	if [ "${moves[0]}" != "." ] && [ "${moves[0]}" == "${moves[4]}" ] && [ "${moves[4]}" == "${moves[8]}" ]; then
		gameWon=1
		winMove=${moves[0]}
	fi

	if [ "${moves[2]}" != "." ] && [ "${moves[2]}" == "${moves[4]}" ] && [ "${moves[4]}" == "${moves[6]}" ]; then
		gameWon=1
		winMove=${moves[2]}
	fi

	if [ $gameWon == 1 ]; then 
		if [[ $winMove == "X" ]]; then 
			winPLayer=2
		else
			winPLayer=1
		fi
	fi  
}

echo Game will start in a couple of seconds
echo "Computer -> O"
echo "User -> X"
sleep 2
game=1
gameWon=0
winMove=" "
winPLayer=0 #1 computer, 2 user.
while [ $game -eq 1 ]; do

	display2
	echo "Enter your move (space separated integers x y (between 0 and 2)):"
	read x y
	if ! [[ "$x" =~ ^[0-9]+$ ]] || ! [[ "$y" =~ ^[0-9]+$ ]]; then
        echo Invalid input
        sleep 1
        continue
	fi

	move=$(((3*x)+y))
	
	if [ $move -lt 0 ] || [ $move -gt 8 ]; then
		echo Invalid move
		sleep 1
		continue
	else
		if [[ ${moves[$move]} == "." ]]; then
			moves[$move]='X'
		else
			echo This place is taken
			sleep 1
			continue
		fi
	fi


	available=()
  	for (( i = 0; i < ${#moves[@]}; i++ )); do
	    if [[ ${moves[$i]} == "." ]]; then
	      	available+=($i)
	    fi
  	done

  	while [ 1 -eq 1 ]; do
  		randx=$((0 + RANDOM % 3))
	  	randy=$((0 + RANDOM % 3))  
	  	compMove=$(((3*randx)+randy))
  		if [[ ${moves[$compMove]} == "." ]]; then
  			moves[$compMove]='O'
  			break
  		else
  			continue
  		fi
  	done
  	gameWon
  	if [ $gameWon == 1 ]; then
  		display2
  		if [ $winPLayer == 2 ]; then
  			echo you win!
  		else
  			echo you lose. sedlyf 
  		fi
  		sleep 1
  		break
  	fi

  	if [ "${#available[@]}" == 0 ] && [ $gameWon == 0 ]; then
  		display2
  		echo Game Draw
  		sleep 5
  		break
  	fi
done


	
