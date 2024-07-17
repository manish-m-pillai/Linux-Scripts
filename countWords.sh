#! /bin/bash

tr -d '[:punct:]' < $1 | tr '[:upper:]' '[:lower:]' > proc.txt

words=()
freq=()

while IFS= read -r line
do
    for word in $line
    do
        if [[ ! ${words[@]} =~ $word ]]
        then
            words+=($word)
            freq+=(1)

        else
            for j in ${!words[@]}
            do
                if [[ ${words[j]} == $word ]]
                then
                    (( freq[j]++ ))
                fi
            done
        fi
    done
done < proc.txt

echo "Frequency of Each Word"
for j in ${!words[@]}
do
    echo " ${words[j]} : ${freq[j]}"
done