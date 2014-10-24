#!/bin/bash

if [ ! -d 'source' ];
then
    mkdir source 
    #grab source files from LOC
    curl --retry 3 -# http://www.loc.gov/standards/mods/v3/mods99042030_linkedDataAdded.xml -o "source/book.xml"
    curl --retry 3 -# http://www.loc.gov/standards/mods/v3/modsbook-chapter.xml -o "source/book_chapter.xml"
    curl --retry 3 -# http://lccn.loc.gov/86646620/mods -o "source/serial.xml"
    curl --retry 3 -# http://www.loc.gov/standards/mods/v3/modsjournal.xml -o "source/article.xml"
    curl --retry 3 -# http://lccn.loc.gov/97129132/mods -o "source/conference_publication.xml"
fi

#rm any previously transformed files
if [ -d 'transformed' ];
then
    rm -rf transformed
fi

#make results dir
mkdir -p ./transformed/{ris,end,bib}


#check results file
if [ -e "results" ];
then
    rm ./results
fi

for mod in source/*.xml
do
    file_name=$(basename $mod)
    echo $file_name | awk -F\. '{print "transforming: " $1}' >> results
    xml2ris -nb $mod | tee transformed/ris/$file_name | head -n1 | awk '{print "ris: " $0}' >> results
    xml2end -nb $mod | tee transformed/end/$file_name | head -n1 | awk '{print "end: " $0}' >> results
    xml2bib -nb $mod | tee transformed/bib/$file_name | head -n1 | awk '{print "bib: " $0}' >> results
    echo "----------------------------------------" >> results
done
