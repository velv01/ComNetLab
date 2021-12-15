BEGIN{
initialenergy=1
maxenergy=150
n=150
nodeid=10
}
{
#Trace file format
energyevent = $1
time = $2
if(event=="r" || event == "d" || event =="s" || event=="f"){
node_id = $9
energy = $7
}
if (event =="N"){
node_id =$5
energy =$7
}
finalenergy[node_id]=energy
}
END{
for(i in finalenergy){
consumenergy[i]=initialenergy-finalenergy[i] 
totalenergy+=consumenergy[i]
if(maxenergy<consumenergy[i]){
maxenergy=consumenergy[i]
nodeid=i
}
}
averagenergy=totalenergy/n
for(i=0;i<n;i++){
print("=========Node-Energy===========")
print("Node: " , i, consumenergy[i])
print("===============================")
print("Average: ",averagenergy)
print("===============================")
print("Total Energy: ",totalenergy)
}
}
