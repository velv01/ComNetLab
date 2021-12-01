BEGIN{
      lineCount=0;
      totalBits=0;}
#==========Body=============
{
 if($1=="r" && $3=="0" && $4=="4"){
 totalBits += 8*$6;
 if(lineCount==0){
 timeBegin = $2;
 lineCount++;
 }
 else{
 timeEnd = $2;
 }
}
}
#==========Body ends===========
END{
duration = timeEnd - timeBegin;
print "=======================OUTPUT===========================";
print " Transmission is from node 0 to node 4";
print " Total number of transmitted bits is "totalBits" bits";
print " Total duration is "duration" seconds";
print " Throughput = "totalBits/duration/1e3" kbps";
}
     
   

