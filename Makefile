#!/usr/bin/make -f
PDFLATEX  = pdflatex -interaction=nonstopmode
RTF = latex2rtf
BIBTEX = bibtex
WRITER = oowriter
FORMAT = fold -sw 80
HTML = hevea -o html/

MATH = theMathOf
SOURCE = article
BIB    = article
SIM = simulation
DIFF = diff
OUT = trudeau

all: pdf math
	#cd $(SIM); $(MAKE) sim

pdf:
	#$(FORMAT) $(SOURCE).tex > tmp.tex
	#mv tmp.tex article.tex
	$(PDFLATEX) $(SOURCE)	
	# LT: Run it twice for referencing issues.
	$(BIBTEX) $(SOURCE)
	$(PDFLATEX) $(SOURCE)
	$(PDFLATEX) $(SOURCE)
	cp $(SOURCE).pdf $(OUT).pdf
math:
	$(PDFLATEX) $(MATH)

clean:
	rm -fv *.aux *.bbl *.blg *.log *.lot *.toc *.lof *.out
	#cd $(SIM); $(MAKE) clean

# LT: Added so I can see the log output in texmaker
texmaker-clean:
	rm -fv *.aux *.bbl *.blg *.lot *.toc *.lof *.out

# LT: Added to use with after the deadline
spellcheck:
	$(RTF) $(SOURCE)
	$(WRITER) $(SOURCE).rtf
	
diff:
	$(PDFLATEX) $(DIFF)
	# LT: Run it twice for referencing issues.
	$(BIBTEX) $(DIFF)
	$(PDFLATEX) $(DIFF)
	$(PDFLATEX)  $(DIFF)
	
html: pdf
	$(HTML)$(SOURCE).html $(SOURCE).tex
	
