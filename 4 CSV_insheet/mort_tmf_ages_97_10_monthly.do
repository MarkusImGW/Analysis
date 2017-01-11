***********************************************************************************

* File: mort_tmf_ages_97_10_monthly.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create a dataset for municipalities and brazil for the year 2009
for all categories

Structure:
1. Insheet all data and get ready for merge
2. Merge between years
3. Rename and change characters
4. Save the data
*/
***********************************************************************************

********* Preliminaries *********
global mypath  /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

** The downloaded data comes in several files with each one year for a certain cut
** The locals will therefore take on these values to insheet the data.

local age 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local gender 0 1 2
local sex "tot male female"
local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010

********* INSHEETING THE DATA *********

// The program is first going to take one year, insheeting all the required data within that year and merging it
// In the second loop, gender is used, while age comes in the third loop
// Using tempfiles, all these results are saved and then merged at the end of the year-loop
// After the merges within the year, the program will save the year as a data-set
// These different years will then be merged in a different loop.
foreach year in `years'{
tempfile mort_tmf_allage_`year' // This tempfile sets up the data to be saved
local t = 2013 - `year' // Create a t-variable to get the naming convention of the saved files from the scraping.

******** GENDER IF ELSE  ******
foreach i in `gender'{ 
// Starting the gender loop. I use an if-else construction to denote the category of each gender.
// Note that I rename it manually for now to mort_gender_tot_... 
// Might want to contemplate rewriting this loop a lot more efficiently with a different construction; Brainstorm

di `We are at i'
if `i' ==0{ 
** LOOP OVER AGE **
foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_tot_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_tot_`k'_total_`year'
	cap noi rename janeiro mort_tot_`k'_1_`year' 
	cap noi rename fevereiro mort_tot_`k'_2_`year'
	cap noi rename marccedilo mort_tot_`k'_3_`year' 
	cap noi rename abril mort_tot_`k'_4_`year'
	cap noi rename maio mort_tot_`k'_5_`year'
	cap noi rename junho mort_tot_`k'_6_`year'
	cap noi rename julho mort_tot_`k'_7_`year'
	cap noi rename agosto mort_tot_`k'_8_`year'
	cap noi rename setembro mort_tot_`k'_9_`year'
	cap noi rename outubro mort_tot_`k'_10_`year'
	cap noi rename novembro mort_tot_`k'_11_`year'
	cap noi rename dezembro mort_tot_`k'_12_`year'
	save `mort_tot_`k'_`year''
	}
}

else if `i' ==1{
	foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_male_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_male_`k'_total_`year'
	cap noi rename janeiro mort_male_`k'_1_`year' 
	cap noi rename fevereiro mort_male_`k'_2_`year'
	cap noi rename marccedilo mort_male_`k'_3_`year' 
	cap noi rename abril mort_male_`k'_4_`year'
	cap noi rename maio mort_male_`k'_5_`year'
	cap noi rename junho mort_male_`k'_6_`year'
	cap noi rename julho mort_male_`k'_7_`year'
	cap noi rename agosto mort_male_`k'_8_`year'
	cap noi rename setembro mort_male_`k'_9_`year'
	cap noi rename outubro mort_male_`k'_10_`year'
	cap noi rename novembro mort_male_`k'_11_`year'
	cap noi rename dezembro mort_male_`k'_12_`year'
	save `mort_male_`k'_`year''
	}
}

