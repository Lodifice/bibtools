while read key
do
    matches=$(grep -chozP "(?s)@[^{}]+{$key,[^{}]*(({(?>[^{}]+|(?1))*})*[^{}]*)+}" $@ | awk '{s+=$1} END {print s}')
    if [ "$matches" = "0" ]
    then
        (>&2 echo "error: $key not found")
    elif [ "$matches" = "1" ]
    then
        grep -hozP "(?s)@[^{}]+{$key,[^{}]*(({(?>[^{}]+|(?1))*})*[^{}])+}" $@ | tr '\0' '\n'
    else
        (>&2 echo "error: $key multiple occurences, ignored")
    fi
done
