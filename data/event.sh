awk -v event=$2 '
	BEGIN {
		start = 0;
	}
	{
		if($3 == "ends" && $4 == event) start = 0;
		if(start) print $0;
		if($3 == "starts" && $4 == event) start = 1;
	}
'
