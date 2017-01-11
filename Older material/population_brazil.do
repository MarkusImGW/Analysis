cd "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population"
clear all

** Data-manipulations: 
* Deleted header in some xls files
* deleted provinces tab so stata can read in the fiels



import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1995_mu.xls", clear sheet("Tab_Municipios") firstrow 
drop if POP1995==.
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1995_mu, replace

** No 1996

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1997_mu.xls", clear sheet("Tab_Municipios") firstrow 
drop if POP1997==.
drop if CODUF==.
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1997_mu, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1998_mu.xls", clear sheet("Tab_Municipios") firstrow 
drop if POP1998==.
drop if CODUF==.
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1998_mu, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1999_mu.xls", clear sheet("Tab_Muniipios") firstrow 
drop if CODUF==.
drop if POP-1999==.
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_1999_mu, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2000.xls", clear sheet("P5507DOU") firstrow 
drop F
gen str5 z = string(CODMUNIC,"%05.0f")
drop CODMUNIC
rename z CODMUNIC
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2000, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2001.xls", clear sheet("P5561TCU") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2001, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2002.xls", clear sheet("P2002DOU") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2002, replace
*
import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2003.xls", clear sheet("P5560DOU") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2003, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2004.xls", clear sheet("P5564") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2004, replace
*int

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2005.xls", clear sheet("POP05DOU") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2005, replace
*int

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2006.xls", clear sheet("P5564TCU") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2006, replace
*integer

** No 2007

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2008.xls", clear sheet("POP08DOU") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2008, replace
*string

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2009.xls", clear sheet("MUNICÍPIOS") firstrow 
drop F
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2009, replace
*long codmunic

** No 2010 + below here: Codmunic is all string 

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2011.xls", clear sheet("MUNICÍPIOS") firstrow 
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2011, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2012.xls", clear sheet("TAB_TCU_Municípios") firstrow 
drop F
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2012, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2013.xls", clear sheet("Municípios") firstrow 
drop F G H
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2013, replace

import excel "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2014.xls", clear sheet("Municípios") firstrow 
drop F
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Population/estimativa_2014, replace

use estimativa_1995_mu, clear
merge 1:m CODUF NOMEDOMUNICPIO using estimativa_1997_mu
merge 1:m CODUF CODMUNIC NOMEDOMUNICPIO using estimativa_1998_mu, nogenerate	
merge 1:m CODUF CODMUNIC NOMEDOMUNICPIO using estimativa_1999_mu, nogenerate
merge 1:m CODUF CODMUNIC NOMEDOMUNICPIO using estimativa_2000, nogenerate	
merge 1:m CODUF CODMUNIC NOMEDOMUNICPIO using estimativa_2001, nogenerate	

merge 1:1 CODUF CODMUNIC using estimativa_2002, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2003, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2004, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2005, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2006, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2008, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2009, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2011, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2012, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2013, nogenerate	
merge 1:1 CODUF CODMUNIC using estimativa_2014, nogenerate	



