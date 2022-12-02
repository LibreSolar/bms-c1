all:: pdf html

pdf:: metadata.yml [0-9]*.md
	pandoc metadata.yml [0-9]*.md -o manual.pdf --template template/eisvogel.tex --from markdown --listings --number-sections --toc --metadata date="`date -u '+%Y-%m-%d'`"

html:: metadata.yml [0-9]*.md
	pandoc metadata.yml [0-9]*.md -o manual.html --template template/mdbook.html --from markdown --listings --number-sections --toc --toc-depth=3 --katex --metadata date="`date -u '+%Y-%m-%d'`"

clean::
	rm manual.pdf
	rm manual.html
