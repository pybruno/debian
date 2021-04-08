#!/bin/bash
# check multiple web sites
# you must have file
# config_ssh.txt with web site url

res_output=()

function ssl_check () {
while read line;
do
    res=`/usr/lib/nagios/plugins/check_http -H $line --sni -C 30`
    if [ "$?" -ne 0 ]; then
        #res_output=("$res")
	#res_output=(${res_output[@]} $res)
        res_output[${#res_output[@]}]=$line=$res
    fi
done < config_ssl.txt
}

ssl_check

if (( ${#res_output[@]} )); then
#if [ ${#res_output[@]} -eq 0 ]; then
    echo ${res_output[@]}
    exit 2
else
    echo "ok - all web sites"
    exit 0
fi
