#!/bin/bash
a=${1}
b=${2}

while [ $a != 0 -a $b != 0 ]
do
if [ $a -gt $b ]
then
 let a=$a%$b 
else
 let b=$b%$a
fi
done
let z=$a+$b
echo ${z}
