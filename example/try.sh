#!/bin/sh

if [[ ${PWD##*/} != "example" ]]; then
  cd example
fi

cat test-file.go

../build/go-latex .

cat test-file.go
