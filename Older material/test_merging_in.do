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
local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010

*insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_3_0_0_0_0.csv", clear
*insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_1_0_0_0_0.csv", clear

********* SETTING UP THE DATA-FILES *********

foreach year in `years'{
di "Beginning new year"
tempfile mort_tmf_allage_`year'
local t = 2013 - `year'
**


******** GENDER IF ELSE  ******
foreach i in `gender'{
di "We are at `i'"
if `i' ==0{
** LOOP OVER AGE **
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_tot_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	******** IMPORTANT: HERE I AM DROPPING THE MONTHS!!!!! ********
	rename total mort_tot_`k'_`year'
	cap noi rename janeiro mort_tot_m1_`k'_`year'
	cap noi rename fevereiro mort_tot_m2_`k'_`year' 
	cap noi	rename marccedilo mort_tot_m3_`k'_`year'
	cap noi	rename abril mort_tot_m4_`k'_`year'
	cap noi	rename maio mort_tot_m5_`k'_`year'
	cap noi	rename junho mort_tot_m6_`k'_`year'
	cap noi	rename julho mort_tot_m7_`k'_`year'
	cap noi	rename agosto mort_tot_m8_`k'_`year'
	cap noi	rename setembro mort_tot_m9_`k'_`year'
	cap noi	rename outubro mort_tot_m10_`k'_`year'
	cap noi	rename novembro mort_tot_m11_`k'_`year'
	cap noi	rename dezembro mort_tot_m12_`k'_`year'
	save `mort_tot_`k'_`year''

}
}
else if `i' ==1{
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_male_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_male_`k'_`year'
	cap noi rename janeiro mort_male_m1_`k'_`year'
	cap noi rename janeiro mort_male_m1_`k'_`year'
	cap noi rename fevereiro mort_male_m2_`k'_`year' 
	cap noi	rename marccedilo mort_male_m3_`k'_`year'
	cap noi	rename abril mort_male_m4_`k'_`year'
	cap noi	rename maio mort_male_m5_`k'_`year'
	cap noi	rename junho mort_male_m6_`k'_`year'
	cap noi	rename julho mort_male_m7_`k'_`year'
	cap noi	rename agosto mort_male_m8_`k'_`year'
	cap noi	rename setembro mort_male_m9_`k'_`year'
	cap noi	rename outubro mort_male_m10_`k'_`year'
	cap noi	rename novembro mort_male_m11_`k'_`year'
	cap noi	rename dezembro mort_male_m12_`k'_`year'
	save `mort_male_`k'_`year''
}
}

else if `i' ==2{
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_female_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_female_`k'_`year'
	cap noi rename janeiro mort_female_m1_`k'_`year'
	cap noi rename fevereiro mort_female_m2_`k'_`year' 
	cap noi	rename marccedilo mort_female_m3_`k'_`year'
	cap noi	rename abril mort_female_m4_`k'_`year'
	cap noi	rename maio mort_female_m5_`k'_`year'
	cap noi	rename junho mort_female_m6_`k'_`year'
	cap noi	rename julho mort_female_m7_`k'_`year'
	cap noi	rename agosto mort_female_m8_`k'_`year'
	cap noi	rename setembro mort_female_m9_`k'_`year'
	cap noi	rename outubro mort_female_m10_`k'_`year'
	cap noi	rename novembro mort_female_m11_`k'_`year'
	cap noi	rename dezembro mort_female_m12_`k'_`year'
	save `mort_female_`k'_`year''
}
}
}
********************************************************
****** setting up the basesheet for the merge **********
********************************************************
capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_0_0_0.csv", clear
*keep municiacutepio total
	rename total mort_tot_0_`year'
	cap noi rename janeiro mort_tot_m1_0_`year'
	cap noi	rename fevereiro mort_tot_m2_0_`year' 
	cap noi	rename marccedilo mort_tot_m3_0_`year'
	cap noi	rename abril mort_tot_m4_0_`year'
	cap noi	rename maio mort_tot_m5_0_`year'
	cap noi	rename junho mort_tot_m6_0_`year'
	cap noi	rename julho mort_tot_m7_0_`year'
	cap noi	rename agosto mort_tot_m8_0_`year'
	cap noi	rename setembro mort_tot_m9_0_`year'
	cap noi	rename outubro mort_tot_m10_0_`year'
	cap noi	rename novembro mort_tot_m11_0_`year'
	cap noi	rename dezembro mort_tot_m12_0_`year'

*******************
***** Merging ****
*******************
local age2 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22

************************
***** Merging total ****
************************

foreach k of numlist `age2'{
capture noi merge 1:1 municiacutepio using `mort_tot_`k'_`year''
drop _merge
}

