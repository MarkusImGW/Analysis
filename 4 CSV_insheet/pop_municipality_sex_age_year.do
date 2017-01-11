***********************************************************************************

* File: pop_municipality_sex_age_year.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)

** Objective: The objective of this program is to create the datafiles for population for all years for different age groups and sex.
** The merger will happen in a different location as this a different step.

***********************************************************************************

*** Insheeting the Population data in levels ***

*** Note:  Challenge: Some have unknown (v15
// 2000-2013 has no unknowns, and goes to v14 = total
// 1996-1999 has an unknown population which is in the v14, so v15 is the new total population variable
// As a result, I split up these two groups

**************************
*** CREATING THE FILES ***
**************************

** Preliminaries ***
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

*****************************
******** INSHEET ************
*****************************

//Added this loop and changed tot to `var' everywhere
// Add tempfiles and merge it into one big file for population. Once I have this file, I can then do the decomposition by sex.

// This loops over 1) Gender 2) then years
// Then 

local gender "tot male female"
	foreach var of local gender{
	di "`var'"

******** 2000 - 2010 ********
local year 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010
** find and add 2010

foreach t in `year'{
	insheet using "`path_raw'age_`var'_`t'.csv", delimiter(";") clear
	drop if v5 == ""
/// Now to renaming the Variables (TD)
rename v1 id_municipality
format %60s id_municipality
drop if id_municipality == "MunicÌpio" | id_municipality == "Total"
rename v2 pop_`var'_00_01_`t'
rename v3 pop_`var'_01_04_`t'
rename v4 pop_`var'_05_09_`t'
rename v5 pop_`var'_10_14_`t'
rename v6 pop_`var'_15_19_`t' 
rename v7 pop_`var'_20_29_`t' 
rename v8 pop_`var'_30_39_`t'
rename v9 pop_`var'_40_49_`t'
rename v10 pop_`var'_50_59_`t'
rename v11 pop_`var'_60_69_`t'
rename v12 pop_`var'_70_79_`t'
rename v13 pop_`var'_80_inf_`t'
rename v14 pop_`var'_total_`t'

/// Giving lables (TD)
label variable pop_`var'_00_01 "0-1"
label variable pop_`var'_01_04 "1-4"
label variable pop_`var'_05_09 "5-9"
label variable pop_`var'_10_14 "10-14"
label variable pop_`var'_15_19 "15-19"
label variable pop_`var'_20_29 "20-29"
label variable pop_`var'_30_39 "30-39"
label variable pop_`var'_40_49 "40-49"
label variable pop_`var'_50_59 "50-59"
label variable pop_`var'_60_69 "60-69"
label variable pop_`var'_70_79 "70-79"
label variable pop_`var'_80_inf "80+"
label variable pop_`var'_total "Total"

** Seems to have the same signs as the stata file from 

// Replacing the characters in the municipality names
replace id_municipality  = subinstr(id_municipality ,"Ì","i",.) // í
replace id_municipality  = subinstr(id_municipality ,"dos indios","dos Indios",.) //
** Interesting, no replacements here, indicating dos Indios is not in the sample or was coded differently.
replace id_municipality  = subinstr(id_municipality ,"Í","e",.) // ê
replace id_municipality  = subinstr(id_municipality ,"È","e",.) // é
replace id_municipality  = subinstr(id_municipality ,"„","a",.) // ã
replace id_municipality  = subinstr(id_municipality ,"·","a",.) // á
replace id_municipality  = subinstr(id_municipality ,"‚","a",.) // â
replace id_municipality  = subinstr(id_municipality ,"Ù","o",.) // ô
replace id_municipality  = subinstr(id_municipality ,"Û","o",.) // ó
replace id_municipality  = subinstr(id_municipality ,"X","o",.) // õ
replace id_municipality  = subinstr(id_municipality ," o"," X",.) // õ
replace id_municipality  = subinstr(id_municipality ,"-o","-X",.) // õ
replace id_municipality  = subinstr(id_municipality ,"˙","u",.) // ú
replace id_municipality  = subinstr(id_municipality ,"Á","c",.) // ç
replace id_municipality  = subinstr(id_municipality ,"¡","a",.) // á
replace id_municipality  = subinstr(id_municipality ,"ı","o",.) // o
replace id_municipality  = subinstr(id_municipality ," a"," A",.) // o
replace id_municipality  = subinstr(id_municipality ,"Õ","I",.) // Õ
replace id_municipality  = subinstr(id_municipality ,"'a","'A",.) //  
replace id_municipality  = subinstr(id_municipality ,"”","O",.) // Ó
replace id_municipality  = subinstr(id_municipality ,"¬","A",.) // Á
replace id_municipality  = subinstr(id_municipality ,"…","E",.) // É
replace id_municipality  = subinstr(id_municipality ,"do Carajas","dos Carajas",.) // É
** one place conversion of Pio IX// in line with eralier replacemnts
replace id_municipality  = subinstr(id_municipality ,"Pio Io","Pio IX",.) // IX
gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen municipality = substr(id_municipality, 8, .)
gen state_fips = substr(id_municipality, 1, 2) 
di "`path_intermediate'pop_`var'_allage_`t'"
save "`path_intermediate'pop_`var'_allage_`t'", replace
** // why is this one here? // cap noi erase "`path_intermediate'pop_`var_allage_`t''" 

}

*****************************
******** 1996 - 1999 ******** 
*****************************

local year 1996 1997 1998 1999
** find and add 2010
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

foreach t in `year'{
insheet using "`path_raw'age_`var'_`t'.csv", delimiter(";") clear
drop if v5 == ""
/// Renaming the Variables (TD)
rename v1 id_municipality
format %60s id_municipality
drop if id_municipality == "MunicÌpio" | id_municipality == "Total"
rename v2 pop_`var'_00_01_`t'
rename v3 pop_`var'_01_04_`t'
rename v4 pop_`var'_05_09_`t'
rename v5 pop_`var'_10_14_`t'
rename v6 pop_`var'_15_19_`t' 
rename v7 pop_`var'_20_29_`t' 
rename v8 pop_`var'_30_39_`t'
rename v9 pop_`var'_40_49_`t'
rename v10 pop_`var'_50_59_`t'
rename v11 pop_`var'_60_69_`t'
rename v12 pop_`var'_70_79_`t'
rename v13 pop_`var'_80_inf_`t'
** HERE is the adjustment
rename v14 pop_`var'_unkown_`t'
rename v15 pop_`var'_total_`t'
*rename v14 Unknown

/// Giving lables (TD)
label variable pop_`var'_00_01 "0-1"
label variable pop_`var'_01_04 "1-4"
label variable pop_`var'_05_09 "5-9"
label variable pop_`var'_10_14 "10-14"
label variable pop_`var'_15_19 "15-19"
label variable pop_`var'_20_29 "20-29"
label variable pop_`var'_30_39 "30-39"
label variable pop_`var'_40_49 "40-49"
label variable pop_`var'_50_59 "50-59"
label variable pop_`var'_60_69 "60-69"
label variable pop_`var'_70_79 "70-79"
label variable pop_`var'_80_inf "80+"
label variable pop_`var'_total "Total"

** Seems to have the same signs as the stata file from 
replace id_municipality  = subinstr(id_municipality ,"Ì","i",.) // í
replace id_municipality  = subinstr(id_municipality ,"dos indios","dos Indios",.) //
** Interesting, no replacements here, indicating dos Indios is not in the sample or was coded differently.
replace id_municipality  = subinstr(id_municipality ,"Í","e",.) // ê
replace id_municipality  = subinstr(id_municipality ,"È","e",.) // é
replace id_municipality  = subinstr(id_municipality ,"„","a",.) // ã
replace id_municipality  = subinstr(id_municipality ,"·","a",.) // á
replace id_municipality  = subinstr(id_municipality ,"‚","a",.) // â
replace id_municipality  = subinstr(id_municipality ,"Ù","o",.) // ô
replace id_municipality  = subinstr(id_municipality ,"Û","o",.) // ó
replace id_municipality  = subinstr(id_municipality ,"X","o",.) // õ
replace id_municipality  = subinstr(id_municipality ," o"," X",.) // õ
replace id_municipality  = subinstr(id_municipality ,"-o","-X",.) // õ
replace id_municipality  = subinstr(id_municipality ,"˙","u",.) // ú
replace id_municipality  = subinstr(id_municipality ,"Á","c",.) // ç
replace id_municipality  = subinstr(id_municipality ,"¡","a",.) // á
replace id_municipality  = subinstr(id_municipality ,"ı","o",.) // o
replace id_municipality  = subinstr(id_municipality ," a"," A",.) // o
replace id_municipality  = subinstr(id_municipality ,"Õ","I",.) // Õ
replace id_municipality  = subinstr(id_municipality ,"'a","'A",.) //  
replace id_municipality  = subinstr(id_municipality ,"”","O",.) // Ó
replace id_municipality  = subinstr(id_municipality ,"¬","A",.) // Á
replace id_municipality  = subinstr(id_municipality ,"…","E",.) // É
replace id_municipality  = subinstr(id_municipality ,"do Carajas","dos Carajas",.) // É
** one place conversion of Pio IX// in line with eralier replacemnts
replace id_municipality  = subinstr(id_municipality ,"Pio Io","Pio IX",.) // IX
gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen municipality = substr(id_municipality, 8, .)
gen state_fips = substr(id_municipality, 1, 2) 
// Replacing no ages with zero
/*
replace pop_`var'_00_01 = "0" if pop_`var'_00_01 =="-"
replace pop_`var'_80_inf = "0" if pop_`var'_80_inf =="-"
ds
destring `r(varlist)', replace
*/

save "`path_intermediate'pop_`var'_allage_`t'", replace
} // end of the year 1996-1999 loop
} // end of the gender loop


******* Creating the merge for all years and total, male and female ********

use `path_intermediate'pop_tot_allage_2009 , clear
** population in municipalities in 2009

********* Merge from 1997, 1996 has a lot of changes *********
** start with 2009
local year 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009
local gender "tot male female"
foreach var of local gender{
	foreach t in `year'{
	di `t'
	merge 1:1 fips using "`path_intermediate'pop_`var'_allage_`t'"
	drop if _merge == 1 | _merge == 2
	drop _merge
*rename _merge merge_`var'_`t'
	}
}

