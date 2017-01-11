/*
Options; Change path
local path /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/
use "`path'/UDEL-temp.dta", clear
// this UDEL-temp file has changed from the earlier conversion
*/ 
local path /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/
use "`path'/UDEL-precip.dta", clear
merge 1:1 NAME_1_NAME_2 year using "`path'UDEL-temp.dta"
drop _merge
merge 1:1 NAME_1_NAME_2 year using "`path'BEST_tavg_BIN_35C_Inf.dta" 
drop _merge
/// BIG DIFFERENCE, I got transformed into i!! 


// NCEP data
forval i=0/6{
local j = 5*`i'
merge 1:1 NAME_1_NAME_2 year using "`path'NCEP-dd`j'.dta" 
drop _merge 
}
// merge does not occur for years 48-50

//  BEST data
*local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
forval i=0/11{
local j = `i'+1
merge 1:1 NAME_1_NAME_2 year using "`path'BEST_tavg_BIN_`i'C_`j'C.dta" 
drop _merge
drop *crop *area
}

local path /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/
forval i=12/22{
local j = `i'+1
merge 1:1 NAME_1_NAME_2 year using "`path'BEST_tavg_BIN_`i'C_`j'C.dta" 
drop _merge
drop *crop *area
}
// all good to go, just takes a while

forval i=23/34{
local j = `i'+1
merge 1:1 NAME_1_NAME_2 year using "`path'BEST_tavg_BIN_`i'C_`j'C.dta" 
drop _merge
drop *crop *area
}

keep if year>1996
** Other data-set was already converted, else go back and convert it again.

// save as a new file
local path_int /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
save "`path_int'merged_climate_dataset", replace
clear
// Changing the unicode
unicode encoding set latin1
unicode translate "`path'merged_climate_dataset.dta"

//Changing the special characters: 
local path_int /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_int'merged_climate_dataset" , clear
foreach var in "NAME_1_NAME_2"{
replace `var' = subinstr(`var',"ê","e",.) // ê
replace `var' = subinstr(`var',"é","e",.) // é
replace `var' = subinstr(`var',"ã","a",.) // ã
replace `var' = subinstr(`var',"á","a",.) // á
replace `var' = subinstr(`var',"â","a",.) // â
replace `var' = subinstr(`var',"ô","o",.) // ô
replace `var' = subinstr(`var',"ó","o",.) // ó
replace `var' = subinstr(`var',"õ","o",.) // õ
replace `var' = subinstr(`var',"ú","u",.) // ú
replace `var' = subinstr(`var',"ç","c",.) // ç
replace `var' = subinstr(`var',"á","a",.) // á
replace `var' = subinstr(`var',"í","i",.) // í
replace `var' = subinstr(`var',"Á","A",.) // Á
replace `var' = subinstr(`var',"É","E",.) // É
}

// Save
saveold "`path_int'merged_climate_dataset", replace version(12)

/*
****************************
*** testing reshape wide ***
****************************
local path /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/
use "`path'/UDEL-temp.dta", clear

// Still key to drop the duplicates
duplicates report NAME_1_NAME_2 year
duplicates drop NAME_1_NAME_2 year, force
// Now reshape works, notice that I do it in pop
reshape wide *pop, i(NAME_1_NAME_2) j(year)
