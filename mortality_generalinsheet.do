******************************
***** Arvid Viaene - UoC *****
***** Last changed: 13 July, 2015
******************************

** Set directory to where the file was unzipped and the csv file are stored
cd "/Users/arvidviaene/Documents/output2/output"
clear all

*** Create the placeholders for the variables ***
*local place_of_death 0 1
*local years 0 1 2 3 14 15 16 17
*local cause 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
*local age 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
*local sex 0 1 2 3
*local location_of_death 0 1 2 3 4 5 6

// Years go from 1996-2013

local place_of_death 0 
local years 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
local cause 0 
local age 0 
local sex 0
local location_of_death 0

** Getting the CSV files to a dta file that can be read by stata ***
foreach k of numlist `place_of_death'{
foreach l of numlist `years'{
foreach m of numlist `cause'{
foreach n of numlist `age'{
foreach o of numlist `sex'{	
foreach p of numlist `location_of_death'{
	capture noi {
	insheet using "/Users/arvidviaene/Documents/output2/output/0_0_`k'_`l'_`m'_`n'_`o'_`p'.csv", clear
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
*** reshaping the data to create the specific 0_0_`k'_`i'_`m'_`n'_`o'_`p' variable **
	destring, replace
	reshape long mortm, i(municiacutepio) j(month)

**Renaming the variable and inserting time
	if `l'==0{
	rename mortm mortality_`k'_2013_`m'_`n'_`o'_`p'
	save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
	}
	else if `l'==1{
	rename mortm mortality_`k'_2012_`m'_`n'_`o'_`p'
	save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
	}
	else if `l'==2{
	rename mortm mortality_`k'_2011_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==3{
rename mortm mortality_`k'_2010_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==4{
rename mortm mortality_`k'_2009_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==5{
rename mortm mortality_`k'_2008_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==6{
rename mortm mortality_`k'_2007_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==7{
rename mortm mortality_`k'_2006_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==8{
rename mortm mortality_`k'_2005_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==9{
rename mortm mortality_`k'_2004_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==10{
rename mortm mortality_`k'_2003_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==11{
rename mortm mortality_`k'_2002_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==12{
rename mortm mortality_`k'_2001_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
else if `l'==13{
rename mortm mortality_`k'_2000_`m'_`n'_`o'_`p'
save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
}
	else if `l'==14{
	rename mortm mortality_`k'_1999_`m'_`n'_`o'_`p'
	save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
	}
	else if `l'==15{
	rename mortm mortality_`k'_1998_`m'_`n'_`o'_`p'
	save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
	}
	else if `l'==16{
	rename mortm mortality_`k'_1997_`m'_`n'_`o'_`p'
	save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
	}
	else if `l'==17{
	rename mortm mortality_`k'_1996_`m'_`n'_`o'_`p'
	save 0_0_`k'_`l'_`m'_`n'_`o'_`p', replace
	}
** bracket for capture
}
** end of loops
}
}
}
}
}
}


******* MERGING OF DATA TO ONE DTA-FILE WHICH CAN BE SAVED***
use 0_0_0_0_0_0_0_0, clear
foreach k of numlist `place_of_death'{
foreach l of numlist `years'{
foreach m of numlist `cause'{
foreach n of numlist `age'{
foreach o of numlist `sex'{	
foreach p of numlist `location_of_death'{

	merge 1:1 municiacutepio month using 0_0_`k'_`l'_`m'_`n'_`o'_`p', nogenerate	
}
}
}
}
}
}

	***** CHANGE SUFFIX HERE ****
// Saving the merged file to the relevant directory
// Which one d
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/master_years.dta, replace
*save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/master_suffix.dta, replace



** Deleting the dta files (can be done more elegantly with temp but I'll have to figure out its use later, but it basically executes this at the end of the do-loop
// All the locals are back to all of them to ensure all files are deleted, this will just give a lot of output that the files weren't found but the code does the job


local place_of_death 0 1
local years 0 1 2 3 14 15 16 17
local cause 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local age 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
local sex 0 1 2 3
local location_of_death 0 1 2 3 4 5 6


foreach k of numlist `place_of_death'{
foreach l of numlist `years'{
foreach m of numlist `cause'{
foreach n of numlist `age'{
foreach o of numlist `sex'{	
foreach p of numlist `location_of_death'{	
cap noi erase 0_0_`k'_`l'_`m'_`n'_`o'_`p'.dta
}
}
}
}
}
}
	

* capture {erase 0_0_`k'_`l'_`m'_`n'_`o'_`p'.dta}



******************************
***** // Here I have created something but I can't figure out what I was doing

// This seems to be the remaining new part, not sure yet, think I was looking for a more harmonious way to delete files//
local workdir ""/Users/arvidviaene/Documents/output""
cd `workdir'

local datafiles: dir "`workdir'" files "*.dta"

foreach datafile of `datafiles {
        rm `datafile'
}

* capture {erase 0_0_`k'_`l'_`m'_`n'_`o'_`p'.dta}


******************************







