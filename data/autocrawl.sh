cat list1k-2k.original |
#cat missing1k |
{
	while read website
	do
		echo $website
		timeout -s SIGKILL 180 /home/yuhao/Documents/mozilla-debug/firefox-download/dist/bin/firefox $website
	done
	exit
}
