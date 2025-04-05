DEPS:= resume.cls fontawesome5/fontawesome5.sty
SRCS:= resume-zh.tex 
PDFS:= $(SRCS:%.tex=%.pdf)

DATE= $(shell date +%Y%m%d)
DISTDIR= resume.$(DATE)

# Environment variables
TEXINPUTS:= .:fontawesome5:$(TEXINPUTS)

all: $(PDFS)
zh: resume-zh.pdf
 $(PDFS):
	gs -dBATCH -dNOPAUSE -dPrinted=false \
		-sDEVICE=pdfwrite \
		-sOutputFile=$@ \
		$(PDFS)

resume-zh.pdf: resume-zh.tex $(DEPS)
	env TEXINPUTS=$(TEXINPUTS) latexmk -xelatex $<


dist: all
	mkdir $(DISTDIR)
	cp Makefile $(DEPS) $(SRCS) $(PDFS) $(DISTDIR)/
	tar -cjf $(DISTDIR).tar.bz2 $(DISTDIR)/
	rm -r $(DISTDIR)

clean:
	for f in $(SRCS); do \
		latexmk -c $$f; \
	done
	touch $(SRCS)

cleanall:
	for f in $(SRCS); do \
		latexmk -C $$f; \
	done

.PHONY: all  zh dist clean cleanall
