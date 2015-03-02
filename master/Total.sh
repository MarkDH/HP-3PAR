#!/bin/sh

#################################################################
#                         - Made By -                           #
#      Sebastian E. T. Christiansen & Mark Dinsen-Hansen        #
#                        Copyright 2015                         #
#################################################################
# Description:                                                  #
#                                                               #
# This script calculates the sum of all readings and writes the #
# sum to the file Total so we can make the Total graph          #
#################################################################


home="/home/rrd"

inf=`sed -n '1p' < $home/infrastructure-odn1`
custvoip=`sed -n '1p' < $home/cust-odn1-voip`
system=`sed -n '1p' < $home/vm-odn1-system-logs`
portal=`sed -n '1p' < $home/cust-odn1-portal`
pltest=`sed -n '1p' < $home/cust-odn1-pltest`
service=`sed -n '1p' < $home/cust-odn1-servicewell`
vetech=`sed -n '1p' < $home/cust-odn1-vetech`


total=`expr $inf + $custvoip + $system + $portal + $pltest + $service + $vetech`

echo $total > $home/Total
