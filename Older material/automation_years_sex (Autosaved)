******************************
***** Arvid Viaene - UoC *****
***** Merging years for different age groups
** NOTE!! 2000-2009 ar22e missing years, which explains the missing 4-13

** Age group is on place 6 in the filename_key.p
** Sex is place 7, four categories, but going to extract all male (j=1) and female (j=2)
** note, category zero is the baseline and is already present in allmerged, can always add the baseline later for consistency with other categories


** Set directory to where the file was unzipped and the csv file are stored
cd "/Users/arvidviaene/Documents/output"
clear all

local categories_sex 1 2
local years 0 1 2 3 14 15 16 17

** If dta folders already exist, delete them by the following command
** !! Adjust the variables here as well!!

foreach j of numlist `categories_sex'{
	foreach i of numlist `years'{
	erase 0_0_0_`i'_0_0_`j'_0.dta
	}
}
erase allcategories_merged_age

***** Converting CSV files to dta files with months on rows and years in the columns
local categories_sex 1 2
local years 0 1 2 3 14 15 16 17

foreach j of numlist `categories_sex'{
	foreach i of numlist `years'{
	insheet using "/Users/arvidviaene/Documents/output/0_0_0_`i'_0_0_`j'_0.csv", clear
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
	rename mortm mortality_2013_`j'
	save 0_0_0_`i'_0_0_`j'_0
	}
	else if `i'==1{
	rename mortm mortality_2012_`j'
	save 0_0_0_`i'_0_0_`j'_0
	}
	else if `i'==2{
	rename mortm mortality_2011_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==3{
rename mortm mortality_2010_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==4{
rename mortm mortality_2009_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==5{
rename mortm mortality_2008_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==6{
rename mortm mortality_2007_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==7{
rename mortm mortality_2006_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==8{
rename mortm mortality_2005_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==9{
rename mortm mortality_2004_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==10{
rename mortm mortality_2003_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==11{
rename mortm mortality_2002_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==12{
rename mortm mortality_2001_`j'
save 0_0_0_`i'_0_0_`j'_0
}
else if `i'==13{
rename mortm mortality_2000_`j'
save 0_0_0_`i'_0_0_`j'_0
}
	else if `i'==14{
	rename mortm mortality_1999_`j'
	save 0_0_0_`i'_0_0_`j'_0
	}
	else if `i'==15{
	rename mortm mortality_1998_`j'
	save 0_0_0_`i'_0_0_`j'_0
	}
	else if `i'==16{
	rename mortm mortality_1997_`j'
	save 0_0_0_`i'_0_0_`j'_0
	}
	else if `i'==17{
	rename mortm mortality_1996_`j'
	save 0_0_0_`i'_0_0_`j'_0
	}
** end of original loop for i
}
** end of loop for j
}

******* MERGING OF DATA TO ONE DTA-FILE WHICH CAN BE SAVED***
use 0_0_0_0_0_0_0_0, clear
foreach j of numlist `categories_sex'{
	capture{
	foreach i of numlist `years'{
	merge 1:1 municiacutepio month using 0_0_0_`i'_0_0_`j'_0, nogenerate
	} //end of loop forval
	}
}
drop ignorado

save allcategories_merged_sex, replace
