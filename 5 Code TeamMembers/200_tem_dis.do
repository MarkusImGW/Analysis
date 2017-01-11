** 160129 Samuel S. 
** Temperature (Climatic) Distribution

*************************************
** Set up workspace
*************************************
version 13.1
clear all
set more off
cd "$pat_hom"
cap log close
** log using "$pat_log\110_reg_imp.log", text replace

*************************************
** Start work here
*************************************

timer on 1

use "$pat_dta\051_mer_all.dta"

*************************************
** Create bar graphs
*************************************

*** Generate Renamed Degree-day Bins for Easy Manipulation
local this_tem = 0
foreach vv of var tavg_bin_00C_01C_m_pop - tavg_bin_35C_Inf_m_pop {
	local tem = "t" + string( `this_tem' , "%02.0f" )
	gen `tem' = `vv'
	local this_tem = `this_tem' + 1
}
gen xlab = "Temperature Bins (degrees Celsius)"

*** Graph Degree Day Bars
graph bar (mean) t00 - t35 [ aw = pop_all_ ] ///
	if ( 1990 <= year ) & ( year <= 2012 ) ///
	, legend(off) ///
	title("Mean Number of Degree Days in a Year in Mexico (1990-2012)", size(medlarge)) ///
	ytitle("Degree Days") ///
	nolabel showyvars yvar(label(labsize(tiny))) ///
	blabel( bar, format("%2.1f") size(tiny) ) over(xlab)

graph export "$pat_out/200_mex_tem_dis_days.pdf", replace

*** Graph Degree Days Percentage Bars
graph bar (mean) t00 - t35 [ aw = pop_all_ ] ///
	if ( 1990 <= year ) & ( year <= 2012 ) ///
	, legend(off)  ///
	title("Mean Distribution of Degree Days in a Year in Mexico (1990-2012)", size(medlarge)) ///
	ytitle("%") ///
	nolabel showyvars yvar(label(labsize(tiny))) ///
	blabel( bar, format("%2.1f") size(tiny) ) percentages  over(xlab)

graph export "$pat_out/200_mex_tem_dis_percentages.pdf", replace

*************************************
** Calculate & Summarize Mean and Median Temperatures in Each Municipality-Year
*************************************

*** Calculate Means
local this_tem = 0.5
foreach vv of var t00 - t35 {
	gen con_`vv' = `vv' * `this_tem'
	local this_tem = `this_tem' + 1
}
egen t_mean_num = rowtotal( con_t00 - con_t35 )
egen t_mean_den = rowtotal( t00 - t35 )
gen t_mean = t_mean_num / t_mean_den
drop con_*
su t_mean if ( 1990 <= year ) & ( year <= 2012 ) [ aw = pop_all_ ], d

*** Calculate Medians
gen t_med = .
gen t_med_val = t_mean_den / 2
local this_tem = 1
gen cum_t00 = t00
foreach vv of var t01 - t35 {
	egen cum_`vv' = rowtotal( t00 - `vv' ) 
	local before = "t" + string( `this_tem' - 1 , "%02.0f" )
	replace t_med = `this_tem' + 0.5 ///
		if ( cum_`before' <= t_med_val ) & ( t_med_val < cum_`vv' )
	local this_tem = `this_tem' + 1
}
su t_med if ( 1990 <= year ) & ( year <= 2012 ) [ aw = pop_all_ ], d

timer off 1
timer list 1

*************************************
** Close workspace
*************************************
** log close
