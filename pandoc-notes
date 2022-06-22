#!/bin/bash
{ cat pandoc.yaml; find . -type f -name "*.md" -not -iname readme.md -print0 | sort -z | xargs -0 sed -e "/^#\ /i \ " -e "s?~~~?$(pwd)?g" ; } | pandoc -o master.pdf --toc -N
