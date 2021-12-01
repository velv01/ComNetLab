BEGIN{
 src="0.0"
 dst="3.0"
 totalDelay = 0
 number_of_samples = 0
 }
 

/^\+/&&$9==src&&$10==dst{
t_arr[$12] = $2
}
/^r/&&$9==src&&$10==dst{
if (t_arr[$12]>0){
number_of_samples++
delay = $2 - t_arr[$12]
total_delay += delay
}
}
 
END{
 avg_delay = total_delay/number_of_samples
 print "=====================Ring-Topology-Delay======================"
 print "Total Delay is "total_delay" seconds"
 print "Average end to end transmission delay is " avg_delay " seconds"
}
