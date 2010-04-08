#!/bin/bash
# it makes grep and friends REALLY faster
LANG=C
# theme 1
#SELTAGCOLOR="#4d96a8"
#NORMTAGCOLOR="#606060"
#LAYOUTCOLOR="#a1913f"
# theme 2
#SELTAGCOLOR="#c0d784"
#NORMTAGCOLOR="#ddd"
#LAYOUTCOLOR="#c0d784"
# theme 3
SELTAGCOLOR="#92b19e"
NORMTAGCOLOR="#bfbfbf"
LAYOUTCOLOR="#92b19e"
printall() {
        echo -n "^p(;-2)"
	TAGS=$(xprop -root _NET_DESKTOP_NAMES|sed 's/_NET_DESKTOP_NAMES(UTF8_STRING) = //;s/0x0/ /g;s/0x/\\x/g;s/, //g;')
	TAGS=(`printf "$TAGS\n"`)
	#echo $TAGS
	SELTAGS="$(xprop -root _ECHINUS_SELTAGS|sed 's/_ECHINUS_SELTAGS(CARDINAL) = //;s/,//g')"
	#printf "$SELTAGS\n"
	LAYOUT=$(xprop -root _ECHINUS_LAYOUT|awk -F '"' '{ print $2 }')
	#printf "$LAYOUT\n"
	j=0
	printf " "
	for i in $SELTAGS
	do
		if [ "$i" == "1" ]; then
			printf "^fg($SELTAGCOLOR)${TAGS[$j]} "
		else
			printf "^fg($NORMTAGCOLOR)${TAGS[$j]} "
		fi
		j=$(($j+1))
	done
	printf "^p(;+1)^fg($LAYOUTCOLOR)"
	case $LAYOUT in
		t)
			printf "^i(tile.xbm)"
			;;
		b)
			printf "^i(bstack.xbm)"
			;;
		m)
			printf "^i(mono.xbm)"
			;;
		i)
			printf "^i(float.xbm)"
			;;
	esac
	echo
}
while :
do
	printall
	./pnotify
	printall
done
