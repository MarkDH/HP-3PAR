#!/bin/sh

#################################################################
#   			  - Made By -                           # 
#      Sebastian E. T. Christiansen & Mark Dinsen-Hansen        #
#                        Copyright 2015                         #
#################################################################
# Description:                                                  #
#                                                               #
# This script is the main script!                               #
# This script does the reading on the HP 3PAR SAN and saves the #
# data to data.tsv. After som data handling it updates all the  #
# databases and then creates the PNG graphs. 			#
# Finally it runs the move.sh script to move the PNG's to the   #
# web directory.						#
#								#
# This script is run as a infinite loop. Stop it with CTRL-C    #
#################################################################


#################
# - Variables - #
#################
font="--font DEFAULT:0:Verdana --color FONT#ffffff"
graphstyle="--color GRID#d3d3d3 --color MGRID#ffffff --color ARROW#ffffff --color AXIS#ffffff  --color BACK#2a2a2a --color CANVAS#3f3f3f --border 0 --slope-mode --vertical-label IOPS" 
home="/home/rrd"


###################################
# - Make the script run forever - #
###################################
while true; do
 
 
##################################################
# - Make the reading and save data to data.tsv - #
##################################################
$home/doit.py -u http://10.50.18.83:5988 -a 'reader readme42' -v  |tr -d ' ' |tr '|' '\t' >> $home/data.tsv
 
 
#############################################################
# - Grep the last line in data.tsv and store it to 1linie - #
#############################################################
tac $home/data.tsv |egrep -m 1 . > $home/1linie
 
 
#######################################################
# - Print out every measurements in different files - #
#######################################################
num=3
for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech
do
awk '{print $'$num} $home/1linie > $i
num=`expr $num + 2`
done

 
#############################################
# - This script calculates the total IOPS - #
#############################################
$home/Total.sh
 
 
#################################################################################
# - Take the reading in every file, and update rrd databases with the reading - #
#################################################################################
for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech Total
do
read=`sed -n '1p' < $i`
rrdtool update $home/$i.rrd N:$read
done

########################################################
# - Create the PNG's with the graphs for the last 1H - #
########################################################
for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech
do
rrdtool graph $home/"$i"1.png -i -h 110 -w 700 $font $graphstyle --title "$i" --start -3600 --end now DEF:IOPS=$home/$i.rrd:iops:AVERAGE LINE:IOPS#ffa500:"$i"
done
rrdtool graph $home/Total1.png -i -h 110 -w 700 $font $graphstyle --title Total --start -3600 --end now DEF:IOPS=$home/Total.rrd:iops:AVERAGE LINE:IOPS#00ff00:Total

########################################################
# - Create the PNG's with the graphs for the last 24H- #
########################################################
for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech
do
rrdtool graph $home/"$i"24.png -i -h 110 -w 700 $font $graphstyle --title "$i" --start -86400 --end now DEF:IOPS=$home/$i.rrd:iops:AVERAGE LINE:IOPS#ffa500:"$i"
done
rrdtool graph $home/Total24.png -i -h 110 -w 700 $font $graphstyle --title Total --start -86400 --end now DEF:IOPS=$home/Total.rrd:iops:AVERAGE LINE:IOPS#00ff00:Total

#######################################
# - Create Graphs for the last week - #
#######################################
for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech Total
do
rrdtool graph $home/"$i"w.png -i -h 110 -w 700 $font $graphstyle --title "$i" --start -604800 --end now DEF:IOPS=$home/$i.rrd:iops:AVERAGE LINE:IOPS#ffa500:"$i"
done
rrdtool graph $home/Totalw.png -i -h 110 -w 700 $font $graphstyle --title Total --start -604800 --end now DEF:IOPS=$home/Total.rrd:iops:AVERAGE LINE:IOPS#00ff00:Total

####################################
# - Copy graphs to web directory - #
####################################
$home/move.sh
 
 
#######################
# - Finish off loop - #
#######################
sleep 10
done
