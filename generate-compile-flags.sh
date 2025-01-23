#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    BREW_PREFIX=$(brew --prefix)
    cat > compile_flags.txt << EOF
-I${BREW_PREFIX}/include 
-L${BREW_PREFIX}/lib
-lglfw
-lglm
-lvulkan
EOF
else
    cat > compile_flags.txt << EOF
-I/usr/include
-L/usr/lib
-lglfw
-ldl
-lvulkan
EOF
fi
