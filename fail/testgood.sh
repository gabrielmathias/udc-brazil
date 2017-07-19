#!/bin/bash

./cdu <$1 1> $1.done 2>/dev/null && echo -n "+" || echo -n "F $1" ;