drop *_unkown* // drop the unknown categories

*******************************************
***** Constructing the age categories *****
*******************************************

**** OBTAIN BRAKEDOWN BY AGE HERE  ***** 
*keep fips municipality state_fips id_municipality


***** create month variables ***** 
// on all variables: tot_00_01 not replaced, male_80_inf no replace, female_80_inf no replace

// Change the "-"s to 0's.

ds
local list `r(varlist)'
foreach i of local list{
replace `i' = "0" if `i' == "-"
}

// Destring the string variables
ds
destring `r(varlist)', replace

// Converting fips to a string here for a later merge with the other files
gen new = string(fips)
gen new2 = string(state_fips)
drop fips state_fips
rename new fips
rename new2 state_fips

****** CREATING AGE-BINS *********

** looping over years and gender to create the age bins 
local gender "tot male female"
foreach var of local gender{
		foreach year of numlist 1997(1)2009{
		gen pop_`var'_01_20_`year' = pop_`var'_01_04_`year' + pop_`var'_05_09_`year' + pop_`var'_10_14_`year' + pop_`var'_15_19_`year' 
		gen pop_`var'_20_40_`year' = pop_`var'_20_29_`year' + pop_`var'_30_39_`year' 
		gen pop_`var'_40_60_`year' = pop_`var'_40_49_`year' + pop_`var'_50_59_`year' 
		gen pop_`var'_60_80_`year' = pop_`var'_60_69_`year' + pop_`var'_70_79_`year' 
		}
}

