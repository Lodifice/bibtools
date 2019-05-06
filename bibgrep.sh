#!/bin/env sh
grep -hoP '^\\citation{\K([^}]+)(?=}$)' $@ | sed 's/,/\n/g' | sort -u
