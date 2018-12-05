main.pdf :
	pdflatex main.tex
	pdflatex main.tex
clean :
	rm *.aux *.log *.out *.toc
	
