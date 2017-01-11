***********************************************************************************

* File: rural_insheet
** contains the insheet and reshape for rural and urban
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)

***********************************************************************************

*** CREATING THE FILES ***
** Preliminaries ***
clear all
cd "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/"
local path_raw 
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

** 2010 ** 
// creating the temporal file and insheeting the data
tempfile rural_2010 
insheet using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/rural_2010.csv", delimiter(";") clear
// renaming the variables
rename v1 id_municipality
rename v2 urban_2010
rename v3 rural_2010
rename v4 total_2010

drop in 1/4 // dropping the first 3 blank lines and the names of the variable
drop in 5567/5582 // deleting the information on the bottom

// Creating the municipality, state and macro region identifiers
gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
replace fips = "Total" if fips == ""

// saving a temporary file for the merge
save `rural_2010'

** 2000 **
insheet using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/rural_2000.csv", delimiter(";") clear
rename v1 id_municipality
rename v2 urban_2000
rename v3 rural_2000
rename v4 total_2000

drop in 1/4 // dropping the first 3 blank lines and the names of the variable
drop in 5509/5524 // deleting the information, starts lower now

gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
replace fips = "Total" if fips == ""
merge 1:1 fips using `rural_2010'
** 58 municipalities unmatched out of 5566
drop if _merge==2


//destring the variables
// Change the "-"s to 0's.
drop _merge
ds
local list `r(varlist)'
foreach i of local list{
replace `i' = "0" if `i' == "-"
}
destring, replace

// create the data for each municipality; keep 2000 for 1996-2000, and 2010 for years afterwards
// Use interpolation for years in between

** 1997-1999
foreach i of numlist 7(1)9{
di "`i'"
gen urban_199`i' =  urban_2000 
gen rural_199`i' =  rural_2000
gen total_199`i' =  total_2000 
}

** 2000-2010
foreach i of numlist 1(1)9{
di "`i'"
gen urban_200`i' = ((10-`i')/10) * urban_2000 + (`i'/10) * urban_2010
gen rural_200`i' = ((10-`i')/10) * rural_2000 + (`i'/10) * rural_2010
gen total_200`i' = ((10-`i')/10) * total_2000 + (`i'/10) * total_2010
}
** 2011-2012
foreach i of numlist 11(1)12{
gen urban_20`i' = urban_2010
gen rural_20`i' = rural_2010
gen total_20`i' = total_2010
}

// Create the shares for the population

foreach i of numlist 7(1)9{
	gen shares_rural_199`i' = rural_2000/total_2000
}
foreach i of numlist 0(1)9{
	gen shares_rural_200`i' = rural_200`i'/total_200`i'
}
foreach i of numlist 10(1)12{
	gen shares_rural_20`i' = rural_2000/total_2000
}


****** RESPAPE 

local bins 
local categories urban rural total shares_rural
foreach i of local categories{
	local bins `bins' `i'_
}
di "`bins'"

reshape long `bins' , i(fips) j(year)

save "`path_intermediate'rural_97_2012_yearly", replace

// Creating months
local bins 
local categories urban rural total shares_rural
foreach i of local categories{
	foreach j of numlist 1(1)12{
	gen `i'_`j'= `i'_
	}
}
drop urban_ rural_ total_ shares_rural_

local bins 
local categories urban rural total shares_rural
foreach i of local categories{
	local bins `bins' `i'_
}
di "`bins'"
reshape long `bins' , i(fips year) j(month)

**
save "`path_intermediate'rural_97_2012", replace


// Note: when I merge with year and month, the drop command is only going to drop those observations for months that are not in there
// Does it kick out a municipality that isn't found? 
// An observation 

