forval i=0/34{
local j = `i'+1
use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/BEST_tavg_BIN_`i'C_`j'C.dta" 
saveold "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_`i'C_`j'C.dta", replace version(12)
}

use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/BEST_tavg_BIN_35C_Inf.dta" 
saveold "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_35C_Inf.dta", replace version(12)
 

** Other ones are converted

**then the special ones
forval i=0/6{
local j = 5*`i'
use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/NCEP-dd`j'.dta"
saveold "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/NCEP-dd`j'.dta", replace version(12)
}

** Other data-set was already converted, else go back and convert it again.


*********** UDEL-temp ***
use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/BEST_tavg_BIN_35C_inf.dta" 
saveold "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_`i'C_`j'C.dta", replace version(12)
 

unicode encoding set latin1
cd "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData2/"
//careful, I think the following line automatically saves it in the new format
unicode translate "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData/cleaned/UDEL-temp.dta" 


use "UDEL-temp.dta", clear


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
saveold "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/UDEL-temp.dta", replace version(12)
