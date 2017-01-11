*** GRAPHS
** Set directory
cd "/Users/arvidviaene/Documents/output"
use allcategories_merged, clear

*************************
***** Deaths by years ***
*************************


drop if municiacutepio!="Total" 
drop if month == 13
local months mortality_2013 mortality_2012 mortality_2011 mortality_2010 mortality_1999 mortality_1998 mortality_1997 mortality_1996
twoway connected `months' month
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality.pdf
** This graph illustrates that mortality figures are larger in the summer (
** Note that the summer there is during our "Winter" (as does Argentina), => June is the coldest!
** http://thebrazilbusiness.com/article/weather-in-brazil

*************************
***** Deaths by sex *****
*************************
cd "/Users/arvidviaene/Documents/output"
sysuse uslifeexp2, clear
scatter le year

use allcategories_merged_age, clear
drop if municiacutepio!="Total" 
drop if month == 13
twoway connected mortality_2013_1 mortality_2013_2 month
local months_age mortality_2013_1 mortality_2013_2 mortality_2012_1 mortality_2012_2
twoway connected `months_age' month
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_sex.pdf

******************************
***** Deaths by location *****
******************************
cd "/Users/arvidviaene/Documents/output"
**set-up
sysuse uslifeexp2, clear
scatter le year

use allcategories_merged_location, clear
drop if municiacutepio!="Total" 
drop if month == 13

**graph
local categories_location 1 2 3 4 5 6
local years 0 1 2 
*3 14 15 16 17

local months_age mortality_2013_0_0_0_0
local categories_location 1 2 3 4 5 6
foreach j of numlist `categories_location'{
	local months_age "`months_age' mortality_2013_0_0_0_`j'"
	display `months_age'
}
twoway connected `months_age' month

twoway connected mortality_2013_0_0_0_0  mortality_2013_0_0_0_1 mortality_2013_0_0_0_2 mortality_2013_0_0_0_3 mortality_2013_0_0_0_4 mortality_2013_0_0_0_5 mortality_2013_0_0_0_6 month 
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_location.pdf, replace
twoway connected mortality_2013_0_0_0_0  mortality_2013_0_0_0_1 mortality_2013_0_0_0_3 month 
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_location2.pdf, replace



twoway connected mortality_2013_l1 mortality_2013_l2 mortality_2013_l3 mortality_2013_l4 mortality_2013_l5 month
twoway connected mortality_2013_l1 mortality_2012_l1 mortality_2011_l1 mortality_2010_l1 month
twoway connected mortality_2013_l1 month
local months_age mortality_2013_l1 mortality_2013_l2 mortality_2012_l1 mortality_2012_l2
twoway connected `months_age' month
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_sex.pdf

******************************
***** Deaths by location *****
******************************
cd "/Users/arvidviaene/Documents/output"
use allcategories_merged_age, clear
drop if municiacutepio!="Total" 
drop if month == 13

**set-up
sysuse uslifeexp2, clear
scatter le year



cd "/Users/arvidviaene/Documents/output"
use allcategories_merged_location, clear
insheet using somefile.csv
> >> sort var1
> >> tempfile file1
> >> save 'file1'



encode municiacutepio, gen(st)
** encode attaches numerical values to a string, as xtset requires numerical id's to work
list municiacutepio st in 1/30, nolabel sepby(municiacutepio)
drop if month==13
xtset st month, monthly
** Strange, it starts assigning values by m2 (and why 1960, do I have to change the default option?)
** or change the variable to mx
** convert to a readible time-frame 
** http://www.stata.com/manuals13/ddatetime.pdf#ddatetime
sort municiacutepio month
** great learning site: http://dss.princeton.edu/online_help/stats_packages/stata/


