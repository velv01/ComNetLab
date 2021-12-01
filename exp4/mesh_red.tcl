# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(stop)   10.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open mesh_red.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open mesh_red.nam w]
$ns namtrace-all $namfile

#===================================
#        Nodes Definition        
#===================================
#Create 5 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n1 100.0Mb 10ms RED
$ns queue-limit $n0 $n1 50
$ns duplex-link $n1 $n2 100.0Mb 10ms RED
$ns queue-limit $n1 $n2 50
$ns duplex-link $n2 $n3 100.0Mb 10ms RED
$ns queue-limit $n2 $n3 50
$ns duplex-link $n3 $n4 100.0Mb 10ms RED
$ns queue-limit $n3 $n4 50
$ns duplex-link $n4 $n0 100.0Mb 10ms RED
$ns queue-limit $n4 $n0 50
$ns duplex-link $n1 $n4 100.0Mb 10ms RED
$ns queue-limit $n1 $n4 50
$ns duplex-link $n1 $n3 100.0Mb 10ms RED
$ns queue-limit $n1 $n3 50
$ns duplex-link $n1 $n2 100.0Mb 10ms RED
$ns queue-limit $n1 $n2 50
$ns duplex-link $n2 $n0 100.0Mb 10ms RED
$ns queue-limit $n2 $n0 50
$ns duplex-link $n2 $n4 100.0Mb 10ms RED
$ns queue-limit $n2 $n4 50
$ns duplex-link $n0 $n3 100.0Mb 10ms RED
$ns queue-limit $n0 $n3 50

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient left-down
$ns duplex-link-op $n3 $n4 orient left-down
$ns duplex-link-op $n4 $n0 orient left-up
$ns duplex-link-op $n1 $n4 orient left-down
$ns duplex-link-op $n1 $n3 orient right-down
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n0 orient left-up
$ns duplex-link-op $n2 $n4 orient left-down
$ns duplex-link-op $n0 $n3 orient right-down

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp0 $sink2
$tcp0 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 0.0 "$ftp0 start"
$ns at 2.0 "$ftp0 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam mesh_red.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
