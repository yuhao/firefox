awk '
BEGIN {
	depth = 0;
}
{
	if(depth != 0) time[stack[depth]] += $5 - last_ts;
	else
	{
		if(old_time[1] + old_time[2] + old_time[3] != 0)
		{
			native = time[3] - old_time[3];
			tot = (time[1] + time[2] + time[3]) - (old_time[1] + old_time[2] + old_time[3]);
			if(!tot) print native / tot, tot;
		}
		old_time[1] = time[1];
		old_time[2] = time[2];
		old_time[3] = time[3];
		global_start = $5;
	}

	if($3 == "starts")
	{
		depth++;
		if($1 == "Invoke") stack[depth] = 1;
		else if($1 == "Execute") stack[depth] = 2;
		else if($1 == "Native") stack[depth] = 3;
	}
	else
	{
		depth--;
		if(depth == 0)
		{
			global_end = $5;
			global += global_end - global_start;
		}
	}

	last_ts = $5;
	#print depth, stack[depth], $5, last_ts;
}
END {
	#print time[1], time[2], time[3], time[1] + time[2] + time[3];
	print time[3] / (time[1] + time[2] + time[3]), global;
}
'
