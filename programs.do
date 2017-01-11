capture program drop removecharacters
program define removecharacters
	args var
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
replace `var' = subinstr(`var',"í","i",.) // í
replace `var' = subinstr(`var',"?","I",.) // í
replace `var' = subinstr(`var',"Ê","E",.) // ê
replace `var' = subinstr(`var',"É","E",.) // é
replace `var' = subinstr(`var',"Â","A",.) // ã
replace `var' = subinstr(`var',"Á","A",.) // á
replace `var' = subinstr(`var',"Ã","A",.) // â
replace `var' = subinstr(`var',"Ô","O",.) // ô
replace `var' = subinstr(`var',"Ó","O",.) // ó
replace `var' = subinstr(`var',"Õ","O",.) // õ
replace `var' = subinstr(`var',"Ú","U",.) // ú
replace `var' = subinstr(`var',"Í","I",.) // ú
replace `var' = subinstr(`var',"Ç","C",.) // ç
end




** Merging with temperature data - ONE MORE TRY :) :) (of the 1000; Think Edison!)


removecharacters state
removecharacters municipality
replace municipality = upper(municipality)
replace state = upper(state)
duplicates list state_fips municipality
duplicates drop state_fips municipality, force
replace municipality = subinstr(municipality,"razil","rasil",.) // ç
save "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port_statefips_removed", replace

use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
removecharacters municipality
replace municipality = upper(municipality)
merge 1:1 municipality state_fips using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port_statefips_removed"
sort _merge state_fips municipality 
keep municipality state_fips _merge
sort _merge state_fips municipality

* using upper has reduced the non-merge from 380 to 305
** only 235 still unmatched from the fil; even without the X
** Only 217 left after adjusting the X by rerunning code
** RUN with replacing asil

***
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear
removecharacters municipality
replace municipality = upper(municipality)
merge 1:1 municipality state_fips using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port_statefips_removed"
sort _merge state_fips municipality 
keep municipality state_fips _merge
sort _merge state_fips municipality

*************** AREA_CODING AGAIN
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/area_coding_2", clear
removecharacters state
removecharacters municipality
replace state = upper(state)
replace municipality = upper(municipality)
merge 1:1 municipality state using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port_statefips_removed"
** 4800 merged
sort _merge

