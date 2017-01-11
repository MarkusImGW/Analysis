***********************************************************************************

* File: mort_brazil_tmf_allage_2009.do
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
*local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010

********* SETTING UP THE DATA-FILES *********

foreach i in `gender'{
di `We are at i'
if `i' ==0{
foreach k of numlist `age'{
 
	tempfile mort_tot_`k'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_4_0_`k'_`i'_0.csv", clear
	******** IMPORTANT: HERE I AM DROPPING THE MONTHS!!!!! ********
	keep municiacutepio total
	rename total mort_tot_`k'
	save `mort_tot_`k''
}
}
else if `i' ==1{
foreach k of numlist `age'{
 
	tempfile mort_male_`k'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_4_0_`k'_`i'_0.csv", clear
	keep municiacutepio total
	rename total mort_male_`k'
	save `mort_male_`k''
}
}

else if `i' ==2{
foreach k of numlist `age'{
 
	tempfile mort_female_`k'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_4_0_`k'_`i'_0.csv", clear
	keep municiacutepio total
	rename total mort_female_`k'
	save `mort_female_`k''
}
}
}

** setting up the basesheet
capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_4_0_0_0_0.csv", clear
keep municiacutepio total
rename total mort_tot_0

***** Merging ****
** Merging toal **
local age2 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
foreach k of numlist `age2'{
capture noi merge 1:1 municiacutepio using `mort_tot_`k''
drop _merge
}

/*
*Create 0_1 variable: From zero to one year old based on  0-6 days, 7-27 days, 28-364 days and minus 1 (unkown day) (small category)
gen mort_tot_00_01 = mort_tot_1 + mort_tot_2 + mort_tot_3 + mort_tot_4
drop mort_tot_1 mort_tot_2 mort_tot_3 mort_tot_4
*/

*** Merging male **
local age2 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
foreach k of numlist `age2'{
capture noi merge 1:1 municiacutepio using `mort_male_`k''
drop _merge
}
/*
* Create 0_1 variable
gen mort_male_00_01 = mort_male_1 + mort_male_2 + mort_male_3 + mort_male_4
drop mort_male_1 mort_male_2 mort_male_3 mort_male_4
*/

*** Merging female **
local age2 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
foreach k of numlist `age2'{
capture noi merge 1:1 municiacutepio using `mort_female_`k''
drop _merge
}

/*
* Create 0_1 variable
gen mort_female_00_01 = mort_female_1 + mort_female_2 + mort_female_3 + mort_female_4
drop mort_female_1 mort_female_2 mort_female_3 mort_female_4
*/

*** TO CHECK //  check if the rows and colums sum up to the total
/*
egen row_tot = rowtotal(mort_*)
egen row_tot_manual = rowtotal (mort_tot_0)*2 +rowtotal(male_tot_0)*2 mort_female_0)*3
egen row = rowtotal(mort_tot_*)/2
egen
egen row_manual = rowtotal (mort_tot_0 mort_male_0 mort_female_0) 
*/

/// Renaming the Variables (TD)


******* TOTAL ******
rename municiacutepio id_municipality
drop if id_municipality=="&"
rename mort_tot_0 mort_tot_total
rename mort_tot_1 mort_tot_0_6_days
rename mort_tot_2 mort_tot_7_27_days
rename mort_tot_3 mort_tot_28_365_days
rename mort_tot_4 mort_tot_unknownminusone
gen mort_tot_00_01 = mort_tot_0_6_days + mort_tot_7_27_days + mort_tot_28_365_days + mort_tot_unknownminusone
drop mort_tot_0_6_days mort_tot_7_27_days mort_tot_28_365_days mort_tot_unknownminusone
rename mort_tot_5 mort_tot_01_04
rename mort_tot_6 mort_tot_05_09
rename mort_tot_7 mort_tot_10_14
rename mort_tot_8 mort_tot_15_19
rename mort_tot_9 mort_tot_20_24
rename mort_tot_10 mort_tot_25_29
rename mort_tot_11 mort_tot_30_34
rename mort_tot_12 mort_tot_35_39
rename mort_tot_13 mort_tot_40_44
rename mort_tot_14 mort_tot_45_49
rename mort_tot_15 mort_tot_50_54
rename mort_tot_16 mort_tot_55_59
rename mort_tot_17 mort_tot_60_64
rename mort_tot_18 mort_tot_65_69
rename mort_tot_19 mort_tot_70_74
rename mort_tot_20 mort_tot_75_79
rename mort_tot_21 mort_tot_80_110


