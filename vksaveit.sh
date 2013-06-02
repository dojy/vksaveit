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
		author=`grep 'TPE1' ~/log`
		song=`echo "$song"  | sed 's/^\(.*\): //'`
		author=`echo "$author" | sed 's/^\(.*\): //'` 
		newfile=$dir$author" - "$song".mp3"
		echo "$newfile" 
		if [ -e "$newfile" ]; then
			echo " already here\n"
		else
			eval "cp  "$(pwd)"/"$file" \""$newfile"\""
		fi
	fi
done
rm ~/log
exit
