while read key
do
    grep -hozP "(?s)@[^{}]+{$key,[^{}]*(({(?>[^{}]+|(?1))*})*[^{}])+}" $@
    printf "\n"
done
