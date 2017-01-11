***********************************************************************************

* File: mort_tmf_causes_97_10_monthly.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)

** This file computes the causes of death for total, male and female


***********************************************************************************

********* Preliminaries *********
global mypath  /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

// key variable
local causes_death 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local age 0 
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
di "We are at `i'"
if `i' ==0{
** LOOP OVER AGE **
///Originally age, which I change to CAUSE OF DEATH LOOP
// Change all k's to c's
foreach c of local causes_death{
 	di "`year'_`i'_`c'"
	tempfile mort_tot_`c'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_`c'_0_`i'_0.csv", clear
	******** IMPORTANT: HERE I AM DROPPING THE MONTHS!!!!! ********
	cap noi rename total mort_tot_cause`c'_0_`year'
	cap noi rename janeiro mort_tot_cause`c'_1_`year' 
	cap noi rename fevereiro mort_tot_cause`c'_2_`year'
	cap noi rename marccedilo mort_tot_cause`c'_3_`year' 
	cap noi rename abril mort_tot_cause`c'_4_`year'
	cap noi rename maio mort_tot_cause`c'_5_`year'
	cap noi rename junho mort_tot_cause`c'_6_`year'
	cap noi rename julho mort_tot_cause`c'_7_`year'
	cap noi rename agosto mort_tot_cause`c'_8_`year'
	cap noi rename setembro mort_tot_cause`c'_9_`year'
	cap noi rename outubro mort_tot_cause`c'_10_`year'
	cap noi rename novembro mort_tot_cause`c'_11_`year'
	cap noi rename dezembro mort_tot_cause`c'_12_`year'
	cap noi save `mort_tot_`c'_`year''
}
}

else if `i' ==1{
foreach c of local causes_death{
 	di "`year'_`i'_`c'"
	tempfile mort_male_`c'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_`c'_0_`i'_0.csv", clear
	cap noi rename total mort_male_cause`c'_0_`year'
	cap noi rename janeiro mort_male_cause`c'_1_`year' 
	cap noi rename fevereiro mort_male_cause`c'_2_`year'
	cap noi rename marccedilo mort_male_cause`c'_3_`year' 
	cap noi rename abril mort_male_cause`c'_4_`year'
	cap noi rename maio mort_male_cause`c'_5_`year'
	cap noi rename junho mort_male_cause`c'_6_`year'
	cap noi rename julho mort_male_cause`c'_7_`year'
	cap noi rename agosto mort_male_cause`c'_8_`year'
	cap noi rename setembro mort_male_cause`c'_9_`year'
	cap noi rename outubro mort_male_cause`c'_10_`year'
	cap noi rename novembro mort_male_cause`c'_11_`year'
	cap noi rename dezembro mort_male_cause`c'_12_`year'
	cap noi save `mort_male_`c'_`year''
}
}

else if `i' ==2{
foreach c of local causes_death{
 	di "`year'_`i'_`c'"
	tempfile mort_female_`c'_`year'
	capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_`c'_0_`i'_0.csv", clear
	cap noi rename total mort_female_cause`c'_0_`year'
	cap noi rename janeiro mort_female_cause`c'_1_`year' 
	cap noi rename fevereiro mort_female_cause`c'_2_`year'
	cap noi rename marccedilo mort_female_cause`c'_3_`year' 
	cap noi rename abril mort_female_cause`c'_4_`year'
	cap noi rename maio mort_female_cause`c'_5_`year'
	cap noi rename junho mort_female_cause`c'_6_`year'
	cap noi rename julho mort_female_cause`c'_7_`year'
	cap noi rename agosto mort_female_cause`c'_8_`year'
	cap noi rename setembro mort_female_cause`c'_9_`year'
	cap noi rename outubro mort_female_cause`c'_10_`year'
	cap noi rename novembro mort_female_cause`c'_11_`year'
	cap noi rename dezembro mort_female_cause`c'_12_`year'
	cap noi save `mort_female_`c'_`year''
}
}
}
********************************************************
****** setting up the basesheet for the merge **********
********************************************************
capture noi insheet using "/Users/arvidviaene/Documents/output2/output/0_0_0_`t'_0_0_0_0.csv", clear
	rename total mort_tot_cause0_0_`year'
	rename janeiro mort_tot_cause0_1_`year' 
	rename fevereiro mort_tot_cause0_2_`year'
	rename marccedilo mort_tot_cause0_3_`year' 
	rename abril mort_tot_cause0_4_`year'
	rename maio mort_tot_cause0_5_`year'
	rename junho mort_tot_cause0_6_`year'
	rename julho mort_tot_cause0_7_`year'
	rename agosto mort_tot_cause0_8_`year'
	rename setembro mort_tot_cause0_9_`year'
	rename outubro mort_tot_cause0_10_`year'
	rename novembro mort_tot_cause0_11_`year'
	rename dezembro mort_tot_cause0_12_`year'
*******************
***** Merging ****
*******************
************************
***** Merging total ****
************************

foreach var of local sex{
di "`var'"
foreach c of local causes_death{
	capture noi merge 1:1 municiacutepio using `mort_`var'_`c'_`year''
	capture noi drop _merge
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

** Fill up with zeros for - and nothing registered (when no municipality has this category)
** Then destring to get all to numeric for appending later on
ds
local list `r(varlist)'
foreach i of local list{
cap noi replace `i' = "0" if `i' == "-" | `i' == "" 
}
destring, replace

di "end loop `i'"
save "`path_intermediate'mort_tmf_cause_bins_`year'", replace
}
*** ENDED HERE ****


