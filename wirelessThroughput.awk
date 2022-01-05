BEGIN{ 
	recvdSize = 0;
	startTime = 40000;
	stopTime = 0;
	thru = 0; 
} 

{
 #Assign the columns 
	event = $1;
	time = $2;

# Store start time 
	if($4 == "RTR" && event == "s"){ 
		if(time < startTime){ 
			startTime = time 
		} 
	} 
# Update total received packets’ size and store packets arrival time(i.e the received time)
	if($4 == "RTR" && event == "r"){
		if(time > stopTime){ 
			stopTime = time ;
		} 
	# Store received packet’s size 
		recvdSize++ ;
	} 
}
END{ 
    printf("=========Wireless-Throughput=========\n");
    printf("Average Throughput[kbps] = %.2f kbps \n",(recvdSize/(stopTime- startTime)));
    printf("=====================================\n");
} 