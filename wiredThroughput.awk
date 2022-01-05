BEGIN{
      lineCount=0;
      totalBits=0;
      fromNode="0";
      toNode="3";
   	}
{
	if( ($1=="r") && ($3 == fromNode) && ($4 == toNode) ){
		totalBits += 8*$6;
		if(lineCount == 0){
			timeBegin = $2;
			lineCount++;
		}
		else{
			timeEnd = $2;
		}
	}
}


END{
	duration = timeEnd - timeBegin;
	print "==================Wired-Throughput===========================";
	print " Transmission is from node "fromNode" to node "toNode"";
	print " Total number of transmitted bits is "totalBits" bits";
	print " Total duration is "duration" seconds";
	print " Throughput = "totalBits/duration/1e3" kbps";
	print "=============================================================";
}