****************************************************
******* Creation of year and then APPEND ***********
****************************************************
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_intermediate'mort_tmf_cause_bins_1999", clear

local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010
foreach year of local years{
use "`path_intermediate'mort_tmf_cause_bins_`year'", clear
** Reshaping the files
local bins 
local sex "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12 0
local cause_bins 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22

foreach i of local categories{
	foreach cause of local cause_bins{
		foreach var of local sex{
		local bins "`bins' mort_`var'_cause`cause'_`i'_"
		}
	}
}
di "`bins'"
reshape long `bins' , i(fips) j(year)


drop if id_municipality == "Total" // drop total for the whole year 
save "`path_intermediate'mort_tmf_cause_bins_`year'", replace
}

** Appending 
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_intermediate'mort_tmf_cause_bins_1997", clear
local years 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010
foreach year of local years{
di "`year'"
append using "`path_intermediate'mort_tmf_cause_bins_`year'"
}

*** SAVING 
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
save "`path_intermediate'mort_tmf_total_causes_97_10_year_month", replace

******************************
******************************
******************************


**** DATA-OPERATIONS ****
** insheeting the data anew
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_intermediate'mort_tmf_total_causes_97_10_year_month", clear

** creating a list of locals to collapse the data
local placeholder 
foreach i of numlist 0(1)20{
local placeholder "`placeholder' mort_tot_cause`i'_0_ mort_male_cause`i'_0_ mort_female_cause`i'_0_"
di "`placeholder'"
}
** collapsing the data to get the yearly totals
collapse (sum) "`placeholder'", by(year)

** Creating the percentages of deaths relative to the toal
* generating the placeholder to automate the loops
* generating the percentages for male, female and total
local sex tot male female
foreach j of local sex{
di "`j'
	local placeholder 
	foreach i of numlist 1(1)20{
	local placeholder "`placeholder' mort_`j'_cause`i'_0_"
	}
	foreach i of local placeholder{
	gen perc_`i'= `i'/mort_`j'_cause0_0_
	}
}
** Renaming the absolute # of deaths according to the CID
/*
rename mort_tot_cause0_0_ Total
rename mort_tot_cause1_0_ Infections
rename mort_tot_cause2_0_ Neoplasms
rename mort_tot_cause3_0_ Blood
rename mort_tot_cause4_0_ Endocrine
rename mort_tot_cause5_0_ Mental
rename mort_tot_cause6_0_ Nervous_System
rename mort_tot_cause7_0_ Eye 
rename mort_tot_cause8_0_ Ear
rename mort_tot_cause9_0_ Circulatory
rename mort_tot_cause10_0_ Respiratory
rename mort_tot_cause11_0_ Digestive
rename mort_tot_cause12_0_ Skin
rename mort_tot_cause13_0_ Musculosketal
rename mort_tot_cause14_0_ Genitourinary
rename mort_tot_cause15_0_ Pregnancy
rename mort_tot_cause16_0_ Perinatal
rename mort_tot_cause17_0_ Congenital
rename mort_tot_cause18_0_ Abnormal
rename mort_tot_cause19_0_ Injury_Poisoning
rename mort_tot_cause20_0_ External_causes
rename mort_tot_cause21_0_ Health_services
*/

** Naming the percentages of the CID

rename perc_mort_tot_cause1_0_ Infections
rename perc_mort_tot_cause2_0_ Neoplasms
rename perc_mort_tot_cause3_0_ Blood
rename perc_mort_tot_cause4_0_ Endocrine
rename perc_mort_tot_cause5_0_ Mental
rename perc_mort_tot_cause6_0_ Nervous_System
rename perc_mort_tot_cause7_0_ Eye 
rename perc_mort_tot_cause8_0_ Ear
rename perc_mort_tot_cause9_0_ Circulatory
rename perc_mort_tot_cause10_0_ Respiratory
rename perc_mort_tot_cause11_0_ Digestive
rename perc_mort_tot_cause12_0_ Skin
rename perc_mort_tot_cause13_0_ Musculosketal
rename perc_mort_tot_cause14_0_ Genitourinary
rename perc_mort_tot_cause15_0_ Pregnancy
rename perc_mort_tot_cause16_0_ Perinatal
rename perc_mort_tot_cause17_0_ Congenital
rename perc_mort_tot_cause18_0_ Abnormal
rename perc_mort_tot_cause19_0_ Injury_Poisoning
rename perc_mort_tot_cause20_0_ External_causes

