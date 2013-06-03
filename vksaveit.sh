#/bin/sh
# saves music from vk.com that you listen to
# needs id3v2 and firefox
dir=$(pwd)"/"
cachedir=~/.mozilla/firefox/*/Cache/
touch ~/log
cd $cachedir
for file in */*/*
do
	id3v2 -l $file > ~/log
	song=`grep 'TIT2' ~/log`
	if [ -n "$song" ]; then
		artist=`grep 'TPE1' ~/log`
		song=`echo "$song"  | sed 's/^\(.*\): //'`
		artist=`echo "$artist" | sed 's/^\(.*\): //'` 
		newfile=$dir$artist" - "$song".mp3"
		echo "$newfile" 
		if [ -e "$newfile" ]; then
			echo "^ already here"
		else
			eval "cp  "$(pwd)"/"$file" \""$newfile"\""
		fi
	fi
done
rm ~/log
exit
