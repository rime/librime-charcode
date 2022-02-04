#!/bin/bash

if [[ "$OSTYPE" =~ 'darwin' ]]; then
    boost_libs=locale "${RIME_ROOT:-../..}"/install-boost.sh
fi
