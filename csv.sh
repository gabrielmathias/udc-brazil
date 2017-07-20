#!/bin/bash

sed -e :a -e '$!N;s/\n<0/<0/;ta' -e 'P;D' 

#http://sed.sourceforge.net/sedfaq3.html

