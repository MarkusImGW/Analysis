/*
Options; Cha
local path /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/
use "`path'/UDEL-temp.dta", clear
// this UDEL-temp file has changed from the earlier conversion
*/ 
local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
use "`path'/UDEL-precip.dta", clear

/// testing reshape
local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
*merge 1:1 NAME_1_NAME_2 year using "`path'/UDEL-temp.dta"
merge 1:1 NAME_1_NAME_2 year using "`path'BEST_tavg_BIN_35C_inf.dta" 
drop _merge 
// merge does not occur for years 48-50

local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
forval i=0/34{
local j = `i'+1
merge 1:1 NAME_1_NAME_2 year using "`path'BEST_tavg_BIN_`i'C_`j'C.dta" 
drop _merge
}
// all good to go, just takes a while

local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
**then the special ones
forval i=0/6{
local j = 5*`i'
merge 1:1 NAME_1_NAME_2 year using "`path'NCEP-dd`j'.dta" 
drop _merge 
}


** Other data-set was already converted, else go back and convert it again.


****************************
*** testing reshape wide ***
****************************
local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
use "`path'/UDEL-temp.dta", clear
drop *crop *area
keep if year>1996
// Still key to drop the duplicates
duplicates report NAME_1_NAME_2 year
duplicates drop NAME_1_NAME_2 year, force
// Now reshape works, notice that I do it in pop
reshape wide *pop, i(NAME_1_NAME_2) j(year)

