#!/bin/sh
if [[ ${PWD##*/} != "example" ]]; then
  cd example
fi

echo 'package test

func \\Xi() {
  return \`\\xi latex is \\pi \\phi\`
}

func \\gammaDot() {
  return \`\\gammaDot`
}

func Frat() {
  return "\kappa\gamma\eta"

func main() {
  \\hbar_star := 0.0562
  x := \\Xi()
  y := \\gammaDot()

}

' > test-file.go
