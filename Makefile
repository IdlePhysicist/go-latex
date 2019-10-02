build="build"

platform="darwin"
cgo=0

default: clean build clean

clean:
	rm -f build/*
	touch .keep

build:
	env CGO_ENABLED=$(cgo) GOOS=$(platform) go build -o $(build)/go-latex main.go

install:
	env CGO_ENABLED=$(cgo) GOOS=$(platform) go install .

uninstall:
	rm $(GOPATH)/go-latex
