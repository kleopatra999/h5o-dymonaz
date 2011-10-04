HTML2MARKDOWN=html2text
CURL=curl
CURLOPTS=
UNZIP=unzip
UNZIPOPTS=
YUIVERSION=2.4.2
YUI=http://yui.zenfs.com/releases/yuicompressor/yuicompressor-$(YUIVERSION).zip
SVNANTVERSION=1.3.1
SVNANT=http://subclipse.tigris.org/files/documents/906/49042/svnant-$(SVNANTVERSION).zip
CLOSURE=http://closure-compiler.googlecode.com/files/compiler-latest.zip
GIT=git
GITOPTS=
SOURCES=$(wildcard h5o-js/src/*.js) $(wildcard h5o-js/src/*.html) $(wildcard h5o-js/src/*.txt)

all: \
  README.md\
  version.txt\
  build\
  build/yuicompressor-$(YUIVERSION).jar\
  build/svnant-$(SVNANTVERSION)\
  build/closure-compiler/compiler.jar\
  outliner.js\
  outliner.min.js\
  outliner.node.js\
  outliner.html

README.md: README.html
	$(HTML2MARKDOWN) $(HTML2MARKDOWNFLAGS) $< > $@

build:
	mkdir $@

build/yuicompressor-$(YUIVERSION).zip:
	$(CURL) $(CURLOPTS) "$(YUI)" > $@

build/yuicompressor-$(YUIVERSION).jar: build/yuicompressor-$(YUIVERSION).zip
	$(UNZIP) $(UNZIPOPTS) -d build $<
	cp build/yuicompressor-$(YUIVERSION)/build/yuicompressor-$(YUIVERSION).jar $@

build/svnant-$(SVNANTVERSION).zip:
	$(CURL) $(CURLOPTS) "$(SVNANT)" > $@

build/svnant-$(SVNANTVERSION): build/svnant-$(SVNANTVERSION).zip
	$(UNZIP) $(UNZIPOPTS) -d $@ $<

build/compiler-latest.zip:
	$(CURL) $(CURLOPTS) "$(CLOSURE)" > $@

build/closure-compiler/compiler.jar: build/compiler-latest.zip
	$(UNZIP) $(UNZIPOPTS) -d $(dir $@) $<
	touch $@

version.txt:
	$(GIT) $(GITOPTS) log | head -n1 | cut -c8- > $@

release: all version.txt

h5o-js/dist/outliner.debug.js: $(SOURCES)
	$(MAKE) -C h5o-js dist/outliner.debug.js

h5o-js/dist/outliner.min.js: $(SOURCES)
	$(MAKE) -C h5o-js dist/outliner.min.js

outliner.js: h5o-js/dist/outliner.debug.js
	cp $< $@

outliner.min.js: h5o-js/dist/outliner.min.js
	cp $< $@

outliner.node.js: outliner.js
	cp $< $@
	echo >> $@
	echo "exports.HTML5Outline = HTML5Outline;" >> $@

outliner.html: h5o-js/dist/outliner.html
	cp $< $@

clean:
	$(RM) README.md
	$(MAKE) -C h5o-js clean
	$(RM) version.txt
	$(RM) outliner.js
	$(RM) outliner.min.js
	$(RM) outliner.html

distclean: clean
	$(RM) -r build
