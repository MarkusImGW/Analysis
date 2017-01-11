** 151225 Samuel S. 
** Regress impact by climate tertile & rural status

*************************************
** Set up workspace
*************************************
version 13.1
clear all
set more off
cd "$pat_hom"
cap log close
log using "$pat_log\150_reg_imp_by_ter_rur", text replace

*************************************
** Start work here
*************************************

timer on 1

use "$pat_dta\051_mer_all.dta"

*************************************
** 151A Speficy parameters, dropping one temperature bin
*************************************
**** Specify temperature bins before, at, and after the omitted bin
loc bins_bef 	tem_bin_00C_02C - tem_bin_18C_20C
loc omi_bin 	tem_bin_21C_23C
loc omi_bin_id = 8
loc bins_aft 	tem_bin_24C_26C - tem_bin_33C_35C

**** interaction bins before/after omitted var(s), tem_bin_21C_23C_cold & tem_bin_21C_23C_hot
loc ints_bef 	tem_bin_00C_02C_cold - tem_bin_18C_20C_hot tem_bin_24C_26C_cold - tem_bin_33C_35C_hot	///
				tem_bin_00C_02C_rural - tem_bin_18C_20C_rural tem_bin_24C_26C_rural - tem_bin_33C_35C_rural
loc ints_aft 	tem_bin_00C_02C_cold_rural - tem_bin_18C_20C_hot_rural ///
				tem_bin_24C_26C_cold_rural - tem_bin_33C_35C_hot_rural

**** age controls, omitting age_pro_pop_0144
loc age_dist 	age_pro_pop_0000_ age_pro_pop_4564_ age_pro_pop_65Inf_

age_pro_pop_0000_ = pop_0001_/pop_tot
age_pro_pop_4564_ = pop_4564_/pop_tot
age_pro_pop_65Inf_= pop_65Inf_/pop_tot


**** geographical units: geolev1 ~ "state", geolev2 ~ "municipality"
loc geolev1 	geolev1
loc geolev2 	geolev2

**** dependent variable
loc dep_var mor_rat_all

*** colors
loc cat_cols 	black blue red
loc ci_cols 	black ebblue erose

**** municipality & year fixed-effects
loc fix_effs i.`geolev2' i.year

*************************************
** 151B Regress
*************************************
reghdfe `dep_var' `bins_bef' `bins_aft' `ints_bef' `ints_aft' ///
	`age_dist' [aw=pop_all_], absorb( `fix_effs' ) vce( cluster `geolev2' )

estimates store r1, title(M \& Y FE)

*************************************
** 151C Plot
*************************************
glo title =	"151 Impact by Climate Tertiles (M & Y FE, 12 bins)"
loc cats 		urban cold hot
local ylabel 	-12.5 0 12.5 25 37.5 50
local yscale 	-15 50
gra_by_cat, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

glo title =	"151.1 Impact by Climate Tertiles, Rural (M & Y FE, 12 bins)"
loc cats 		rural cold_rural hot_rural
gra_treated, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

*************************************
** 152A Speficy FE: M & SY FE
*************************************
loc fix_effs i.`geolev2' i.`geolev1'#i.year

*************************************
** 152B Regress
*************************************			
reghdfe `dep_var' `bins_bef' `bins_aft' `ints_bef' `ints_aft' ///
	`age_dist' [aw=pop_all_], absorb( `fix_effs' ) vce( cluster `geolev2' )

estimates store r2, title(M \& SY FE)

*************************************
** 152C Plot
*************************************
global title =	"152 Impact by Climate Tertiles, Urban (M & SY FE, 12 bins)"
loc cats 		urban cold hot
gra_by_cat, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

glo title =	"152.1 Impact by Climate Tertiles, Rural (M & SY FE, 12 bins)"
loc cats 		rural cold_rural hot_rural
gra_treated, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

*************************************
** 153A Speficy M & SY Quad Time Trend
*************************************
loc fix_effs  i.`geolev2'
loc sta_qua i.`geolev1'#c.year i.`geolev1'#c.year2

