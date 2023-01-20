#!/bin/sh
#
# This script helps to build the document using the pandoc/ubuntu-latex Docker image in
# a CI/CD environment. See also .github/workflows/pandoc.yml

# exit when any command fails
set -e

# Add potentially missing LaTeX packages for Eisvogel template
tlmgr update --self
tlmgr install \
        adjustbox \
        babel-german \
        background \
        bidi \
        catchfile \
        collectbox \
        csquotes \
        everypage \
        filehook \
        footmisc \
        footnotebackref \
        framed \
        fvextra \
        hardwrap \
        koma-script \
        letltxmacro \
        ly1 \
        mdframed \
        mweights \
        needspace \
        pagecolor \
        sourcecodepro \
        sourcesanspro \
        titling \
        ucharcat \
        ulem \
        unicode-math \
        upquote \
        xecjk \
        xurl \
        zref

# Install GNU make
apt-get update
apt-get install -y make

# Run Pandoc build process using the Makefile
make all

# Copy relevant stuff into deploy folder
mv manual.html index.html
mkdir -p ../deploy/manual
cp -r index.html manual.pdf template images ../deploy/manual/

# Also copy interactive BOM from build folder (if existing)
cp -r ../build/*_ibom.html ../deploy
