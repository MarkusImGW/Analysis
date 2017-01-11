***********************************************************************************

* File: temp_graphs.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create tables with fixed effects regressions
Structure:
*/

***********************************************************************************

cd "/Users/arvidviaene/Dropbox/2 Mortality/"
// preliminaries
global path /Users/arvidviaene/Dropbox/2 Mortality/
global path_graph /Users/arvidviaene/Dropbox/2 Mortality/Results/Figures/
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/

set matsize 5000

// insheet
use "`path_intermediate'mort-pop_mun_tmf_allage_97_10", clear

local this_tem = 0
foreach vv of var tavg_bin_0C_1C_annual_pop -  tavg_bin_35C_Inf_annual_pop  {
	local tem = "t" + string( `this_tem' , "%02.0f" )
	gen `tem' = `vv'*12
	local this_tem = `this_tem' + 1
}


gen xlab = "Temperature Bins (degrees Celsius)"

graph bar (mean) t00 - t35 [ aw = pop_weights ] ///
	if ( 1997 <= year ) & ( year <= 2012 ) ///
	, legend(off) ///
	title("Mean Number of Degree Days in a Year in Brazil (1997-2012)", size(medlarge)) ///
	ytitle("Degree Days") ///
	nolabel showyvars yvar(label(labsize(tiny))) ///
	blabel( bar, format("%2.1f") size(tiny) ) over(xlab)

graph export "$path_graph/brazil_tem_dis_days.png", replace

graph bar (mean) t00 - t35 [ aw = pop_weights ] ///
	, legend(off)  ///
	title("Mean Distribution of Degree Days in a Year in Brazil (1997-2012)", size(medlarge)) ///
	ytitle("%") ///
	nolabel showyvars yvar(label(labsize(tiny))) ///
	blabel( bar, format("%2.1f") size(tiny) ) percentages  over(xlab)

graph export "$path_graph/brazil_tem_dis_percentages.pdf", replace

