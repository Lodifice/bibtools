while read key
do
    grep -chozP "(?s)@[^{}]+{$key,[^{}]*(({(?>[^{}]+|(?1))*})*[^{}]*)+}" $@ | awk '{s+=$1} END {print s}'
done
