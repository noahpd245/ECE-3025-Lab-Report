main.pdf : Appendix.tex Introduction.tex main.tex
	pdflatex main.tex
	pdflatex main.tex
clean :
	rm *.aux *.log *.out *.toc
	
