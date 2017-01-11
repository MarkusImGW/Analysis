local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
set matsize 5000
use "`path_intermediate'merged_monthly_97_09", clear

********* locals temp and precip *********
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local cluster state_fips

** regression
areg mrate_tot `three' precip_ precip_sq year#month#state_fips [aw=pop_tot_weights], absorb(fips_month) vce(cluster state_fips)

year#month#state_fips

reghdfe mrate_tot `three' precip_ precip_sq [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
reghdfe mrate_tot `three' precip_ precip_sq [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
