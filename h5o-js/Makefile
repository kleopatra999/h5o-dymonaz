ANT=ant
ANTOPTS=

dist/outliner.debug.js:
	$(ANT) $(ANTOPTS) debug

dist/outliner.min.js:
	$(ANT) $(ANTOPTS) release

dist/outliner.html: dist/outliner.min.js

clean:
	$(ANT) $(ANTOPTS) clean
