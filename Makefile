Src=main-v11
Bib=$(shell ls *.bib *.bst)

all : dirs tex bib  tex tex done

one : dirs tex done 

preview :
	open $(HOME)/tmp/$(Src).pdf &

view :
	open $(HOME)/tmp/$(Src).pdf &


done : embedfonts
	@printf "\n\n\n==============================================\n"
	@printf       "see output in $(HOME)/tmp/$(Src).pdf\n"
	@printf       "==============================================\n\n\n"
	@printf "\n\nWarnings (may be none):\n\n"
	grep arning $(HOME)/tmp/${Src}.log

dirs : 
	- [ ! -d $(HOME)/tmp ] && mkdir $(HOME)/tmp

tex :
	- pdflatex -output-directory=$(HOME)/tmp $(Src)

embedfonts:
	@ gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite \
          -sOutputFile=$(HOME)/tmp/$(Src)-embedded.pdf $(HOME)/tmp/$(Src).pdf
	@ mv              $(HOME)/tmp/$(Src)-embedded.pdf $(HOME)/tmp/$(Src).pdf

bib : 
	- cp $(Bib) $(HOME)/tmp; cd $(HOME)/tmp; bibtex $(Src)



typo:   ready
	@- git status
	@- git commit -am "saving"
	@- git push origin master # <== update as needed

commit: ready
	@- git status
	@- git commit -a
	@- git push origin master

update: ready
	@- git pull origin master

status: ready
	@- git status

ready:
	@git config --global credential.helper cache
	@git config credential.helper 'cache --timeout=3600'

timm:  # <== change to your name
	@git config --global user.name "Tim Menzies"
	@git config --global user.email tim.menzies@gmail.com
