# go-latex

*IdlePhysicist, 2019*

Go-latex is a simple parser that reads Go source files, extracts LaTeX commands and replaces them with their unicode equivalents.

### Usage

Go-latex can take a directory, or a `.go` file as its input argument. Currently the program accepts upper and lowercase Greek letters, as well as ∇ (nabla) and ℏ (h-bar) the reduced Planck's constant, both symbols heavily used in physics.

#### Limitations

A variable can contain LaTeX macros provided the immediate following character is one of the following:
- A backslash i.e. another LaTeX macro
- An underscore
- A space
- Or a Capital letter

The only kind of character that cannot follow a macro is a lowercase letter! While this is an annoyance to some it can promote the writing of more readable code by using `_` and calitalisations to break up variable names containing several words.

**Note on string literals**

It was pointed out to me that `go-latex` will replace anything that *looks* like a LaTeX macro in the parsed source code, even if it is inside a string literal. This is by design so that the user can print unicode characters to the terminal.

The example used to bring this to my attention was string formatted as a Windows file path, while this is not an issue to me as a UNIX user but if you are a Windows user who wishes to use this software, then please be careful of the directory names in your paths.

### Example
Take for example the following Go source file.

```Go
package test

func \Xi() {
  return \`\xi latex is \pi \phi\`
}

func \gammaDot() {
  return \`\gammaDot`
}

func Frat() {
  return "\kappa\gamma\eta"

func main() {
  \hbar_star := 0.0562
  x := \Xi()
  y := \gammaDot()

}

```

Well after running `go-latex` on it you would get the following.

```Go
package test

func Ξ() {
  return \`ξ latex is π φ\`
}

func γDot() {
  return \`γDot`
}

func Frat() {
  return "κγη"

func main() {
  ℏ_star := 0.0562
  x := Ξ()
  y := γDot()

}


```
