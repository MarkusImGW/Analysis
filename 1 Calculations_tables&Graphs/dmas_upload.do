local path_raw /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
use "`path_intermediate'merged_monthly_97_09", clear


use "XX", clear

********* locals temp and precip *********
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local cluster state_fips

** regression
reghdfe mrate_tot `three' precip_ precip_sq [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
