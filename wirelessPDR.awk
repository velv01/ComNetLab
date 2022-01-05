BEGIN{
	sent=0;
	received=0;
	}
{
	if($1=="s" && $4=="MAC"){
		sent++;
	}
	else if($1=="r" && $4=="MAC"){
		received++;
	}
}

END{
	printf("====Wireless-Packet-Delivery-Ratio====\n");
	printf("Packets Sent:%d",sent);
	printf("\nPackets Received:%d",received);
	printf("\nPackets Delivery Ratio:%.2f\n",(sent/received)*100);
	printf("======================================\n");
}
