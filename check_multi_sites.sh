#!/bin/bash
# check multiple web sites
# you must have file config.txt with web site line by line
# return list of all website error or ok


res_output=()

function ssl_check () {
while read line;
do
    
    # res=`/usr/lib/nagios/plugins/check_http -H $line --sni`
    if [ $line != "#*"]; then 
        res=`/usr/lib/nagios/plugins/check_http -H $line -f follow -t 5`
    fi
    # echo "$line"
    if [ "$?" -ne 0 ]; then
        #res_output=("$res")
	    #res_output=(${res_output[@]} $res)
        res_output[${#res_output[@]}]=$line=$res
    fi
done < ./config.txt
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