/*


***********************************************************************************

* File: pop_municipality_sex_age_year.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)

***********************************************************************************

*** CREATING THE FILES ***
** Preliminaries ***
clear all
local path_raw 
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

** 2010 ** 
// creating the temporal file and insheeting the data
tempfile rural_2010 
insheet using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/rural_2010.csv", delimiter(";") clear
// renaming the variables
rename v1 id_municipality
rename v2 urban_2010
rename v3 rural_2010
rename v4 total_2010

drop in 1/4 // dropping the first 3 blank lines and the names of the variable
drop in 5567/5582 // deleting the information on the bottom

// Creating the municipality, state and macro region identifiers
gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
replace fips = "Total" if fips == ""

// saving a temporary file for the merge
save `rural_2010'

** 2000 **
insheet using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/rural_2000.csv", delimiter(";") clear
rename v1 id_municipality
rename v2 urban_2000
rename v3 rural_2000
rename v4 total_2000

drop in 1/4 // dropping the first 3 blank lines and the names of the variable
drop in 5509/5524 // deleting the information, starts lower now

gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
replace fips = "Total" if fips == ""
merge 1:1 fips using `rural_2010'
** 58 municipalities unmatched out of 5566
drop if _merge==2


//destring the variables
// Change the "-"s to 0's.
drop _merge
ds
local list `r(varlist)'
foreach i of local list{
replace `i' = "0" if `i' == "-"
}
destring, replace

// creation of interpolation of the variables
** 1997-1999
foreach i of numlist 7(1)9{
di "`i'"
gen urban_199`i' =  urban_2000 
gen rural_199`i' =  rural_2000
gen total_199`i' =  total_2000 
}

** 2000-2010
foreach i of numlist 1(1)9{
di "`i'"
gen urban_200`i' = ((10-`i')/10) * urban_2000 + (`i'/10) * urban_2010
gen rural_200`i' = ((10-`i')/10) * rural_2000 + (`i'/10) * rural_2010
gen total_200`i' = ((10-`i')/10) * total_2000 + (`i'/10) * total_2010
}
** 2011-2012
foreach i of numlist 10(1)12{
gen urban_20`i' = urban_2010
gen rural_20`i' = rural_2010
gen total_20`i' = total_2010
}

foreach i of numlist 7(1)9{
	gen shares_rural_199`i' = rural_2000/total_2000
}
foreach i of numlist 1(1)9{
	gen shares_rural_200`i' = rural_200`i'/total_200`i'
}
foreach i of numlist 10(1)12{
	gen shares_rural_20`i' = rural_2000/total_2000
}



gen dummy = 1 if total_2001>60000
replace dummy = 0 if total_2001<60000
sort dummy
drop if id_municipality == "Total"
generate sum_large=sum(total_2001) if total_2001>60000
sum sum_large // 104 million people 
generate sum_small=sum(total_2001) if total_2001<60000
sum sum_small // 67.4 million people in the smaller municipalities

*hist shares_rural_2001 if total_2001<60000, freq title("Share of rural and urban population" "in 2001 across Small Municipalities" "<60000")

// small municipalities <40.000
hist total_2001 if total_2001<60000, freq
graph export "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/histogram_municipality_pop_2001.pdf", replace

count if total_2001<20000 // Still 4000!!
count if total_2001<10000 // Still 2627!!

// small municipalities <5.000
hist shares_rural_2001 if total_2001<5000, freq title("Share of rural and urban population" "in 2001 across Small Municipalities" "<5000")
graph export "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/histogram_shares_2001_small_5.pdf", replace

// small municipalities <15.000
hist shares_rural_2001 if total_2001<15000, freq title("Share of rural and urban population" "in 2001 across Small Municipalities" "<15000")
graph export "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/histogram_shares_2001_small_15.pdf", replace

// small municipalities <120.000
hist shares_rural_2001 if total_2001<120000, freq title("Share of rural and urban population" "in 2001 across Small Municipalities" "<120000")
graph export "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/histogram_shares_2001_small_120.pdf", replace

// large municipalities
hist shares_rural_2001 if total_2001>120000, freq title("Share of rural and urban population" "in 2001 across Large Municipalities" ">120000" "187 Municipalities")
graph export "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/histogram_shares_2001_large_120.pdf", replace
count if total_2001>120000 // 187



***************
**** 1991 *****
***************

** 1991 **
insheet using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/rural_1991.csv", delimiter(";") clear
rename v1 id_municipality
rename v2 urban_1991
rename v3 rural_1991
rename v4 total_1991

drop in 1/4 // dropping the first 3 blank lines and the names of the variable
drop in 4493/4508 // deleting the information, starts lower now

