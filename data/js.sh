# native percentage
cat list1k.original |
{
	while read website
	do
		echo $website
		#../firefox-release/dist/bin/firefox $website > temp
		#cat temp | grep -v Dispatch | awk 'BEGIN{FS=" = "}{if(NR%3==2) a=$2; else if(NR%3==0) print $2, a/$2}' | sort +1 -2 -n > native/$website

		#echo "tot,rate" > temp
		#cat native/$website | sed -e "s/\s/,/g" >> temp
		#mv temp native/$website

		echo "tot,rate" > native/$website
		timeout -s SIGKILL 180 ../firefox-release/dist/bin/firefox $website | grep -v Dispatch | sh process.sh | sort +0 -1 -n | sed -e "s/\s/,/g" >> native/$website
	done
}
exit

# get external js src
cat list1k |
{
	while read website
	do
		echo $website
		python jssrc.py ~/Downloads/1k/$website
		echo
	done
}
exit

# calculate js fraction
cat list1k.original |
#cat html5.list |
{
	while read website
	do
		echo -n $website" "
		#if [ ! -f js_time/html5/$website ]
		if [ ! -f js_time/$website ]
		then
			echo "NA"
			continue
		fi

		#cat js_time/html5/$website |
		cat js_time/$website |
		awk '
			BEGIN {
				FS = "=";
			}
			{
				if(NR == 1) tot = $2;
				if(NR == 2) js1 = $2;
				if(NR == 3) js2 = $2;
			}
			END {
				if(js2 == 0) print 0;
				else print (js1 + js2) / tot;
			}
		'
	done
}
exit

# measure js time
cat list1k.original |
{
	while read website
	do
		echo $website
		# measure gross js time
		#timeout -s SIGKILL 180 /home/yuhao/Documents/mozilla-debug/firefox-release/dist/bin/firefox $website > temp
		#cat temp | grep total > js_time/html5/$website
		#cat temp | grep Invoke | tail -1 >> js_time/html5/$website
		#cat temp | grep Execute | tail -1 >>  js_time/html5/$website

		# measure js time dist of each script..
		timeout -s SIGKILL 120 /home/yuhao/Documents/mozilla-debug/firefox-release/dist/bin/firefox $website > js_dist/$website
	done
}
exit

# calculate the weight of jquery
cat list1k.original |
{
	while read website
	do
		echo -n $website" "
		if [ ! -f js_dist/$website ]
		then
			echo 0 0 0
			continue
		fi

		for kernel in Invoke Execute
		do
			cat js_dist/$website | grep $kernel |
			{
				awk '
					BEGIN {
						FS = " time = ";
						js = 0;
						last = 0;
					}
					{
						cur = $2 - last;
						last = $2;
						if(match($0, "jquery") != 0) js += cur;
					}
					END {
						printf("%s ", js);
					}
				'
			}
		done

		tot=`cat js_dist/$website | grep "total time"`
		if [ -z "$tot" ]
		then
			echo 0
		else
			echo $tot | awk 'BEGIN{FS = " time = "}{print $2}'
		fi
	done
}
exit

