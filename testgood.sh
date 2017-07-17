#!/bin/bash

./cdu <$1 2>/dev/null && echo -n "+" || echo -n "F $1" ;
cat $1