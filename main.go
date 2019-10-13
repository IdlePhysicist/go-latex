package main

import (
  "flag"
  "fmt"
  "io/ioutil"
  "log"
  "os"
  "path/filepath"
  "regexp"
  "strings"

  ref "github.com/idlephysicist/go-latex/reference"
)

var (
  files []string
  commit string
	version string
  versionFlg bool
)

func main() {
  // Read file arg
  flag.BoolVar(&versionFlg, "v", false, "Print version and exit")
  flag.Parse()
  fileArg := flag.Arg(0)

  if versionFlg {
		fmt.Printf("go-latex version: %s\nbuild commit: %s\n", version, commit)
    os.Exit(0)
  }

  // Determine the arg we got i.e. a single .go file or a .
  if fileArg == `.` {
    err := findFiles(fileArg)
    if err != nil {
      log.Println(err)
    }

  } else {

    if fileExists(fileArg) && filepath.Ext(fileArg) == `.go` {
      files = append(files, fileArg)

    } else {
      log.Println("Error invalid file name")
      os.Exit(1)
    }
  }

  // Iterate through the files that we've found
  for _, file := range files {
    contents, err := ioutil.ReadFile(file)
    if err != nil {
      log.Println("An Error occured reading %s", err)
      continue
    }

    fmt.Println(`Processing file:`, file)
    updatedText := process(string(contents))

    err = ioutil.WriteFile(file, []byte(updatedText), 0644)
    if err != nil {
      log.Fatalln(err)
    }
  }
}

// process takes the text from the source file, regexes it for LaTeX commands
// 
func process(text string) string {
  regex := regexp.MustCompile(`\\[A-Za-z][a-z]*[a-z]`)
  var unicodedText []string

  for _, line := range strings.Split(text, `\n`) {
    allIndices := regex.FindAllStringIndex(line, -1)

    for _, loc := range allIndices {
      latexCmd := text[loc[0]:loc[1]]
      unicodeString := ref.Chart[latexCmd]

      line = strings.Replace(line, latexCmd, unicodeString, -1)
    }

    unicodedText = append(unicodedText, line)
  }

  return strings.Join(unicodedText, `\n`)
}


func findFiles(root string) error {
  return filepath.Walk(root,
    func(path string, info os.FileInfo, err error) error {
      if err != nil {
          return err
      }

      if filepath.Ext(path) == `.go` {
        fmt.Println(`Found`, path)
        files = append(files, path)
      }
      return nil
  })
}

func fileExists(name string) bool {
  info, err := os.Stat(name)
  if os.IsNotExist(err) {
      return false
  }
  return !info.IsDir()
}