****** CREATING MONTH-VARIABLES *********

***** LOOP to create the month variables
// LOOP: This creates the month variables by linearly interpolating among year variables.
// This loop just takes the the total variable.

local gender "tot male female"
local age_bins total 00_01 01_20 20_40 40_60 60_80 80_inf
** where to insert this local

foreach var of local gender{
	foreach i of numlist 1(1)12{
	foreach age of local age_bins{
		foreach year of numlist 1997(1)2008{
		local j = `year' + 1
		gen pop_`var'_`age'_`i'_`year' = ((12-`i')/12) * pop_`var'_`age'_`year' + (`i'/12) * pop_`var'_total_`j'
		}
	gen pop_`var'_`age'_`i'_2009 = pop_`var'_`age'_2009 // 2009 as end year
	}
	} 
}


*******************************************
***** Reshaping to Year-Month level unit of observation *****
*******************************************

*****  Reshape to get years in a variable ***** 
// Original code, getting all the totals

local bins  // Setting up the bin
local gender "tot male female"
local age_bins "total 00_01 01_20 20_40 40_60 60_80 80_inf"
local categories "1 2 3 4 5 6 7 8 9 10 11 12"
foreach i of local categories{
	foreach age of local age_bins{
		foreach var of local gender{
		local bins "`bins' pop_`var'_`age'_`i'_"
		}
	}
}
di "`bins'"
reshape long `bins' , i(fips) j(year)


local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009
local bins
foreach var of local years{
		local bins "`bins' *_`var'"
		}
di "`bins'"
drop `bins'

***** Rename the months to get rid of the _ at the end, to facilitate the reshape in the next step***** 
local gender "tot male female"
local age_bins total 00_01 01_20 20_40 40_60 60_80 80_inf
local categories 1 2 3 4 5 6 7 8 9 10 11 12
foreach i of local categories{
	foreach age of local age_bins{
	foreach var of local gender{
	rename pop_`var'_`age'_`i'_ pop_`var'_`age'_`i'
	}
	}
}

/*
original code
local gender "tot male female"
local categories 1 2 3 4 5 6 7 8 9 10 11 12 total
foreach i of local categories{
foreach var of local gender{
rename pop_`var'_`i'_ pop_`var'_`i'
}
}
*/

*** reshaping and dropping totals to be in line with the relational database guidelines 
local bins  // Setting up the bin
local gender "tot male female"
local age_bins "total 00_01 01_20 20_40 40_60 60_80 80_inf"
foreach age of local age_bins{
		foreach var of local gender{
		local bins "`bins' pop_`var'_`age'_"
		}
}
di "`bins'"

reshape long `bins' , i(fips year) j(month)
// original was pop_tot_ pop_male_ pop_female_
// drop *total ; This got deleted before this 
destring fips, replace


***** save ***** 
// changed the path name and added ages
save "`path_intermediate'pop_tmf_total_97_09_monthly_ages", replace

