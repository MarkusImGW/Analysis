/* 
Filename: Shackleton_VerFix.do 
Author: Anthony D'Agostino (ald2187@columbia.edu)
Date Created: 6/30/15
Last Edited: 7/1/15 
Purpose: Scans for all .DTAs in specified paths and generates backwards-compatible versions for use by Stata 11


Note: Since searches are conducted only on files within current directory, if you have DTAs to be processed outside, 
	- /ClimateData/cleaned/
	- /static_data/dta/
      then you first need to create new in/out paths and add the appropriate 'modVersion' command as at the end of the script.	


*/ 


clear
clear all 
set mem 3g 
set more off 


*****************************************
* Specify your 'Data' root path here: 
*****************************************

	loc dataPath  "/home/adagostino/D'Agostino_TimeUseIndia/Data/Raw/Data"
	
	
	**** Identify paths of interest and create paths for outputted files 
	
	loc climatePath "`dataPath'/ClimateData/cleaned" 
	loc climateOutPath "`climatePath'/Ver11" 
		cap mkdir "`climateOutPath'"    // create if does not exist 
	
	loc staticPath "`dataPath'/static_data/dta" 
	loc staticOutPath "`staticPath'/Ver11" 
		cap mkdir "`staticOutPath'"    // create if does not exist 
	
	
	
******************************	
* Define 'modVersion' function
* to be run for multiple paths
******************************	
	
	
cap program drop modVersion
program define modVersion
args inPath outPath prefix 
/*  modVersion scans <inPath> for all *.dta files and generates Version 11 compatible .dta's
    in <outPath> with the naming convention of /<outPath>/<prefix>_'filename'.dta  
    e.g., BEST_tavg_BIN_2C_3C.dta -> v11_BEST_tavg_BIN_2C_3C.dta
    
    inPath: string connoting path of Stata14 files
    outPath: string connoting destination path of processed, backwards-compatible files 
    prefix: string connoting preferred file prefix. 

*/	

	cd "`outPath'" 
	cap !rm *.dta   // kill any resident outpath files. 
	
	cd "`inPath'" 
	ashell find . -maxdepth 1 -name "*.dta" 
		forval x = 1/`r(no)' {
			loc fn = substr("`r(o`x')'", 3, .)    // drop the "./" which precedes return entries
			di "*** `fn' is currently being processed. ***"
			use "`r(o`x')'", clear 
			saveold "`outPath'/`prefix'_`fn'", version(11) replace 
		
		}
	

end 

	modVersion "`climatePath'" "`climateOutPath'" "v11"
	modVersion "`staticPath'" "`staticOutPath'" "v11" 
	
