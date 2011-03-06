default: compile view

compile:
	./refgen.pl

clean:
	rm *.aux *.log *.toc

pdf: compile
	pdflatex main.tex
	pdflatex main.tex

view: pdf
	google-chrome main.pdf

open: pdf
	xdg-open main.pdf
