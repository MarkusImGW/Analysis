***********************************************************************************

* File: master_do.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
 
*Objective: The objective of this program is to create a masterfile that runs everything so I stay consistent between datasets

***********************************************************************************

********* Preliminaries *********
/*
cd "/Users/arvidviaene/Dropbox/2 Mortality/Analysis"

// Temperature
/*
// Note that the temperature files has a manual component with the excel file
1. Run data_climate_bigmerge_xstata.do in stata 14 on the original file with all the temperature files, this creates
** ?? What does this create. What is merged? 
 
2. Run setup_total_mergeclimate.do on the stored file, this creates "merged_climate_dataset_fips"
	!! This requires one manual step with the excel file "coding_missing_fips", which can be found in the intermediate file
3. Run the rest
*/
cd "/Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate"

*do data_climate_bigmerge_xstata // on stata 14
do setup_total_mergeclimate 
do BEST_generatemonthly // this is now where I cut off the years, change here to get t
//(Uses one dataset in which I linked up the municipality identifiers



********************************************************
******* Merging and Preparing the datasets *************
********************************************************

***** Brazil - Year/Month *****
do mort_brazil_tmf_allage_allyears
do pop_municipality_sex_age_year // same as the one below
do merge_pop_betweenyears // merges the population dta files with the mortality data and climate data has 5467 observations per municipality left

***** Municipality level - Year/Month level *****
// The next do-file call the mortality-file that has total, male and female montly data for 1997-2010.
do mort_tmf_total_97_10_monthly.do
// The next do-file calls the population-file that has the different brakedowns by age
do pop_municipality_sex_age_year.do
// The next do-file merges the data-sets created by the previous do-files, and the general climate dataset
do merge_monthly.do



************************
**** Analysis **********
************************
cd "/Users/arvidviaene/Dropbox/2 Mortality/Analysis"

***** Brazil - Year/Month *****




** do dataexploration_mort&pop_2009 // this investigates (superficially) some of the temperature data and mortality for Brazil

do table1_fixed_effects // Creates the results for different fixed effects
do table_monthly_gender // Creates the results for different genders on the data-set (with the specifications set within the do-file)

// Where is the do-file for lags, for the other effects?

