#!/bin/bash

curl -O http://duktape.org/api.html
curl -O http://duktape.org/style.css
dashing build duktape -s ./api.html
sqlite3 -batch duktape.docset/Contents/Resources/docSet.dsidx << 'EOF'
  /*remove parenthesis and extra .(dot) in front of function names (used to help searching the webpage online)*/
  update searchIndex set name=substr(name,2,length(name)-3) where type="Function";

  /*remove paragraph sign after guide name*/
  update searchIndex set name=substr(name,1,length(name)-2) where type="Guide";
EOF
