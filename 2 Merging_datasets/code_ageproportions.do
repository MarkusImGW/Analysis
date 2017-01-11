local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/

set matsize 5000

// insheet
use "`path_intermediate'mort-pop_mun_tmf_allage_97_10", clear

keep fips year age_pro_pop_0000_ age_pro_pop_0140_ age_pro_pop_4070_ age_pro_pop_70Inf_
gen str7 id = string(fips) 
drop fips
rename id fips
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
save "`path_intermediate'mort-pop_mun_tmf_allage_age", replace
