#!/bin/sh

#################################################################
#                         - Made By -                           #
#      Sebastian E. T. Christiansen & Mark Dinsen-Hansen        #
#                        Copyright 2015                         #
#################################################################
# Description:                                                  #
#                                                               #
# This script moves the created PNG graphs to the webdirectory  #
#################################################################


home="/home/rrd"
WBEMPATH="/var/www/html/rrd"

for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech
do
mv $home/${i}24.png $WBEMPATH/rrdgraphs/${i}24.png
mv $home/${i}w.png $WBEMPATH/rrdgraphs/${i}w.png
mv $home/${i}1.png $WBEMPATH/rrdgraphs/${i}1.png
done

mv $home/Total24.png $WBEMPATH/rrdgraphs/Total24.png
mv $home/Totalw.png $WBEMPATH/rrdgraphs/Totalw.png
mv $home/Total1.png $WBEMPATH/rrdgraphs/Total1.png

