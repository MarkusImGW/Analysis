/*
*** Coefplot commands ***
local coefplot_commands `"vertical offset(0) recast(connected) lwidth(*2) fcolor(*.5) ciopts(recast(rconnected) lp(dash)) omitted graphregion(color(white))"'
local bins5lab `"1 "_-15" 2 "-15_-10" 3 "-10_-5" 4 "-5_0" 5 "0_5" 6 "5_10" 7 "10_15" 8 "15_20" 9 "20_""'
eststo hfp_y: reghdfe admr100k_agg `tempbins5_pop' precip_popt precip_popt2, absorb(year hf_num#period) vce(cluster hf_num)
coefplot (hfp_y), xtitle(Days in Temperature Bin (C)) ytitle("Daily admissions per 100,000 population" "(as % of mean)") drop(precip_popt precip_popt2) xlab(`bins5lab') rescale(`mean') `coef_commands'


local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_intermediate'mort-pop_mun_tmf_allage_97_10", clear

drop _merge
merge 1:1 fips using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/UDEl-temp_fips"

****************************
* Code Justin
****************************

****************************
* Coeffplot
****************************

* Place omit in place of omitted bin 
local tempbins5_pop="s_bin_nInf_n15C_popt s_bin_n15C_n10C_popt s_bin_n10C_n5C_popt s_bin_n5C_0C_popt omit s_bin_5C_10C_popt s_bin_10C_15C_popt s_bin_15C_20C_popt s_bin_20C_nInf_popt"

* Generate omit as a variable with no variation so that Stata will omit it in regression
gen omit=0
eststo hfp_y: reghdfe admr100k_agg `tempbins5_pop' precip_popt precip_popt2, absorb(year hf_num#period) vce(cluster hf_num)
coefplot (hfp_y), vertical xtitle(Days in Temperature Bin (C)) ytitle("Daily admissions per 100,000 population" "(as % of mean)") recast(line) lwidth(*2) fcolor(*.5) ciopts(recast(rline) lp(dash)) omitted drop(precip_popt precip_popt2) xlab(1 "_-15" 2 "-15_-10" 3 "-10_-5" 4 "-5_0" 5 "0_5" 6 "5_10" 7 "10_15" 8 "15_20" 9 "20_") rescale(`mean') saving(~/NorwayHA/graphs/hfp_y_bins, replace) graphregion(color(white))
translate @Graph "~/NorwayHA/graphs/hfp_y_bins.pdf", name("Graph")
* To plot days in bin, now replace omit with the omitted bin so that there is no need to change the local 
replace omit=s_bin_0C_5C_popt
* Graph bar over the bin variables, relabel the variables using yvaroptions 
gr bar `tempbins5_pop' , fysize(25) legend(off) showyvar yvaroptions(relabel(1 "_-15" 2 "-15_-10" 3 "-10_-5" 4 "-5_0" 5 "0_5" 6 "5_10" 7 "10_15" 8 "15_20" 9 "20_")) saving(~/NorwayHA/graphs/temp_bins, replace) graphregion(color(white))
* Graph combine, with temp bin graph smaller because we set fysize(25) (25% of standard size) 
gr combine "~/NorwayHA/graphs/hfp_y_bins" "~/NorwayHA/graphs/temp_bins", imargin (0 0) col (1) xcommon graphregion(color(white))
translate @Graph "~/NorwayHA/graphs/hfp_y_combo.pdf", name("Graph")


****************************
* Binning
****************************
* 5 degree bins
order s_bin_nInf_n40C_popt s_bin_n40C_n39C_popt s_bin_n39C_n38C_popt s_bin_n38C_n37C_popt s_bin_n37C_n36C_popt s_bin_n36C_n35C_popt s_bin_n35C_n34C_popt s_bin_n34C_n33C_popt s_bin_n33C_n32C_popt s_bin_n32C_n31C_popt s_bin_n31C_n30C_popt s_bin_n30C_n29C_popt s_bin_n29C_n28C_popt s_bin_n28C_n27C_popt s_bin_n27C_n26C_popt s_bin_n26C_n25C_popt s_bin_n25C_n24C_popt s_bin_n24C_n23C_popt s_bin_n23C_n22C_popt s_bin_n22C_n21C_popt s_bin_n21C_n20C_popt s_bin_n20C_n19C_popt s_bin_n19C_n18C_popt s_bin_n18C_n17C_popt s_bin_n17C_n16C_popt s_bin_n16C_n15C_popt s_bin_n15C_n14C_popt s_bin_n14C_n13C_popt s_bin_n13C_n12C_popt s_bin_n12C_n11C_popt s_bin_n11C_n10C_popt s_bin_n10C_n9C_popt s_bin_n9C_n8C_popt s_bin_n8C_n7C_popt s_bin_n7C_n6C_popt s_bin_n6C_n5C_popt s_bin_n5C_n4C_popt s_bin_n4C_n3C_popt s_bin_n3C_n2C_popt s_bin_n2C_n1C_popt s_bin_n1C_0C_popt s_bin_0C_1C_popt s_bin_1C_2C_popt s_bin_2C_3C_popt s_bin_3C_4C_popt s_bin_4C_5C_popt s_bin_5C_6C_popt s_bin_6C_7C_popt s_bin_7C_8C_popt s_bin_8C_9C_popt s_bin_9C_10C_popt s_bin_10C_11C_popt s_bin_11C_12C_popt s_bin_12C_13C_popt s_bin_13C_14C_popt s_bin_14C_15C_popt s_bin_15C_16C_popt s_bin_16C_17C_popt s_bin_17C_18C_popt s_bin_18C_19C_popt s_bin_19C_20C_popt s_bin_20C_21C_popt s_bin_21C_22C_popt s_bin_22C_23C_popt s_bin_23C_24C_popt s_bin_24C_25C_popt s_bin_25C_26C_popt s_bin_26C_27C_popt s_bin_27C_28C_popt s_bin_28C_29C_popt s_bin_29C_30C_popt s_bin_30C_31C_popt s_bin_31C_32C_popt s_bin_32C_33C_popt s_bin_33C_34C_popt s_bin_34C_35C_popt s_bin_35C_Inf_popt
local tempbins5_pop="s_bin_nInf_n15C_popt s_bin_n15C_n10C_popt s_bin_n10C_n5C_popt s_bin_n5C_0C_popt s_bin_5C_10C_popt s_bin_10C_15C_popt s_bin_15C_20C_popt s_bin_20C_nInf_popt"

egen s_bin_nInf_n15C_popt=rowtotal(s_bin_nInf_n40C_popt-s_bin_n16C_n15C_popt)
egen s_bin_n15C_n10C_popt=rowtotal(s_bin_n15C_n14C_popt-s_bin_n11C_n10C_popt)
egen s_bin_n10C_n5C_popt=rowtotal(s_bin_n10C_n9C_popt-s_bin_n6C_n5C_popt)
egen s_bin_n5C_0C_popt=rowtotal(s_bin_n5C_n4C_popt-s_bin_n1C_0C_popt)
egen s_bin_0C_5C_popt=rowtotal(s_bin_0C_1C_popt-s_bin_4C_5C_popt)
egen s_bin_5C_10C_popt=rowtotal(s_bin_5C_6C_popt-s_bin_9C_10C_popt)
egen s_bin_10C_15C_popt=rowtotal(s_bin_10C_11C_popt-s_bin_14C_15C_popt)
egen s_bin_15C_20C_popt=rowtotal(s_bin_15C_16C_popt-s_bin_19C_20C_popt)
egen s_bin_20C_nInf_popt=rowtotal(s_bin_20C_21C_popt-s_bin_35C_Inf_popt)


* 3-degree bins 
local tempbins3_pop=" s_bin_nInf_n18C_popt s_bin_n18C_n15C_popt s_bin_n15C_n12C_popt s_bin_n12C_n9C_popt s_bin_n6C_n3C_popt s_bin_n3C_0C_popt s_bin_3C_6C_popt s_bin_6C_9C_popt s_bin_9C_12C_popt s_bin_12C_15C_popt s_bin_15C_18C_popt s_bin_18C_21C_popt s_bin_21C_Inf_popt"

egen s_bin_nInf_n18C_popt=rowtotal(s_bin_nInf_n40C_popt-s_bin_n19C_n18C_popt)
egen s_bin_n18C_n15C_popt=rowtotal(s_bin_n18C_n17C_popt-s_bin_n16C_n15C_popt)
egen s_bin_n15C_n12C_popt=rowtotal(s_bin_n15C_n14C_popt-s_bin_n13C_n12C_popt)
egen s_bin_n12C_n9C_popt=rowtotal(s_bin_n12C_n11C_popt-s_bin_n10C_n9C_popt)
egen s_bin_n9C_n6C_popt=rowtotal(s_bin_n9C_n8C_popt-s_bin_n7C_n6C_popt)
egen s_bin_n6C_n3C_popt=rowtotal(s_bin_n6C_n5C_popt-s_bin_n4C_n3C_popt)
egen s_bin_n3C_0C_popt=rowtotal(s_bin_n3C_n2C_popt-s_bin_n1C_0C_popt)
egen s_bin_0C_3C_popt=rowtotal(s_bin_0C_1C_popt-s_bin_2C_3C_popt)
egen s_bin_3C_6C_popt=rowtotal(s_bin_3C_4C_popt-s_bin_5C_6C_popt)
egen s_bin_6C_9C_popt=rowtotal(s_bin_6C_7C_popt-s_bin_8C_9C_popt) 
egen s_bin_9C_12C_popt=rowtotal(s_bin_9C_10C_popt-s_bin_11C_12C_popt)
egen s_bin_12C_15C_popt=rowtotal(s_bin_12C_13C_popt-s_bin_14C_15C_popt)
egen s_bin_15C_18C_popt=rowtotal(s_bin_15C_16C_popt-s_bin_17C_18C_popt)
egen s_bin_18C_21C_popt=rowtotal(s_bin_18C_19C_popt-s_bin_20C_21C_popt)
egen s_bin_21C_Inf_popt=rowtotal(s_bin_21C_22C_popt-s_bin_35C_Inf_popt)

****************************
* Testing reghdfe
****************************
 sysuse auto, clear
//first comparison
xi: reg price weight length i.rep78,robust
 reghdfe price weight length, absorb(rep78)
 *Yes, they both have the same coefficients
 reghdfe price weight length, absorb(rep78) vce(cluster rep78)
//second comparison
 reghdfe price weight length, absorb(rep78 foreign) vce(cluster rep78) 
xi: reg price weight length i.rep78 i.foreign, robust
*Yep, once again
//third comparison
xi: reg price weight length i.rep78*i.foreign, robust
reghdfe price weight length, absorb(rep78#foreign) vce(cluster rep78)  
* Same again

  * Save the cache
        . reghdfe price weight length, a(turn rep) vce(turn) cache(save,
            keep(foreign))
        .
        . * Run regressions
        . reghdfe price weight, a(turn rep) cache(use)
        . reghdfe price length, a(turn rep) cache(use)
        .
        . * Clean up
        . reghdfe, cache(clear)
        . restore
