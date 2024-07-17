#! /bin/bash

read -p "Enter the Directory Name you Want : " name

if [ -d $name ]
then
    echo "Directory Already Exists"
    exit 1
fi

item=($(ls))
ext=()

for i in ${item[@]}
do
    extension=${i##*.}
    if [[ $i != $extension ]]
    then

        if [[ ! ${ext[@]} =~ $extension ]]
        then
            ext+=($extension)
        fi
    fi
done

mkdir $name

for i in ${ext[@]}
do
    mkdir "$(pwd)/$name/$i"
done

for i in ${item[@]}
do
    extension=${i##*.}
    mv $i "$(pwd)/$name/$extension"
done

echo "Files Organised Successfully"
