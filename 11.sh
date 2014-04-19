#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
fi
filename="$1"
if [ ! -f $filename ]; then
	echo "Error: Invalid File!"
	exit 1;
fi
cat <(echo -n "") > CopyGroups
awk 'BEGIN {grpcount=0;}{flag1=0;flag2=0;for(i=0;i<grpcount;i++){for(j=0;j<element[i];j++){if(group[i,j]==$1){flag1=1;}if(group[i,j]==$2){flag2=1;}}if(flag1==1 && flag2!=1){group[i,element[i]]=$2;element[i]++;break;}if(flag2==1 && flag1!=1){group[i,element[i]]=$1;element[i]++;break;}}if(flag1==0 && flag2==0){group[grpcount,0]=$1;group[grpcount,1]=$2;element[grpcount]=2;grpcount++;}}END{for(i=0;i<grpcount;i++){for(m=0;m<element[i];m++){for(j=i+1;j<grpcount;j++){for(k=0;k<element[j];k++){if(group[i,m]==group[j,k] && group[i,m]!=-1){for(p=0;p<element[j];p++){flag=0;for(q=0;q<element[i];q++){if(group[i,q]==group[j,p] && group[i,q]!=-1){flag=1;mainflag=1;}}if(flag==0){group[i,element[i]]=group[j,p];element[i]++;}}}if(mainflag==1){break;}}if(mainflag==1){for(k=0;k<element[j];k++){group[j,k]=999999999;}}mainflag=0;}}}for (i=0;i<grpcount;i++){for(k=0;k<element[i]-1;k++){for(j=0;j<element[i]-k-1;j++){if (group[i,j]>group[i,j+1]){swap=group[i,j];group[i,j]=group[i,j+1];group[i,j+1]=swap;}}}}for (i=0;i<grpcount;i++){min=999999999;flag=0;for(j=0;j<grpcount;j++){if (min>group[j,0]){minindex=j;min=group[j,0];}}for(j=0;j<element[minindex];j++){if(group[minindex,j]==999999999){flag=1;break;}printf("%d ",group[minindex,j]);group[minindex,j]=999999999;}if(flag==0){printf("\n");}}}' "$filename" >> CopyGroups
exit 0
