base = slides
slidefilename = fall-course-2013-intro

.PHONY: git-sha

all: $(base).pdf

git-sha:
	echo `git describe --tags --always --dirty` > git-sha

$(base).rst.tex: $(base).rst
	./rst2beamer --codeblocks-use-pygments --template=template.tex --overlaybullets=False --output-encoding="utf-8" slides.rst > slides.rst.tex

$(base).pdf: $(base).tex $(base).rst.tex $(base).rst
	make git-sha
	pdflatex -shell-escape $(base).tex
	pdflatex -shell-escape $(base).tex
	cp slides.pdf "$(slidefilename)"-`cat git-sha`.pdf

clean:
	-rm -vf $(addprefix $(base).,toc snm log aux out nav)

distclean: clean
	-rm -vf $(base).pdf $(base).wiki.tex "$(slidefilename)"-`cat git-sha`.pdf git-sha