rename perc_mort_male_cause1_0_ M_Infections
rename perc_mort_male_cause2_0_ M_Neoplasms
rename perc_mort_male_cause3_0_ M_Blood
rename perc_mort_male_cause4_0_ M_Endocrine
rename perc_mort_male_cause5_0_ M_Mental
rename perc_mort_male_cause6_0_ M_Nervous_System
rename perc_mort_male_cause7_0_ M_Eye 
rename perc_mort_male_cause8_0_ M_Ear
rename perc_mort_male_cause9_0_ M_Circulatory
rename perc_mort_male_cause10_0_ M_Respiratory
rename perc_mort_male_cause11_0_ M_Digestive
rename perc_mort_male_cause12_0_ M_Skin
rename perc_mort_male_cause13_0_ M_Musculosketal
rename perc_mort_male_cause14_0_ M_Genitourinary
rename perc_mort_male_cause15_0_ M_Pregnancy
rename perc_mort_male_cause16_0_ M_Perinatal
rename perc_mort_male_cause17_0_ M_Congenital
rename perc_mort_male_cause18_0_ M_Abnormal
rename perc_mort_male_cause19_0_ M_Injury_Poisoning
rename perc_mort_male_cause20_0_ M_External_causes

rename perc_mort_female_cause1_0_ F_Infections
rename perc_mort_female_cause2_0_ F_Neoplasms
rename perc_mort_female_cause3_0_ F_Blood
rename perc_mort_female_cause4_0_ F_Endocrine
rename perc_mort_female_cause5_0_ F_Mental
rename perc_mort_female_cause6_0_ F_Nervous_System
rename perc_mort_female_cause7_0_ F_Eye 
rename perc_mort_female_cause8_0_ F_Ear
rename perc_mort_female_cause9_0_ F_Circulatory
rename perc_mort_female_cause10_0_ F_Respiratory
rename perc_mort_female_cause11_0_ F_Digestive
rename perc_mort_female_cause12_0_ F_Skin
rename perc_mort_female_cause13_0_ F_Musculosketal
rename perc_mort_female_cause14_0_ F_Genitourinary
rename perc_mort_female_cause15_0_ F_Pregnancy
rename perc_mort_female_cause16_0_ F_Perinatal
rename perc_mort_female_cause17_0_ F_Congenital
rename perc_mort_female_cause18_0_ F_Abnormal
rename perc_mort_female_cause19_0_ F_Injury_Poisoning
rename perc_mort_female_cause20_0_ F_External_causes


*** graph of the major causes of death
twoway (line Infections year)|| (line External year) || (line Abnormal year) || (line Respiratory year) ///
(line Circulatory year) || (line Endocrine year) || (line Neoplasms year) || (line Mental year), title("Major Causes of Death")
* severe decline in abnormal; How come??

** Male vs female
twoway (line M_Infections year)|| (line M_External year) || (line M_Abnormal year) || (line M_Respiratory year) ///
(line M_Circulatory year) || (line M_Neoplasms year) || (line M_Mental year) ///
(line F_Infections year)|| (line F_External year) || (line F_Abnormal year) || (line F_Respiratory year) ///
(line F_Circulatory year) || (line F_Neoplasms year) || (line F_Mental year), title("Major Causes of Death for Men and Women")

** huge difference in the externality conditions: which is assault, accidents,...
twoway (line M_Infections year)|| (line M_External year) || (line M_Abnormal year) || (line M_Respiratory year) ///
(line F_Infections year)|| (line F_External year) || (line F_Abnormal year) || (line F_Respiratory year) 

** second comparison
twoway (line M_Circulatory year) || (line M_Neoplasms year) || (line M_Mental year) ///
(line F_Circulatory year) || (line F_Neoplasms year) || (line F_Mental year), title("Major Causes of Death for Men and Women")

** Test if the percentages sum up to one, which they do
local causes_death "Total Infections Neoplasms Blood Endocrine Mental Nervous_System Eye Ear Circulatory Respiratory Digestive Skin Musculosketal Genitourinary Pregnancy Perinatal Congenital Abnormal Injury_Poisoning External_causes Health_services"
di "`causes_death'"
foreach i of local causes_death{
di "`i'"
}
local causes_death2 "Infections Neoplasms Blood Endocrine Mental Nervous_System Eye Ear Circulatory Respiratory Digestive Skin Musculosketal Genitourinary Pregnancy Perinatal Congenital Abnormal Injury_Poisoning External_causes "
egen rowtotal = rowtotal(`causes_death2') 


