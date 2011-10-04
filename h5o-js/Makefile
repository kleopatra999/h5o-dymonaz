ANT=ant
ANTOPTS=
SOURCES=$(wildcard src/*.js) $(wildcard src/*.html) $(wildcard src/*.txt)

dist/outliner.debug.js: $(SOURCES)
	$(ANT) $(ANTOPTS) debug

dist/outliner.min.js: $(SOURCES)
	$(ANT) $(ANTOPTS) release

dist/outliner.html: dist/outliner.min.js

clean:
	$(ANT) $(ANTOPTS) clean
