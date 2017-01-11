***********************************************************************************

* File: Test_merge_2009.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to test the merging properties between the mortality, population and temperature data
for a given year. 

Structure:
1. 2009
a) Synchronize Mortality data 
b) merge
2. 2008
repeat
*/

***********************************************************************************

****************
***** 2009 *****
****************

*** Part 1 - Setting up Mortality Data 

***** Mortality - Synchronizing the name of the variable and the characters /// TC GET STANDARDIZED IN CODE LATER
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_3_0_0_0_0", clear
rename municiacutepio id_municipality
replace id_municipality = subinstr(id_municipality,"&iacute;","i",.) // í 
replace id_municipality = subinstr(id_municipality,"&atilde;","a",.) // ã
replace id_municipality = subinstr(id_municipality,"&aacute;","a",.) //á
replace id_municipality = subinstr(id_municipality,"&eacute;","e",.) //é
replace id_municipality = subinstr(id_municipality,"&acirc;","a",.) // â
replace id_municipality = subinstr(id_municipality,"&ccedil;a","ca",.) // çâ
replace id_municipality = subinstr(id_municipality,"&ocirc;","o",.) // ô
replace id_municipality = subinstr(id_municipality,"&oacute;","o",.) // ó
replace id_municipality = subinstr(id_municipality,"&ccedil;","c",.) // ç
replace id_municipality = subinstr(id_municipality,"&ecirc","e",.) // ê
replace id_municipality = subinstr(id_municipality,"&Aacute;","A",.) // Á
replace id_municipality = subinstr(id_municipality,"&otilde;","o",.) // õ
replace id_municipality = subinstr(id_municipality,"&uacute;","u",.) // ú
replace id_municipality = subinstr(id_municipality,"&Iacute","I",.) // Í
replace id_municipality = subinstr(id_municipality,"I;n","In",.) // Ín
replace id_municipality = subinstr(id_municipality,"e;","e",.) // e
replace id_municipality  = subinstr(id_municipality ,"&Oacute","O",.) // Ó
replace id_municipality  = subinstr(id_municipality ,"moji","mogi",.) // 
replace id_municipality  = subinstr(id_municipality ,"Moji","Mogi",.) // 
replace id_municipality  = subinstr(id_municipality ,"Tocos do Mogi","Tocos do Moji",.) // strange conversion
replace id_municipality  = subinstr(id_municipality ,"I;r","Ir",.) // Í
replace id_municipality  = subinstr(id_municipality ,"&Acirc;","A",.) // Â
replace id_municipality  = subinstr(id_municipality ,"&Eacute","E",.) // É

*** IMPORTANT: One MONTH to make municipalities unique
drop if month != 13
** Now no more duplicates 

gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen municipality = substr(id_municipality, 8, .)
gen state_fips = substr(id_municipality, 1, 2) 


save "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_3_0_0_0_0_renamed", replace

***** Deleting doubles/ Finding them
* No duplicates in population file


// Standardization of Temp =>still have to assign states to numbers

*** Main files to be used

/*
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_3_0_0_0_0_renamed", clear
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed.dta, clear
*/

** Merging on id_municipality (name)
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
merge 1:1 id_municipality using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_3_0_0_0_0_renamed"
drop age_01_04 age_05_09 age_10_14 age_15_19 age_20_29 age_30_39 age_40_49 age_50_59 age_60_69 age_70_79 age_80_inf month age_00_01 total mortality_0_2010_0_0_0_0
sort _merge

** Merging on fips
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
merge 1:1 fips using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_3_0_0_0_0_renamed"
** Same 0 unmatched results from master. All the unmatched from mortality are the ignorados by state and total
** Powerful, and sets up for merge with temperature.

** 5457 matched, 108 in population not found in mortality, and 132 in mortality not found in population
drop age_01_04 age_05_09 age_10_14 age_15_19 age_20_29 age_30_39 age_40_49 age_50_59 age_60_69 age_70_79 age_80_inf month age_00_01 total mortality_0_2010_0_0_0_0
sort _merge

