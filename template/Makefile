CHAPTERS=Chapter-*/Chapter-*.tex  Appendix-*/Appendix-*.tex
NAME=YourName-thesis
AUX=$(NAME).aux front.aux Chapter-*/*.aux Appendix-*/*.aux optional.aux
INTERMEDIATES=$(NAME).bbl $(NAME).blg $(NAME).lof $(NAME).lot \
              $(NAME).log $(NAME).toc 

$(NAME).pdf : $(NAME).tex $(NAME).bib front.tex $(CHAPTERS) ncsuthesis.cls optional.tex
	pdflatex $(NAME)
	bibtex $(NAME)
	pdflatex $(NAME)
	pdflatex $(NAME)

clean :
	rm $(AUX) $(INTERMEDIATES)


