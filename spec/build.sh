#!/bin/sh
#
# This script helps to build the document using the pandoc/ubuntu-latex Docker image in
# a CI/CD environment. See also .github/workflows/pandoc.yml

# Add potentially missing LaTeX packages for Eisvogel template
tlmgr install adjustbox babel-german background bidi collectbox csquotes everypage filehook \
        footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace \
        pagecolor sourcecodepro sourcesanspro titling ucharcat ulem unicode-math upquote xecjk \
        xurl zref

# Install GNU make
apt-get update
apt-get install -y make

# Run Pandoc build process using the Makefile
make all

# Copy relevant stuff into deploy folder
mv spec.html index.html
mkdir -p ../deploy/spec
cp -r index.html spec.pdf template images ../deploy/spec/
