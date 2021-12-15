BEGIN{ 
	recvdSize = 0;
	txsize = 0;
	drpSize = 0;
	startTime = 400;
	stopTime = 0;
	thru = 0; 
} 

{

#Assign the columns 
event = $1;
time = $2;
node_id = $3; 
pkt_size = $8; 

 
# Store start time 
if ($4 == "RTR" && event == "s"){ 
	if (time < startTime){ 
		startTime = time 
		} 
	pkt_size = pkt_size % 400 
	txsize++ # Store transmitted packet’s size
	} 
# Update total received packets’ size and store packets arrival time 
if ($4 == "RTR" && event == "r"){
 	if (time > stopTime){ 
		stopTime = time 
	} 
	# Rip off the header  
	hdr_size = pkt_size % 400 
	# Store received packet’s size 
	recvdSize++ 
	thru=(recvdSize/txsize) 
	printf(" %.2f %.2f \n" ,time,thru) > "abc2.tr" 
	} 
if ($4 == "AGT" && event == "d" ){ 
	pkt_size = pkt_size % 400 
 	drpSize++ 
	} 
}
 
END{ 
  printf("=============Throughput===============\n");
  printf("Average Throughput[kbps] = %.2f kbps \n",(recvdSize/(stopTime- startTime))) ;
  printf("========================================\n");
} 
