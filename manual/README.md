# User Manual

This user manual uses [Pandoc](https://pandoc.org/) to auto-generate PDF and HTML files based on markdown content.

It can be easily integrated into existing repositories and deployed via [gh-pages](https://pages.github.com).

Please install the most recent Pandoc package to get best results on your local computer.

## Content editing

The text of the manual is located in the *.md files in this folder. Images are stored in the `images` folder.

## PDF generation

PDF files are generated using LaTeX, so a working LaTeX engine needs to be installed on your system already (e.g. texlive incl. extra fonts). The manual uses the [Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template) template.

```
make pdf
```

## HTML generation

The HTML template is based on the great [mdBook](https://github.com/rust-lang-nursery/mdBook) theme, which was simplified and adjusted a bit to suit the needs of a manual.

```
make html
```
