NAME=ncsuthesis

$(NAME).pdf : $(NAME).dtx
	pdflatex $(NAME).dtx
	makeindex -s gglo.ist -o $(NAME).gls $(NAME).glo
	pdflatex $(NAME).dtx
