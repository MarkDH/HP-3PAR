#!/bin/sh

#################################################################
#                         - Made By -                           #
#      Sebastian E. T. Christiansen & Mark Dinsen-Hansen        #
#                        Copyright 2015                         #
#################################################################
# Description:                                                  #
#                                                               #
# This script creates RRD Databases for:                        #
# infrastructure-odn1                                           #
# cust-odn1-voip                                                #
# vm-odn1-system-logs                                           #
# cust-odn1-portal                                              #
# cust-odn1-pltest                                              #
# cust-odn1-servicewell                                         #
# cust-odn1-vetech                                              #
# Total                                                         #
#################################################################

for i in infrastructure-odn1 cust-odn1-voip vm-odn1-system-logs cust-odn1-portal cust-odn1-pltest cust-odn1-servicewell cust-odn1-vetech Total
do
rrdtool create $i.rrd \
--step=10 \
--start=`date +%s` \
DS:iops:COUNTER:20:0:100000 \
RRA:AVERAGE:0.4:1:8640 \
RRA:AVERAGE:0.4:7:8640 \
RRA:MIN:0.4:3:2 \
RRA:MAX:0.4:3:2
done