else if `i' ==2{
	foreach k of numlist `age'{
 	di "`year'_`i'_`k'"
	tempfile mort_female_`k'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_`k'_`i'_0.csv", clear
	rename total mort_female_`k'_total_`year'
	cap noi rename janeiro mort_female_`k'_1_`year' 
	cap noi rename fevereiro mort_female_`k'_2_`year'
	cap noi rename marccedilo mort_female_`k'_3_`year' 
	cap noi rename abril mort_female_`k'_4_`year'
	cap noi rename maio mort_female_`k'_5_`year'
	cap noi rename junho mort_female_`k'_6_`year'
	cap noi rename julho mort_female_`k'_7_`year'
	cap noi rename agosto mort_female_`k'_8_`year'
	cap noi rename setembro mort_female_`k'_9_`year'
	cap noi rename outubro mort_female_`k'_10_`year'
	cap noi rename novembro mort_female_`k'_11_`year'
	cap noi rename dezembro mort_female_`k'_12_`year'
	save `mort_female_`k'_`year''
	}
} 
} // end of the gender loop

**********************************************************************
****** setting up the basesheet for the merge within a year for the files previously specified **********
**********************************************************************

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

foreach var of local sex{
	di "`var'"
	foreach k of numlist `age'{
		capture noi merge 1:1 municiacutepio using `mort_`var'_`k'_`year''
		drop _merge
	}
}

rename municiacutepio id_municipality // renaming to what the variable represents; The id of the municipality and its name
drop if id_municipality=="&" // this character is sometimes imported, so drop it.
cap noi drop ignorado // drop the unknown category

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

di "end loop"
// changed name here to age_bins

drop mort_female_4_* mort_male_4_* mort_tot_4_*
save "`path_intermediate'mort_tmf_age_bins_`year'", replace
}
****************************************************
******* Creation of year and then APPEND ***********
****************************************************
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010
foreach year of local years{
use "`path_intermediate'mort_tmf_age_bins_`year'", clear
** Reshaping the files
local bins 
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12 total
local age_bins 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
foreach i of local categories{
	foreach age of local age_bins{
		foreach var of local sex{
		local bins "`bins' mort_`var'_`age'_`i'_"
		}
	}
}
di "`bins'"
reshape long `bins' , i(fips) j(year)


drop if id_municipality == "Total" // drop total for the whole year 
save "`path_intermediate'mort_tmf_age_bins_`year'", replace
}

** Appending 
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_intermediate'mort_tmf_age_bins_1997", clear
local years 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010
foreach year of local years{
di "`year'"
append using "`path_intermediate'mort_tmf_age_bins_`year'"
}
drop mort_tot_4_*
****** ////// ******** //////


*****************************************
*******   RESHAPE to MONTHS    **********
*****************************************

***** Rename the months to get standard numeric formulation ***** 

local age_bins 0 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12 total
foreach i of local categories{
	foreach age of local age_bins{
		foreach var of local sex{
		rename mort_`var'_`age'_`i'_ mort_`var'_`age'_`i'
		}
	}
}

*** Drop total to get months in reshape: ADJUST HERE IF YOU WANT TOTALS
drop *_total

*** reshaping and dropping totals to be in line with the relational database guidelines 
** Stata does not reshape the large file. Theunit and for seperate age bins works, not seperated by gender,  so create a loop for each age category and then merge them
** use create - save - merge - create
// Creation of files
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local numbers 0 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
foreach i of local numbers{
di "`i'"
preserve
keep fips year id_municipality mort_tot_`i'_* mort_male_`i'_* mort_female_`i'_*
reshape long mort_tot_`i'_ mort_male_`i'_ mort_female_`i'_ , i(fips year) j(month)
save `path_intermediate'reshape_`i', replace
restore
}
// Merging of files
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local numbers 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
use `path_intermediate'reshape_0, clear
foreach i of local numbers {
merge 1:1 fips year month using `path_intermediate'reshape_`i'
drop _merge
}
** Has perfect merge as it should be 
// Erasing of files
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local numbers 0 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
foreach i of local numbers{
erase `path_intermediate'reshape_`i'.dta
}

***************************************

local age_bins 0 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local variables "tot male female"
foreach age of local age_bins{
	foreach i of local variables {
	di "mort_`i'_`age'_ "
		replace mort_`i'_`age'_ ="0" if mort_`i'_`age'_=="-"
		replace mort_`i'_`age'_ ="0" if mort_`i'_`age'_==""
	}
}
destring , replace

