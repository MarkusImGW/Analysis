** Arvid Viaene
** Last updated 06/25/2015

** specify directory
cd "/Users/arvidviaene/Documents/output"
clear all

** If dta folders already exist, delete them by the following command
erase 0_0_0_0_0_0_0_0.dta
erase 0_0_0_1_0_0_0_0.dta 
erase 0_0_0_2_0_0_0_0.dta
erase 0_0_0_3_0_0_0_0.dta 

cd "/Users/arvidviaene/Documents/output"
clear all

** # of years; DEFAULT IS 3 HERE, else it will stop at 4 as there is no 2009
** see automation_years2 to include the years from 1996-1999
** Switch n to go larger, but it will stop
local n 3

foreach i of num 0/`n'{
insheet using "/Users/arvidviaene/Documents/output/0_0_0_`i'_0_0_0_0.csv", clear
drop if municiacutepio == "&" 
rename janeiro mortm1
rename fevereiro mortm2
rename marccedilo mortm3
rename abril mortm4
rename maio mortm5
rename junho mortm6
rename julho mortm7
rename agosto mortm8
rename setembro mortm9
rename outubro mortm10
rename novembro mortm11
rename dezembro mortm12
rename total mortm13

forval x=1/12{
replace mortm`x'= "0" if mortm`x' == "-"
}

destring, replace
reshape long mortm, i(municiacutepio) j(month)

**Renaming the variable and inserting time
if `i'==0{
rename mortm mortality_2013
save 0_0_0_`i'_0_0_0_0
}
else if `i'==1{
rename mortm mortality_2012
save 0_0_0_`i'_0_0_0_0
}
else if `i'==2{
rename mortm mortality_2011
save 0_0_0_`i'_0_0_0_0
}
else if `i'==3{
rename mortm mortality_2010
save 0_0_0_`i'_0_0_0_0
}
else if `i'==4{
rename mortm mortality_2009
save 0_0_0_`i'_0_0_0_0
}
else if `i'==5{
rename mortm mortality_2008
save 0_0_0_`i'_0_0_0_0
}
else if `i'==6{
rename mortm mortality_2007
save 0_0_0_`i'_0_0_0_0
}
else if `i'==7{
rename mortm mortality_2006
save 0_0_0_`i'_0_0_0_0
}
else if `i'==8{
rename mortm mortality_2005
save 0_0_0_`i'_0_0_0_0
}
else if `i'==9{
rename mortm mortality_2004
save 0_0_0_`i'_0_0_0_0
}
else if `i'==10{
rename mortm mortality_2003
save 0_0_0_`i'_0_0_0_0
}
else if `i'==11{
rename mortm mortality_2002
save 0_0_0_`i'_0_0_0_0
}
else if `i'==12{
rename mortm mortality_2001
save 0_0_0_`i'_0_0_0_0
}
else if `i'==13{
rename mortm mortality_2000
save 0_0_0_`i'_0_0_0_0
}
else if `i'==14{
rename mortm mortality_1999
save 0_0_0_`i'_0_0_0_0
}
else if `i'==15{
rename mortm mortality_1998
save 0_0_0_`i'_0_0_0_0
}
else if `i'==16{
rename mortm mortality_1997
save 0_0_0_`i'_0_0_0_0
}
else if `i'==17{
rename mortm mortality_1996
save 0_0_0_`i'_0_0_0_0
}

** end of original loop for i
}

use 0_0_0_0_0_0_0_0, clear
forval i=1/`n'{
merge 1:1 municiacutepio month using 0_0_0_`i'_0_0_0_0, nogenerate
} //end of loop forval

save allcategories_merged, replace

****** NEW DATA-MANIPULATIONS *****
cd "/Users/arvidviaene/Documents/output"
use allcategories_merged, clear
drop if municiacutepio!="Total" 
drop if month == 13
scatter mortality_2013 mortality_2012 month, connect (l)
twoway connected mortality_2013 mortality_2012 month
** this graph illustrates that mortality figures are larger in the summer (
** Note that the summer there is during our "Winter" (as does Argentina), => June is the coldest!
** http://thebrazilbusiness.com/article/weather-in-brazil
local months mortality_2013 mortality_2012 mortality_2011 mortality_2010 mortality_1999 mortality_1998 mortality_1997 mortality_1996
twoway connected mortality_1999 mortality_1998 mortality_1997 mortality_1996 month
twoway connected `months' month
tab month



sysuse uslifeexp2, clear
scatter le year
scatter le year, connect(l)
scatter le year, connect(l) msymbol(i)
scatter le year, title("Scatterplot") subtitle("Life expectancy at birth, U.S.") note("1") caption("Source:  National Vital Statistics Report, Vol. 50 No. 6")scheme(economist)



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



****** TESTING IF DATA-FILE EXISTS *****
** in your respective file where you stored the docouments, calling the following csv files gives an error"
insheet using "/Users/arvidviaene/Documents/output/0_0_0_4_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_5_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_6_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_7_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_8_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_9_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_10_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_11_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_12_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_13_0_0_0_0.csv", clear
** no data for this one 
insheet using "/Users/arvidviaene/Documents/output/0_0_0_14_0_0_0_0.csv", clear
insheet using "/Users/arvidviaene/Documents/output/0_0_0_15_0_0_0_0.csv", clear
insheet using "/Users/arvidviaene/Documents/output/0_0_0_16_0_0_0_0.csv", clear
insheet using "/Users/arvidviaene/Documents/output/0_0_0_17_0_0_0_0.csv", clear
insheet using "/Users/arvidviaene/Documents/output/0_0_0_17_2_1_1_1.csv", clear




****** Panel data exercise *****
*** Some panel-data 
webuse airacc, clear
xtset airline time, delta(1)

webuse nlswork, clear
xtset idcode year
xtreg ln_w grade age c.age#c.age ttl_exp c.ttl_exp#c.ttl_exp tenure
xtreg ln_w grade age c.age#c.age ttl_exp c.ttl_exp#c.ttl_exp tenure ///
            c.tenure#c.tenure 2.race not_smsa south, fe

