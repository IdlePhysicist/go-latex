#!/bin/sh
if [[ ${PWD##*/} != "example" ]]; then
  cd example
fi

echo "package test\n\nfunc \\Xi() {\n	return \`\\xi latex is \\pi \\phi\`\n}\n" > test-file.go
