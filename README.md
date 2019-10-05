# go-latex

*IdlePhysicist, 2019*

Go-latex is a simple parser that reads Go source files, extracts LaTeX commands and replaces them with their unicode equivalents.

### Usage

Go-latex can take a directory, or a `.go` file as its input argument. Currently the program accepts upper and lowercase Greek letters, as well as ℏ (h-bar) the reduced Planck's constant.

**Note**

It was pointed out to me that `go-latex` will replace anything that *looks* like a LaTeX macro in the parsed source code, even if it is inside a string literal. This is by deside so that the user can print unicode characters to the terminal.

The example used to bring this to my attention was string formatted as a Windows file path, while this is not an issue to me as a UNIX user but if you are a Windows user who wishes to use this software, then please be careful of the directory names in your paths. 

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
