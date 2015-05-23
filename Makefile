
default:	generateFiles zip 

generateSchema:
	../Stylesheets/bin/teitorelaxng --odd leap.odd.xml leap.rng;	

generateHTML:
	../Stylesheets/bin/teitohtml --odd --profile=LEAP leap.odd.xml leap.html;	

generateFiles:	generateSchema generateHTML

zip:
	rm leap.zip; zip leap.zip leap.odd.xml leap-doc.css leap.html leap.rng leap-template-letters.xml leap-template-diaries.xml 

copySchema:
	cd ../jamescummings.github.io/ && git pull && cd ../LEAP-ODD/ && cp -f leap.rng ../jamescummings.github.io/LEAP/ ; cd ../jamescummings.github.io/LEAP/ ; git commit -a -m "updates" && git push; cp ../../LEAP-ODD/leap.zip ../../../svn/research.it/LEAP/; cd ../../../svn/research.it/LEAP/; unzip leap.zip && svn ci -m "updates"

