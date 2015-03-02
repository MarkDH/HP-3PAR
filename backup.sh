#!/bin/sh

#################################################################
#                         - Made By -                           #
#      Sebastian E. T. Christiansen & Mark Dinsen-Hansen        #
#                        Copyright 2015                         #
#################################################################
# Description:                                                  #
#                                                               #
# This script moves data.tsv to the folder old-data		#
# The script is supposed to be run 23:59 by crontab             #
#################################################################


mv /home/rrd/data.tsv /home/rrd/old-data/`date +"%Y%m%d"`.tsv
