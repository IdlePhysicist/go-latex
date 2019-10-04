build=build

platform="darwin"
cgo=0
ldflags="-X main.commit=`git rev-list -1 HEAD | head -c 8`"

default: clean build

clean:
	rm -f $(build)/*
	touch $(build)/.keep

build:
	env CGO_ENABLED=$(cgo) GOOS=$(platform) go build -ldflags $(ldflags) -o $(build)/go-latex main.go

install:
	env CGO_ENABLED=$(cgo) GOOS=$(platform) go install -ldflags $(ldflags) .

uninstall:
	rm $(GOPATH)/bin/go-latex
