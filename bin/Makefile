audio: audio.go
	go build -o audio audio.go
.PHONY: clean
clean:
	go clean -i
.PHONY: install
install: audio
	mv audio ~/bin/audio
