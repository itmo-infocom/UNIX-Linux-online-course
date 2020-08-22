#!/bin/bash

usage () {
  echo ""; echo "Скрипт должен иметь один параметр."; echo ""
  echo ""; echo "    Вызов:"; echo ""
  echo "        $0 <имя tex-файла>"; echo ""
  exit
}

if [ $# = 0 ]; then
  usage
fi

fn=$1;

tex4ebook -f epub3 $fn

nm=`basename $fn .tex`
cssname="$nm.css"
echo $cssname

ed $cssname <<END
1,$%/\* start css.sty \*/%
.=
a
pre { background-color: #C0E8F8;}
img { max-width: 100%; height: auto;}
.
/p.indent{ text-indent: 1.5em }/
.s/p.indent{ text-indent: 1.5em }/p.indent{ text-indent: 0.0em }/
w
q
END

ebook-convert $nm.xhtml $nm.epub --authors "Oleg Sadov"
