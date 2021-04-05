#!/bin/bash
source config.sh
for book in "${translation}"/*/;
do
  bookname=`basename "$book"`
  rm "$book$bookname.md"
  for chapter in "${book}"/*;
  do
    chaptername=`basename "$chapter"`
    extension="${chaptername##*.}"
    chaptername="${chaptername%.*}"
    three=`echo $chaptername | cut -d " " -f3`
    # echo "bookname $bookname"
    echo "[[$chaptername]]" >> "$book$bookname-tmp.md"
    echo "links: [[The Bible]]" > "$book$bookname.md"
    echo "# $bookname" >> "$book$bookname.md"
    echo "---" >> "$book$bookname.md"
    if [ -z "$three" ];
    then
      sort -k 2n "$book$bookname-tmp.md" >> "$book$bookname.md"
    else 
      sort -k 3n "$book$bookname-tmp.md" >> "$book$bookname.md"
    fi
  done;
done;
find . -name *-tmp.md -exec rm -rf {} \;
