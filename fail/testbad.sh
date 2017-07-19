#!/bin/bash

./cdu < $1 >/dev/null 2>/dev/null && echo -n "F" || echo -n "+" &&  true
