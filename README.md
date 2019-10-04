# go-latex

*Eoghan Conlon O'Neill, 2019*

Go-latex is a simple parser that reads Go source files, extracts LaTeX commands and replaces them with their unicode equivalents.

### Usage

Go-latex can take a directory, or a `.go` file as its input argument.

### Example
Take for example the following Go source file.

```Go
package test

func \Xi() {
	return `\xi latex is \pi \phi`
}
```

Well after running `go-latex` on it you would get the following.

```Go
package test

func Ξ() {
	return `ξ latex is π φ`
}
```
