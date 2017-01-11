***********************************************************************************

* File: mort_tmf_total_97_10_monthly.do
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
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

local age 0 
* 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local gender 0 1 2
local sex "tot male female"
local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010

insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_3_0_0_0_0.csv", clear
*insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_1_0_0_0_0.csv", clear

********* SETTING UP THE DATA-FILES *********

foreach year in `years'{
tempfile mort_tmf_allage_`year'
* next line creates code in line with how the data was structured from the scraping
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
	rename total mort_tot_`k'_total_`year'
	rename janeiro mort_tot_`k'_1_`year' 
	rename fevereiro mort_tot_`k'_2_`year'
	rename marccedilo mort_tot_`k'_3_`year' 
	rename abril mort_tot_`k'_4_`year'
	rename maio mort_tot_`k'_5_`year'
	rename junho mort_tot_`k'_6_`year'
	rename julho mort_tot_`k'_7_`year'
	rename agosto mort_tot_`k'_8_`year'
	rename setembro mort_tot_`k'_9_`year'
	rename outubro mort_tot_`k'_10_`year'
	rename novembro mort_tot_`k'_11_`year'
	rename dezembro mort_tot_`k'_12_`year'
	save `mort_tot_`k'_`year''
	

}
}
else if `i' ==1{
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_male_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_male_`k'_total_`year'
	rename janeiro mort_male_`k'_1_`year' 
	rename fevereiro mort_male_`k'_2_`year'
	rename marccedilo mort_male_`k'_3_`year' 
	rename abril mort_male_`k'_4_`year'
	rename maio mort_male_`k'_5_`year'
	rename junho mort_male_`k'_6_`year'
	rename julho mort_male_`k'_7_`year'
	rename agosto mort_male_`k'_8_`year'
	rename setembro mort_male_`k'_9_`year'
	rename outubro mort_male_`k'_10_`year'
	rename novembro mort_male_`k'_11_`year'
	rename dezembro mort_male_`k'_12_`year'
	save `mort_male_`k'_`year''
}
}

else if `i' ==2{
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_female_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_female_`k'_total_`year'
	rename janeiro mort_female_`k'_1_`year' 
	rename fevereiro mort_female_`k'_2_`year'
	rename marccedilo mort_female_`k'_3_`year' 
	rename abril mort_female_`k'_4_`year'
	rename maio mort_female_`k'_5_`year'
	rename junho mort_female_`k'_6_`year'
	rename julho mort_female_`k'_7_`year'
	rename agosto mort_female_`k'_8_`year'
	rename setembro mort_female_`k'_9_`year'
	rename outubro mort_female_`k'_10_`year'
	rename novembro mort_female_`k'_11_`year'
	rename dezembro mort_female_`k'_12_`year'
	save `mort_female_`k'_`year''
}
}
}
********************************************************
****** setting up the basesheet for the merge **********
********************************************************
capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_0_0_0.csv", clear
	rename total mort_tot_0_total_`year'
	rename janeiro mort_tot_0_1_`year' 
	rename fevereiro mort_tot_0_2_`year'
	rename marccedilo mort_tot_0_3_`year' 
	rename abril mort_tot_0_4_`year'
	rename maio mort_tot_0_5_`year'
	rename junho mort_tot_0_6_`year'
	rename julho mort_tot_0_7_`year'
	rename agosto mort_tot_0_8_`year'
	rename setembro mort_tot_0_9_`year'
	rename outubro mort_tot_0_10_`year'
	rename novembro mort_tot_0_11_`year'
	rename dezembro mort_tot_0_12_`year'
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
// drop unknowns
cap noi drop ignorado

******* TOTAL ******
/*
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
*/


replace id_municipality = subinstr(id_municipality,"&iacute;","i",.) // � 
replace id_municipality = subinstr(id_municipality,"&atilde;","a",.) // �
replace id_municipality = subinstr(id_municipality,"&aacute;","a",.) //�
replace id_municipality = subinstr(id_municipality,"&eacute;","e",.) //�
replace id_municipality = subinstr(id_municipality,"&acirc;","a",.) // �
replace id_municipality = subinstr(id_municipality,"&ccedil;a","ca",.) // ��
replace id_municipality = subinstr(id_municipality,"&ocirc;","o",.) // �
replace id_municipality = subinstr(id_municipality,"&oacute;","o",.) // �
replace id_municipality = subinstr(id_municipality,"&ccedil;","c",.) // �
replace id_municipality = subinstr(id_municipality,"&ecirc","e",.) // �
replace id_municipality = subinstr(id_municipality,"&Aacute;","A",.) // �
replace id_municipality = subinstr(id_municipality,"&otilde;","o",.) // �
replace id_municipality = subinstr(id_municipality,"&uacute;","u",.) // �
replace id_municipality = subinstr(id_municipality,"&Iacute","I",.) // �
replace id_municipality = subinstr(id_municipality,"I;n","In",.) // �n
replace id_municipality = subinstr(id_municipality,"e;","e",.) // e
replace id_municipality  = subinstr(id_municipality ,"&Oacute","O",.) // �
replace id_municipality  = subinstr(id_municipality ,"moji","mogi",.) // 
replace id_municipality  = subinstr(id_municipality ,"Moji","Mogi",.) // 
replace id_municipality  = subinstr(id_municipality ,"Tocos do Mogi","Tocos do Moji",.) // strange conversion
replace id_municipality  = subinstr(id_municipality ,"I;r","Ir",.) // �
replace id_municipality  = subinstr(id_municipality ,"&Acirc;","A",.) // �
replace id_municipality  = subinstr(id_municipality ,"&Eacute","E",.) // �

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
drop if _merge == 1 | _merge == 2
drop _merge
*rename _merge merge_mor_`year'
}

*********************************
*******   RESHAPING    **********
*********************************

*****  Reshape the years ***** 
local agecategories // to be adjusted if I want to loop in other stuff, relates to k in previous loop; adjust 0 to `var2' or something
local bins  // Setting up the bin
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12 total
foreach i of local categories{
foreach var of local sex{
local bins "`bins' mort_`var'_0_`i'_"
}
}
di "`bins'"
reshape long `bins' , i(fips) j(year)

***** Rename the months ***** 
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12 total
foreach i of local categories{
foreach var of local sex{
rename mort_`var'_0_`i'_ mort_`var'_`i'
}
}

*** reshaping and dropping totals to be in line with the relational database guidelines 
reshape long mort_tot_ mort_male_ mort_female_ , i(fips year) j(month)
drop *total

local variables "mort_tot_ mort_male_ mort_female_"
foreach i of local variables {
replace `i' ="0" if `i'=="-"
}
destring `variables', replace

***** save ***** 
* still have to save this
save "`path_intermediate'mort_tmf_total_97_10_monthly", replace




