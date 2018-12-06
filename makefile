main.pdf : Appendix.tex Introduction.tex main.tex
	pdflatex -synctex=1 -shell-escape main.tex
	pdflatex -synctex=1 -shell-escape main.tex
clean :
	rm *.aux *.log *.out *.toc
	
