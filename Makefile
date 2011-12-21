#*  adaptiveAnalysisOfAlgorithm


#** General:
all: adaptiveAnalysisOfAlgorithm.ps adaptiveAnalysisOfAlgorithm.pdf
	@make -i grep
grep:
	@echo "** Warnings Summary:"
	@grep Warning adaptiveAnalysisOfAlgorithm.log
e: 
	emacs -geometry 200x100 adaptiveAnalysisOfAlgorithm.tex & make gv
tgz: adaptiveAnalysisOfAlgorithm.tgz


publish:  adaptiveAnalysisOfAlgorithm.ps adaptiveAnalysisOfAlgorithm.pdf
	scp adaptiveAnalysisOfAlgorithm.ps adaptiveAnalysisOfAlgorithm.pdf cpu102.cs:~/public_html/Recherche/Publishing/Preprints/  
adaptiveAnalysisOfAlgorithm.tgz: clean
	rm -f adaptiveAnalysisOfAlgorithm.tgz
	tar -czvf  adaptiveAnalysisOfAlgorithm.tgz ./* 
	@echo "Use tar -xzvf  adaptiveAnalysisOfAlgorithm.tgz to extract"
	scp adaptiveAnalysisOfAlgorithm.tgz cpu102.cs:~/tmp/

#** Article:
xpdf: adaptiveAnalysisOfAlgorithm.pdf
	xpdf adaptiveAnalysisOfAlgorithm.pdf &
gv:  adaptiveAnalysisOfAlgorithm.ps
	gv  adaptiveAnalysisOfAlgorithm.ps &
adaptiveAnalysisOfAlgorithm.pdf: adaptiveAnalysisOfAlgorithm.ps
	ps2pdf adaptiveAnalysisOfAlgorithm.ps
adaptiveAnalysisOfAlgorithm.ps: adaptiveAnalysisOfAlgorithm.dvi
	dvips -q -o adaptiveAnalysisOfAlgorithm.ps adaptiveAnalysisOfAlgorithm.dvi
adaptiveAnalysisOfAlgorithm.dvi: adaptiveAnalysisOfAlgorithm.toc adaptiveAnalysisOfAlgorithm.bbl adaptiveAnalysisOfAlgorithm.ind figures
	latex adaptiveAnalysisOfAlgorithm 
adaptiveAnalysisOfAlgorithm.bbl: adaptiveAnalysisOfAlgorithm.toc 
	bibtex -terse adaptiveAnalysisOfAlgorithm
adaptiveAnalysisOfAlgorithm.toc: adaptiveAnalysisOfAlgorithm.tex
	latex adaptiveAnalysisOfAlgorithm 
adaptiveAnalysisOfAlgorithm.ind: adaptiveAnalysisOfAlgorithm.idx
	makeindex adaptiveAnalysisOfAlgorithm 

figures:
	@echo Pas de figures.
# cd Figures && make && cd ..


#** Nettoyage:
clean:
	rm -f adaptiveAnalysisOfAlgorithm.ps adaptiveAnalysisOfAlgorithm.pdf
	rm -f *.aux *.log *.bbl *.rel *~ *.ind *.idx
	rm -f *.dvi *.blg *.toc
	rm -f *.loa *.lof *.ilg
	rm -rf auto adaptiveAnalysisOfAlgorithm.nav adaptiveAnalysisOfAlgorithm.out adaptiveAnalysisOfAlgorithm.snm
#	cd Figures && make clean && cd ..
