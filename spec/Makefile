all:: pdf html

pdf:: metadata.yml [0-9]*.md
	pandoc metadata.yml [0-9]*.md -o spec.pdf --template template/eisvogel.tex --from markdown --listings --number-sections --toc --metadata date="`date -u '+%Y-%m-%d'`"

html:: metadata.yml [0-9]*.md
	pandoc metadata.yml [0-9]*.md -o spec.html --template template/mdbook.html --from markdown --listings --number-sections --toc --toc-depth=3 --katex --metadata date="`date -u '+%Y-%m-%d'`"

clean::
	rm spec.pdf
	rm spec.html
