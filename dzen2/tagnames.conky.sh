#!/bin/bash
# it makes grep and friends REALLY faster
LANG=C
printall() {
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
			printf "^fg(#4d96a8)${TAGS[$j]} "
		else
			printf "^fg()${TAGS[$j]} "
		fi
		j=$(($j+1))
	done
	printf "^fg(#a1913f)"
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