*************************************
** 153 Regress
*************************************			
reghdfe `dep_var' `bins_bef' `bins_aft' `ints_bef' `ints_aft' ///
	`age_dist' `sta_qua' [aw=pop_all_], absorb( `fix_effs' ) vce( cluster `geolev2' )

estimates store r3, title(M FE \& SY QT)

*************************************
** 153C Plot
*************************************
global title =	"153 Impact by Climate Tertiles, Urban (M FE & SY QT, 12 bins)"
loc cats 		urban cold hot
gra_by_cat, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')				

glo title =	"153.1 Impact by Climate Tertiles, Rural (M FE & SY QT, 12 bins)"
loc cats 		rural cold_rural hot_rural
gra_treated, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

*************************************
** 154A Speficy parameters, dropping three temperature bins
*************************************
**** interaction bins before/after omitted var(s), tem_bin_21C_23C_cold & tem_bin_21C_23C_hot
loc ints_bef 	tem_bin_00C_02C_rural - tem_bin_18C_20C_rural tem_bin_24C_26C_rural - tem_bin_33C_35C_rural ///
				tem_bin_00C_02C_cold - tem_bin_03C_05C_hot tem_bin_30C_32C_cold - tem_bin_33C_35C_hot
loc ints_aft 	tem_bin_00C_02C_cold_rural - tem_bin_03C_05C_hot_rural ///
				tem_bin_30C_32C_cold_rural - tem_bin_33C_35C_hot_rural

**** municipality & year fixed-effects
loc fix_effs i.`geolev2' i.year 

*************************************
** 154B Regress
*************************************
reghdfe `dep_var' `bins_bef' `bins_aft' `ints_bef' `ints_aft' ///
	`age_dist' [aw=pop_all_], absorb( `fix_effs' ) vce( cluster `geolev2' )

estimates store r4, title(M \& Y FE)

*************************************
** 154C Plot
*************************************
glo title =	"154 Impact by Climate Tertiles, Urban (M & Y FE, 12 bins)"
loc cats 		urban cold hot
gra_by_cat, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

glo title =	"154.1 Impact by Climate Tertiles, Rural (M & Y FE, 12 bins)"
loc cats 		rural cold_rural hot_rural
gra_treated, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

*************************************
** 155A Speficy FE: M & SY FE
*************************************
loc fix_effs  i.`geolev2'  i.`geolev1'#i.year

*************************************
** 155B Regress
*************************************			
reghdfe `dep_var' `bins_bef' `bins_aft' `ints_bef' `ints_aft' ///
	`age_dist' [aw=pop_all_], absorb( `fix_effs' ) vce( cluster `geolev2' )

estimates store r5, title(M \& SY FE)

*************************************
** 155C Plot
*************************************
global title =	"155 Impact by Climate Tertiles, Urban (M & SY FE, 12 bins)"
loc cats 		urban cold hot
gra_by_cat, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

glo title =	"155.1 Impact by Climate Tertiles, Rural (M & SY FE, 12 bins)"
loc cats 		rural cold_rural hot_rural
gra_treated, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

*************************************
** 156A Speficy M & SY Quad Time Trend
*************************************
loc fix_effs  i.`geolev2'
loc sta_qua i.`geolev1'#c.year i.`geolev1'#c.year2 

*************************************
** 156B Regress
*************************************			
reghdfe `dep_var' `bins_bef' `bins_aft' `ints_bef' `ints_aft' ///
	`age_dist' `sta_qua' [aw=pop_all_], absorb( `fix_effs' ) vce( cluster `geolev2' )

estimates store r6, title(M FE \& SY QT)

*************************************
** 156C Plot
*************************************
global title =	"156 Impact by Climate Tertiles, Urban (M FE & SY QT, 12 bins)"
loc cats 		urban cold hot
gra_by_cat, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')				

glo title =	"156.1 Impact by Climate Tertiles, Rural (M FE & SY QT, 12 bins)"
loc cats 		rural cold_rural hot_rural
gra_treated, bins_bef(`bins_bef') bins_aft(`bins_aft') ///
				omi_bin(`omi_bin') omi_bin_id(`omi_bin_id') ///
				cats(`cats') cat_cols(`cat_cols') ci_cols(`ci_cols') ///
				ylabel(`ylabel') yscale(`yscale')

esttab r1 r2 r3 r4 r5 r6, replace b(a2) se(a2) r2 ar2 scalars(F) aic bic drop(`age_dist' *geolev*) nostar parentheses mtitles label varlabels(_cons Constant)
esttab r1 r2 r3 r4 r5 r6 using "$pat_out/150TemRur.tex", replace b(a2) se(a2) r2 ar2 scalars(F) aic bic drop(`age_dist' *geolev*) longtable nostar parentheses mtitles label varlabels(_cons Constant)

timer off 1
timer list 1

*************************************
** Close workspace
*************************************
log close