/*
*Create 0_1 variable: From zero to one year old based on  0-6 days, 7-27 days, 28-364 days and minus 1 (unkown day) (small category)
gen mort_tot_00_01 = mort_tot_1 + mort_tot_2 + mort_tot_3 + mort_tot_4
drop mort_tot_1 mort_tot_2 mort_tot_3 mort_tot_4
*/
********************
*** Merging male ***
********************

foreach k of numlist `age2'{
capture noi merge 1:1 municiacutepio using `mort_male_`k'_`year''
drop _merge
}

/*
* Create 0_1 variable
gen mort_male_00_01 = mort_male_1 + mort_male_2 + mort_male_3 + mort_male_4
drop mort_male_1 mort_male_2 mort_male_3 mort_male_4
*/

********************
*** Merging female ***
********************

foreach k of numlist `age2'{
capture noi merge 1:1 municiacutepio using `mort_female_`k'_`year''
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

rename municiacutepio id_municipality
drop if id_municipality=="&"

******* TOTAL ******
// TO ADJUST, NOT READING THE MONTHLY ONES
local gnder "tot male female"
foreach sex of local gnder {
rename mort_`sex'_0_`year' mort_`sex'_total_`year'
rename mort_`sex'_1_`year' mort_`sex'_0_6_days_`year'
rename mort_`sex'_2_`year' mort_`sex'_7_27_days_`year'
rename mort_`sex'_3_`year' mort_`sex'_28_365_days_`year'
rename mort_`sex'_4_`year' mort_`sex'_unknownminusone_`year'
gen mort_`sex'_00_01_`year' = mort_`sex'_0_6_days_`year' + mort_`sex'_7_27_days_`year' + mort_`sex'_28_365_days_`year' + mort_`sex'_unknownminusone_`year'
drop mort_`sex'_0_6_days_`year' mort_`sex'_7_27_days_`year' mort_`sex'_28_365_days_`year' mort_`sex'_unknownminusone_`year'
rename mort_`sex'_5_`year' mort_`sex'_01_04_`year'
rename mort_`sex'_6_`year' mort_`sex'_05_09_`year'
rename mort_`sex'_7_`year' mort_`sex'_10_14_`year'
rename mort_`sex'_8_`year' mort_`sex'_15_19_`year'
rename mort_`sex'_9_`year' mort_`sex'_20_24_`year'
rename mort_`sex'_10_`year' mort_`sex'_25_29_`year'
rename mort_`sex'_11_`year' mort_`sex'_30_34_`year'
rename mort_`sex'_12_`year' mort_`sex'_35_39_`year'
rename mort_`sex'_13_`year' mort_`sex'_40_44_`year'
rename mort_`sex'_14_`year' mort_`sex'_45_49_`year'
rename mort_`sex'_15_`year' mort_`sex'_50_54_`year'
rename mort_`sex'_16_`year' mort_`sex'_55_59_`year'
rename mort_`sex'_17_`year' mort_`sex'_60_64_`year'
rename mort_`sex'_18_`year' mort_`sex'_65_69_`year'
rename mort_`sex'_19_`year' mort_`sex'_70_74_`year'
rename mort_`sex'_20_`year' mort_`sex'_75_79_`year'
rename mort_`sex'_21_`year' mort_`sex'_80_110_`year'
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


di "At the end"
save `mort_tmf_allage_`year''
}
*********************************
******* MERGING YEARS ***********
*********************************
use `mort_tmf_allage_2010'
local years2 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009
foreach year in `years2'{
di "`year'"
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





*****************************************************************

local variables 
local broers "Arvid Riemert"
foreach var of local broers{
 	di "`var'"
 	local variables "`variables' `var'"
}
di "`variables'"

local monthloop m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12
local ageloop 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local sexloop tot male female
local variables 
foreach var1 of local monthloop{
foreach var2 of local sexloop{
foreach var3 of local ageloop{
local variables "`variables' mort_`var2'_`var1'_`var3'_*"
}
}
}
di "`variables'"
reshape long `variables', i(fips) j(year)

*****************************************************************








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
