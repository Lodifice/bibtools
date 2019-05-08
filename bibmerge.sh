#!/bin/env sh
./bibkeys.sh $@ | sort -u | ./bibcat.sh $@
