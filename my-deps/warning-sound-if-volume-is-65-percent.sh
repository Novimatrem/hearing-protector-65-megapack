#!/bin/bash
while true
do 

x=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
if [[ $x -le 64 ]]
then
    echo LEVEL_IS_FINE__SKIP
fi

echo "sleep 0.24s to reduce cpu usage"
sleep 0.24s

if [[ $x -ge 65 ]]
then
    echo 65_DETECTED__WARNING
    notify-send "You probably should lower your volume."
     cd "$(dirname "$0")"
    paplay $(pwd)/warning-beep.wav
    
   
while true
do
    if [[ $x -eq 65 ]]
        then
        amixer -D pulse sset Master 64%
        break
    fi
    if [[ $x -ge 66 ]]
        then
    x=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' ) && echo "NOT_TURNED_DOWN_YET" && sleep 1s && if [[ $x -le 65 ]] ; then break; else echo YEP_NOT_TURNED_DOWN_YET_WHOOPS; fi
    
        fi
done
        
    echo b2
    sleep 5s
fi

done

# Warning sound if volume is 65%, to help warn against hearing damage

# initial code snippet (broken) provided by unix stackexchange user Akash Kumar Singh, thanks
# first release and code fixup and improvement by Novimatrem as 'limit-pulseaudio-max-volume-to-65-percent', forked and modified for this.

#amixer -D pulse sset Master 64%
