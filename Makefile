up:
	@hugo server -D

lint:
	@markdownlint ./content/**/*.md

build:
	@hugo build --minify

clean:
	@rm -rf ./public/