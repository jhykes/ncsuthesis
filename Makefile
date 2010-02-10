CHAPTERS=Chapter-*/Chapter-*.tex  Appendix-*/Appendix-*.tex
NAME=YourName-thesis

$(NAME).pdf : $(NAME).tex $(NAME).bib front.tex $(CHAPTERS)
	pdflatex $(NAME)
	bibtex $(NAME)
	pdflatex $(NAME)
	pdflatex $(NAME)
