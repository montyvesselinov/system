#!/bin/bash
cat sitemap-head.xml > sitemap.xml
for f in *.html
do
	if [[ $f != *"google"* ]]
	then
		echo $f
		cat sitemap-entry.xml | sed -e s/REPLACE/$f/g >> sitemap.xml
	fi
done
echo "</urlset>" >> sitemap.xml
