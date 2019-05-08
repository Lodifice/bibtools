#!/bin/env sh
grep -hoP '^@[^{}]+{\K([^,]+)(?=,)' $@
