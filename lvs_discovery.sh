#!/bin/bash
LINE=$(grep -v ^# /etc/ha.d/ldirectord.cf | grep -v ^$ | grep "virtual=" | awk -F= '{print $2}'|wc -l)
printf  '{\n'
printf  '\t"data":[\n'
grep -v ^# /etc/ha.d/ldirectord.cf | grep -v ^$ | grep "virtual=" | awk -F= '{print $2}'|while read virtual;do 
    printf "\t\t\t{\"{#VNAME}\":\"$virtual\"}";
    N=$(($N+1))
    if [ $N -eq $LINE ];then
        printf '\n'
    else
	printf ',\n'
    fi
done;
printf ']}\n'