***** save ***** 
* still have to save this

//////
//Change Name
//////


// Renaming the variables:
local gender tot male female
foreach sex of local gender{
rename mort_`sex'_0_ mort_`sex'_total
rename mort_`sex'_1_ mort_`sex'_0_6d
rename mort_`sex'_2_ mort_`sex'_7_27d
rename mort_`sex'_3_ mort_`sex'_28_364d
rename mort_`sex'_5_ mort_`sex'_01_04
rename mort_`sex'_6_ mort_`sex'_05_09
rename mort_`sex'_7_ mort_`sex'_10_14
rename mort_`sex'_8_ mort_`sex'_15_19
rename mort_`sex'_9_ mort_`sex'_20_24
rename mort_`sex'_10_ mort_`sex'_25_29
rename mort_`sex'_11_ mort_`sex'_30_34
rename mort_`sex'_12_ mort_`sex'_35_39
rename mort_`sex'_13_ mort_`sex'_40_44
rename mort_`sex'_14_ mort_`sex'_45_49
rename mort_`sex'_15_ mort_`sex'_50_54
rename mort_`sex'_16_ mort_`sex'_55_59
rename mort_`sex'_17_ mort_`sex'_60_64
rename mort_`sex'_18_ mort_`sex'_65_69
rename mort_`sex'_19_ mort_`sex'_70_74
rename mort_`sex'_20_ mort_`sex'_75_79
rename mort_`sex'_21_ mort_`sex'_80_inf
rename mort_`sex'_22_ mort_`sex'_unknown
}

local gender tot male female
foreach sex of local gender{
gen mort_`sex'_00_01 = mort_`sex'_0_6d + mort_`sex'_7_27d + mort_`sex'_28_364d
gen mort_`sex'_01_20 = mort_`sex'_01_04 + mort_`sex'_05_09 + mort_`sex'_10_14 + mort_`sex'_15_19
gen mort_`sex'_20_40 = mort_`sex'_20_24 + mort_`sex'_25_29 + mort_`sex'_30_34 + mort_`sex'_35_39
gen mort_`sex'_40_60 = mort_`sex'_40_44 + mort_`sex'_45_49 + mort_`sex'_50_54 + mort_`sex'_55_59
gen mort_`sex'_60_80 = mort_`sex'_60_64 + mort_`sex'_65_69 + mort_`sex'_70_74 + mort_`sex'_75_79
}

local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
save "`path_intermediate'mort_tmf_total_ages_97_10_monthly", replace


******************** OTHER CODE ****************
***************
/*
use "`path_intermediate'mort_tmf_age_bins_2000", clear 
* mort_tot_4_1_ is byte in using data
// this is the unknown category below 1 year, so it is non-existent as no municipality might have unknown here. If just 1 municipality has this, then it will merge
local bytes "mort_tot_4_1_ mort_male_4_1_ mort_female_4_1_ mort_female_4_9_ mort_female_4_12_"
foreach byte of local bytes{
replace `byte'=0 if `byte'==.
gen x = string(`byte')
drop `byte'
rename x `byte'
save "`path_intermediate'mort_tmf_age_bins_2000", replace
}

***************

// DOING IT FOR TOTAL, does not work
keep fips year id_municipality mort_tot_*

local age_bins 0 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12
local bins
foreach i of local categories{
	foreach age of local age_bins{
		foreach var of local sex{
		local bins "`bins' mort_`var'_`age'_"
		}
	}
}
di "`bins'"
reshape long `bins', i(fips year) j(month)


***************
local age_bins 0 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12
local bins
foreach i of local categories{
	foreach age of local age_bins{
		foreach var of local sex{
		local bins "`bins' mort_`var'_`age'_"
		}
	}
}
di "`bins'"

reshape long `bins', i(fips year) j(month)






