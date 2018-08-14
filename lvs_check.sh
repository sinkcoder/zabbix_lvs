#!/bin/bash
case $1 in
    in)
	ipvsadm -Ln --rate | grep -v RemoteAddress | grep - | awk '{print $6}' | awk '{sum+=$1} END {print sum}'
	;;
    out)
	ipvsadm -Ln --rate | grep -v RemoteAddress | grep - | awk '{print $7}' | awk '{sum+=$1} END {print sum}'
	;;
    active_conn)
	ipvsadm -Ln | grep - | grep -v RemoteAddress | awk '{print $5}' | awk '{sum+=$1} END {print sum}'
	;;
    total_real_count)
	grep -v ^# /etc/ha.d/ldirectord.cf | grep -v ^$ | awk "/^virtual=$2$/{flag=1;next}/virtual=.*/{flag=0}flag" | grep -c 'real='
	;;
    alive_real_count)
	ipvsadm -Ln| awk "/^FWM  $2 /{flag=1;next}/FWM/{flag=0}flag" | wc -l
	;;
    *)
	echo "usage: sh $0 [bps_in|bps_out|active_conn|real_count|alive_real_count] [virtual]"
	;;
esac