***** MALE *********
rename mort_male_0 mort_male_total
rename mort_male_1 mort_male_0_6_days
rename mort_male_2 mort_male_7_27_days
rename mort_male_3 mort_male_28_365_days
rename mort_male_4 mort_male_unknownminusone
gen mort_male_00_01 = mort_male_0_6_days + mort_male_7_27_days + mort_male_28_365_days + mort_male_unknownminusone
drop mort_male_0_6_days mort_male_7_27_days mort_male_28_365_days mort_male_unknownminusone
rename mort_male_5 mort_male_01_04
rename mort_male_6 mort_male_05_09
rename mort_male_7 mort_male_10_14
rename mort_male_8 mort_male_15_19
rename mort_male_9 mort_male_20_24
rename mort_male_10 mort_male_25_29
rename mort_male_11 mort_male_30_34
rename mort_male_12 mort_male_35_39
rename mort_male_13 mort_male_40_44
rename mort_male_14 mort_male_45_49
rename mort_male_15 mort_male_50_54
rename mort_male_16 mort_male_55_59
rename mort_male_17 mort_male_60_64
rename mort_male_18 mort_male_65_69
rename mort_male_19 mort_male_70_74
rename mort_male_20 mort_male_75_79
rename mort_male_21 mort_male_80_110

***** FEMALE *********
drop if id_municipality=="&"
rename mort_female_0 mort_female_total
rename mort_female_1 mort_female_0_6_days
rename mort_female_2 mort_female_7_27_days
rename mort_female_3 mort_female_28_365_days
rename mort_female_4 mort_female_unknownminusone
gen mort_female_00_01 = mort_female_0_6_days + mort_female_7_27_days + mort_female_28_365_days + mort_female_unknownminusone
drop mort_female_0_6_days mort_female_7_27_days mort_female_28_365_days mort_female_unknownminusone
rename mort_female_5 mort_female_01_04
rename mort_female_6 mort_female_05_09
rename mort_female_7 mort_female_10_14
rename mort_female_8 mort_female_15_19
rename mort_female_9 mort_female_20_24
rename mort_female_10 mort_female_25_29
rename mort_female_11 mort_female_30_34
rename mort_female_12 mort_female_35_39
rename mort_female_13 mort_female_40_44
rename mort_female_14 mort_female_45_49
rename mort_female_15 mort_female_50_54
rename mort_female_16 mort_female_55_59
rename mort_female_17 mort_female_60_64
rename mort_female_18 mort_female_65_69
rename mort_female_19 mort_female_70_74
rename mort_female_20 mort_female_75_79
rename mort_female_21 mort_female_80_110

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

********************************
************ SAVING ************
********************************
// DROP 

*** Save MORT_MUN_TMF_ALLAGE_2009 **********
preserve
** Creating the relational database set-up by deleting year and municipality totals
drop if id_municipality == "Total"
*drop mort_tot_total mort_male_total mort_female_total
save "${mypath}mort_mun_tmf_allage_2009" , replace
restore
*** Save MORT_BRAZIL_TMF_ALLAGE_2009 *******
preserve
drop if id_municipality != "Total"
gen name = "brazil"
*drop mort_tot_total mort_male_total mort_female_total
save "${mypath}mort_brazil_tmf_allage_2009" , replace
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
