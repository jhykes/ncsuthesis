NAME=ncsuthesis

$(NAME).pdf : $(NAME).dtx
	pdflatex $(NAME).dtx
	makeindex -s gglo.ist -o $(NAME).gls $(NAME).glo
	pdflatex $(NAME).dtx

clean :
	rm $(NAME).aux $(NAME).glo $(NAME).gls $(NAME).hd \
           $(NAME).idx $(NAME).ilg $(NAME).ins $(NAME).log \
           $(NAME).out
