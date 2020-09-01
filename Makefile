build=build

platform="darwin"
cgo=0
version?="0.0.0"
ldflags="-X main.commit=`git rev-list -1 HEAD | head -c 8` -X main.version=$(version)"

default: build

clean:
	rm -f $(build)/*
	touch $(build)/.keep

build: clean
	env CGO_ENABLED=$(cgo) GOOS=$(platform) go build -ldflags $(ldflags) -o $(build)/go-latex main.go

release: clean
	env CGO_ENABLED=$(cgo) GOOS="darwin" go build -ldflags $(ldflags) -o $(build)/go-latex-darwin main.go
	env CGO_ENABLED=$(cgo) GOOS="linux" go build -ldflags $(ldflags) -o $(build)/go-latex-linux main.go

install:
	env CGO_ENABLED=$(cgo) GOOS=$(platform) go install -ldflags $(ldflags) .

uninstall:
	rm $(GOPATH)/bin/go-latex