** Merging on name and state_fips
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
merge 1:1 municipality state_fips using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_3_0_0_0_0_renamed"
** also perfect match


**********************************


****************
***** 2008 *****
****************

***** Mortality - Synchronizing the name of the variable and the characters /// TC GET STANDARDIZED IN CODE LATER
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_4_0_0_0_0", clear
rename municiacutepio id_municipality
replace id_municipality = subinstr(id_municipality,"&iacute;","i",.) // í 
replace id_municipality = subinstr(id_municipality,"&atilde;","a",.) // ã
replace id_municipality = subinstr(id_municipality,"&aacute;","a",.) //á
replace id_municipality = subinstr(id_municipality,"&eacute;","e",.) //é
replace id_municipality = subinstr(id_municipality,"&acirc;","a",.) // â
replace id_municipality = subinstr(id_municipality,"&ccedil;a","ca",.) // çâ
replace id_municipality = subinstr(id_municipality,"&ocirc;","o",.) // ô
replace id_municipality = subinstr(id_municipality,"&oacute;","o",.) // ó
replace id_municipality = subinstr(id_municipality,"&ccedil;","c",.) // ç
replace id_municipality = subinstr(id_municipality,"&ecirc","e",.) // ê
replace id_municipality = subinstr(id_municipality,"&Aacute;","A",.) // Á
replace id_municipality = subinstr(id_municipality,"&otilde;","o",.) // õ
replace id_municipality = subinstr(id_municipality,"&uacute;","u",.) // ú
replace id_municipality = subinstr(id_municipality,"&Iacute","I",.) // Í
replace id_municipality = subinstr(id_municipality,"I;n","In",.) // Ín
replace id_municipality = subinstr(id_municipality,"e;","e",.) // e
replace id_municipality  = subinstr(id_municipality ,"&Oacute","O",.) // Ó
replace id_municipality  = subinstr(id_municipality ,"moji","mogi",.) // 
replace id_municipality  = subinstr(id_municipality ,"Moji","Mogi",.) // 
replace id_municipality  = subinstr(id_municipality ,"Tocos do Mogi","Tocos do Moji",.) // strange conversion
replace id_municipality  = subinstr(id_municipality ,"I;r","Ir",.) // Í
replace id_municipality  = subinstr(id_municipality ,"&Acirc;","A",.) // Â
replace id_municipality  = subinstr(id_municipality ,"&Eacute","E",.) // É

*** IMPORTANT: One MONTH to make municipalities unique
drop if month != 13
** Now no more duplicates 

gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen municipality = substr(id_municipality, 8, .)
save "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_4_0_0_0_0_renamed", replace

//// MERGING PART 2008 ////

** Merging on id_municipality (name)
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2008", clear
merge 1:1 id_municipality using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_4_0_0_0_0_renamed"
** PERFECT MATCH WITH MASTER, 25 unmatched from mortality
** New one: 220672 Nazaria
drop age_01_04 age_05_09 age_10_14 age_15_19 age_20_29 age_30_39 age_40_49 age_50_59 age_60_69 age_70_79 age_80_inf month age_00_01 total mortality_0_2009_0_0_0_0
sort _merge

** Merging on fips
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2008", clear
merge 1:1 fips using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_4_0_0_0_0_renamed"
** Same 0 unmatched results from master. All the unmatched from mortality are the ignorados by state and total
** Powerful, and sets up for merge with temperature.  
drop age_01_04 age_05_09 age_10_14 age_15_19 age_20_29 age_30_39 age_40_49 age_50_59 age_60_69 age_70_79 age_80_inf month age_00_01 total mortality_0_2010_0_0_0_0
sort _merge

clear
gen lower_ = lower(nm_mun_2013)
gen upper2= upper(lower_)

gen upper2= upper(municiacutepio)
