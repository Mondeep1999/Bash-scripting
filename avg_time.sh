#!/bin/bash

cat /data/solr/8.4.1/server/logs/solr.log.1 |  sed -n 's/.*QTime=\([0-9]*\).*/\1/p' > time.txt
# fetching time after QTime= to time.txt
num=$(cat time.txt | wc -l) # storing lines counts

for (( c=1; c<=$num; c++ )) # loop will run till $num
do
  n=$(sed -n ${c}p < time.txt) # fetching the value on $c line
  if [[ $n -gt 1000 ]];  # if $n greater then it will take $n and put it in grep command
  then
       cat /data/solr/8.4.1/server/logs/solr.log.$d | grep -w QTime=$n >> slow_solr_logs.log
       #cat /home/root377/Scripts/solr.log.$d | grep -w QTime=$n >> slow_solr_logs.log
       echo $n
  fi
    sum=$( expr $sum + $n)
# done
# echo $sum
# avg=$( expr $sum / $num)
# echo $avg
# rm -f time.txt

#------------------------------------------------------------------------------------------------
rm -f time.txt

i=$(ls -dq /data/solr/8.4.1/server/logs/solr.log.* | wc -l)
j=$(ls -dq /data/solr/8.4.1/server/logs/solr.log.*.save.* | wc -l)
k=$(ls -dq /data/solr/8.4.1/server/logs/solr.log.*.save | wc -l)
j=$( expr $j + $k)
i=$( expr $i - $j)
# echo $i

for (( d=1; d<=$i; d++ )) # loop will run till $num
do
     echo "solr.log.$d"
     cat /data/solr/8.4.1/server/logs/solr.log.$d |  sed -n 's/.*QTime=\([0-9]*\).*/\1/p' >> time.txt
         
done

num=$(cat time.txt | wc -l) # storing lines counts
echo $num
   
     for (( c=1; c<=$num; c++ )) # loop will run till $num
     do
       sum=$(sed -n 1p < sum.txt)
       n=$(sed -n ${c}p < time.txt) # fetching the value on $c line
       sum=$( expr $sum + $n) > sum.txt
     
     done
     echo $n
     # sum=$( expr $sum + $n)
    #  echo $sum
     sum=$(sed -n 1p < time.txt)
     avg=$( expr $sum / $num)
     echo $avg
     
rm -f time.txt
