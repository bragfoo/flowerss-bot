app_name = flowerss-bot

VERSION=$(shell git describe --tags --always)
DATA=$(shell date)
COMMIT=$(shell git rev-parse --short HEAD)
test:
	go test ./... -v

all: build

build: get
	GOOS=linux GOARCH=amd64 CGO_ENABLED=1 CC=x86_64-linux-musl-gcc CXX=x86_64-linux-musl-g++ go build -trimpath -ldflags \
	"-s -w -buildid= \
	-X 'github.com/indes/flowerss-bot/internal/config.commit=$(COMMIT)' \
	-X 'github.com/indes/flowerss-bot/internal/config.version=$(VERSION)'" -o $(app_name)

get:
	go mod download

run:
	go run .

clean:
	rm flowerss-bot