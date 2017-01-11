capture program drop removecharacters
program define removecharacters
	args var
replace `var' = subinstr(`var',"�","e",.) // �
replace `var' = subinstr(`var',"�","e",.) // �
replace `var' = subinstr(`var',"�","a",.) // �
replace `var' = subinstr(`var',"�","a",.) // �
replace `var' = subinstr(`var',"�","a",.) // �
replace `var' = subinstr(`var',"�","o",.) // �
replace `var' = subinstr(`var',"�","o",.) // �
replace `var' = subinstr(`var',"�","o",.) // �
replace `var' = subinstr(`var',"�","u",.) // �
replace `var' = subinstr(`var',"�","c",.) // �
replace `var' = subinstr(`var',"�","i",.) // �
replace `var' = subinstr(`var',"?","I",.) // �
replace `var' = subinstr(`var',"�","E",.) // �
replace `var' = subinstr(`var',"�","E",.) // �
replace `var' = subinstr(`var',"�","A",.) // �
replace `var' = subinstr(`var',"�","A",.) // �
replace `var' = subinstr(`var',"�","A",.) // �
replace `var' = subinstr(`var',"�","O",.) // �
replace `var' = subinstr(`var',"�","O",.) // �
replace `var' = subinstr(`var',"�","O",.) // �
replace `var' = subinstr(`var',"�","U",.) // �
replace `var' = subinstr(`var',"�","I",.) // �
replace `var' = subinstr(`var',"�","C",.) // �
end




** Merging with temperature data - ONE MORE TRY :) :) (of the 1000; Think Edison!)


removecharacters state
removecharacters municipality
replace municipality = upper(municipality)
replace state = upper(state)
duplicates list state_fips municipality
duplicates drop state_fips municipality, force
replace municipality = subinstr(municipality,"razil","rasil",.) // �
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

