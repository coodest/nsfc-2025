#!/bin/bash

# latex="pdflatex"
latex="xelatex"
bibtex="bibtex"
main="地区基金正文2025_尹子都"
target=$main
# parg="-file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=./ ${target}.tex"
parg="-file-line-error -interaction=nonstopmode -synctex=1 -output-directory=./ ${target}.tex"

start=$SECONDS
rm -f *.log
$latex ${parg} 2>&1 > /dev/null
if [ "$target" == "$main" ]; 
then
$bibtex ${target} 2>&1 > /dev/null
fi
$latex ${parg} 2>&1 > /dev/null
$latex ${parg} 2>&1 > /dev/null
rm -f *.aux
rm -f *.bbl
rm -f *.blg
rm -f *.out
rm -f *.cut

# seek number of errors and warnings
COUNT_E=$(grep -o "error" "$main".log | wc -l)
COUNT_W=$(grep -o "warning" "$main".log | wc -l)

# output
# 定义颜色代码
RED='\033[0;31m'      # 红色
GREEN='\033[0;32m'    # 绿色
YELLOW='\033[0;33m'   # 黄色
BLUE='\033[0;34m'     # 蓝色
NC='\033[0m'          # 重置颜色（No Color）

echo -e "compile using ${GREEN}$(( SECONDS - start ))s${NC} Error ${RED}$((COUNT_E - 2))${NC} Warning ${YELLOW}$((COUNT_W - 1))${NC}"