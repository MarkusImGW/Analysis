***********************************************************************************

* File: mort_brazil_tmf_allage_allyears.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create a dataset for municipalities and brazil for the year 2009
for all categories

Structure:
1. Insheet all data and get ready for merge
2. Merge
3. Rename and change characters
4. Save
*/
***********************************************************************************

********* Preliminaries *********
global mypath  /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local age 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local gender 0 1 2
local sex "tot male female"
local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010

*insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_3_0_0_0_0.csv", clear
*insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_1_0_0_0_0.csv", clear

********* SETTING UP THE DATA-FILES *********

foreach year in `years'{
tempfile mort_tmf_allage_`year'
local t = 2013 - `year'
**


******** GENDER IF ELSE  ******
foreach i in `gender'{
di `We are at i'
if `i' ==0{
** LOOP OVER AGE **
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_tot_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	******** IMPORTANT: HERE I AM DROPPING THE MONTHS!!!!! ********
	keep municiacutepio total
	rename total mort_tot_`k'_`year'
	save `mort_tot_`k'_`year''

}
}
else if `i' ==1{
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_male_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	keep municiacutepio total
	rename total mort_male_`k'_`year'
	save `mort_male_`k'_`year''
}
}

else if `i' ==2{
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_female_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	keep municiacutepio total
	rename total mort_female_`k'_`year'
	save `mort_female_`k'_`year''
}
}
}
********************************************************
****** setting up the basesheet for the merge **********
********************************************************
capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_0_0_0.csv", clear
keep municiacutepio total
rename total mort_tot_0_`year'
*******************
***** Merging ****
*******************
************************
***** Merging total ****
************************

foreach var of local sex{
di "`var'"
foreach k of numlist `age'{
capture noi merge 1:1 municiacutepio using `mort_`var'_`k'_`year''
drop _merge
}
}

** Renaming **

rename municiacutepio id_municipality
drop if id_municipality=="&"

******* TOTAL ******

foreach var of local sex{
rename mort_`var'_0_`year' mort_`var'_total_`year'
rename mort_`var'_1_`year' mort_`var'_0_6_days_`year'
rename mort_`var'_2_`year' mort_`var'_7_27_days_`year'
rename mort_`var'_3_`year' mort_`var'_28_365_days_`year'
rename mort_`var'_4_`year' mort_`var'_unknownminusone_`year'
gen mort_`var'_00_01_`year' = mort_`var'_0_6_days_`year' + mort_`var'_7_27_days_`year' + mort_`var'_28_365_days_`year' + mort_`var'_unknownminusone_`year'
drop mort_`var'_0_6_days_`year' mort_`var'_7_27_days_`year' mort_`var'_28_365_days_`year' mort_`var'_unknownminusone_`year'
rename mort_`var'_5_`year' mort_`var'_01_04_`year'
rename mort_`var'_6_`year' mort_`var'_05_09_`year'
rename mort_`var'_7_`year' mort_`var'_10_14_`year'
rename mort_`var'_8_`year' mort_`var'_15_19_`year'
rename mort_`var'_9_`year' mort_`var'_20_24_`year'
rename mort_`var'_10_`year' mort_`var'_25_29_`year'
rename mort_`var'_11_`year' mort_`var'_30_34_`year'
rename mort_`var'_12_`year' mort_`var'_35_39_`year'
rename mort_`var'_13_`year' mort_`var'_40_44_`year'
rename mort_`var'_14_`year' mort_`var'_45_49_`year'
rename mort_`var'_15_`year' mort_`var'_50_54_`year'
rename mort_`var'_16_`year' mort_`var'_55_59_`year'
rename mort_`var'_17_`year' mort_`var'_60_64_`year'
rename mort_`var'_18_`year' mort_`var'_65_69_`year'
rename mort_`var'_19_`year' mort_`var'_70_74_`year'
rename mort_`var'_20_`year' mort_`var'_75_79_`year'
rename mort_`var'_21_`year' mort_`var'_80_110_`year'
}


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

/* NOT DROPPING THE MONTHS HERE AS IT WAS DONE IN THE LOOPS OF DATA
**** IMPORTANT: One MONTH to make municipalities unique
drop if month != 13
** Now no more duplicates 
*/

*** Generating the additional fips, municipality and state variables
gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen municipality = substr(id_municipality, 8, .)
gen state_fips = substr(id_municipality, 1, 2) 

save `mort_tmf_allage_`year''
}


*********************************
******* MERGING YEARS ***********
*********************************
use `mort_tmf_allage_2010'
local years2 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009
foreach year in `years2'{
di `year'
merge 1:1 fips using `mort_tmf_allage_`year''
rename _merge merge_mor_`year'
}


********************************
************ SAVING ************
********************************
// DROP 

*** Save MORT_MUN_TMF_ALLAGE_2009 **********
preserve
** Creating the relational database set-up by deleting year and municipality totals
drop if id_municipality == "Total"
*drop mort_tot_total mort_male_total mort_female_total
save "${mypath}mort_mun_tmf_allage_97_10" , replace
restore
*** Save MORT_BRAZIL_TMF_ALLAGE_2009 *******
preserve
drop if id_municipality != "Total"
gen name = "brazil"
*drop mort_tot_total mort_male_total mort_female_total
save "${mypath}mort_brazil_tmf_allage_97_10" , replace
restore



***** TESING FOR IMPORTANCES MISSING OBSERVATIONS *****

/*
* TESTING NEWLY CREATED FILE MORT_MUN_TMF_ALLAGE_2009 using FIPS
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
merge 1:1 fips using "${mypath}mort_mun_tmf_allage_2009"
// DANGER; Brazil is still in there for POP
drop if id_municipality == "530010 Brasilia"
drop if _merge == 2

preserve
keep mort_female_*
gen unknown_female_percentage = sum(mort_female_22)/sum(mort_female_total)
sum unknown_female_percentage // Maximum of 2.5%, with a mean of 0.04% and a sddev of 0.0001 so looks good
restore

preserve
keep mort_male_*
gen unknown_male_percentage = sum(mort_male_22)/sum(mort_male_total)
sum unknown_male_percentage // Maximum of 0.5%, with a mean of 0.02% and a sddev of 0.0001 so looks good
restore
// So going to drop the unknowns
drop mort_female_22 mort_male_22 mort_tot_22
*/
