********************************************
*** PURPOSE: Understanding how assignments are marked using Rubric 
*** AUTHOR: Zhenyu Zhang *** DATE: 2023-07-31 *** 
*** DATASETS
*** INPUTS: assignmt2b_gp_data.sas7bdat - Medical Plus general practice data (GP)
			assignmt2b_ed_data.sas7bdat - Emergency Department data (ED)
			assignmt2b_pbs_data.sas7bdat - Pharmaceutical Benefit Schemes data (PBS)
*** CREATED: person - hospital person-level data 


*** hosp_death - hospital person-level data wi
*** ********************************************;

/* Set up macro variable for the the assignment root folder */
%let root_folder = /home/u63441830/HDAT9400/Assignment3;

/* Set up libref 'original' (where raw data is stored) and set access to read-only */
%let original_data_folder = &root_folder/original;
libname original "&original_data_folder" access=readonly;

/* Set up libref 'cleaned', to store final cleaned analysis ready datasets */
%let cleaned_data_folder = &root_folder/cleaned;
libname cleaned "&cleaned_data_folder";

/* Set up libref 'permanent', to store final permanent datasets */
%let perm_data_folder = &root_folder/permanent;
libname perm "&perm_data_folder";

/* Set up macro variable for the working directory */
%let work_folder = &root_folder/work;
libname workdir "&work_folder";

/* Include provided formats SAS file that is located in the root folder */
%let format_file = &root_folder/assignmt2b_formats.sas;
%include "&format_file";


/* Preview */
* step 1: Load GP,ED and PBS data;
data workdir.gp_data;
	set original.assignmt2b_gp_data;
run;

data workdir.ed_data;
	set original.assignmt2b_ed_data;
run;

data workdir.pbs_data;
	set original.assignmt2b_pbs_data;
run;
* Step 2: Data exploration;
* Examine the contents of the given dataset;
proc contents data=workdir.gp_data;
run;

proc contents data=workdir.ed_data;
run;

proc contents data=workdir.pbs_data;
run;

* Step 3: Summary statistics;
proc means data=workdir.gp_data n nmiss mean min max median std;
run;

proc means data=workdir.ed_data n nmiss mean min max median std;
run;

proc means data=workdir.pbs_data n nmiss mean min max median std;
run;

* Set up macro variable for the the assignment root folder;
libname workdir "/home/u63441830/HDAT9400/Assignment3/work";
%include "/home/u63441830/HDAT9400/Assignment3/assignmt2b_formats.sas";

*************************************************************************** 
*** Research Question 1 (Primary care perspective) 
*** The Medical Plus GP is interested in knowing how many adult GP patients  
*** attended the local ED in 2014 and their characteristics. 
**************************************************************************;

/* 1.1. Create and label a new variable */
/* Read GP data into a new dataset gp_data*/
data workdir.gp_data;
	set original.assignmt2b_gp_data;
	
	/* Create the new variable Agegroup_GP */
	if age < 60 then Agegroup_GP = 1;
	else Agegroup_GP = 2;

run;

/*  option: apply format directly
	format Agegroup_GP Agegroup_GP_fmt.;
run;

proc format;
	value Agegroup_GP_fmt
	1 = 'Under 60 years old'
	2 = '60 years old and older';
run;
*/

/* 1.2. Calculate and report the proportion of GP patients who attended the ED in 2014. Comment on the findings. */
/* 1.2.1 count the number of GP patients who attended the ED */
/* Create dataset with only 2014 ED visits */
data workdir.ed_data;
    set original.assignmt2b_ed_data;
    where ed_admission >= '01JAN2014'd and ed_admission <= '31DEC2014'd; /* Filter data for 2014 */
run;

/* Count the total number of unique GP patients */
proc sql;
    select count(distinct ID) as total_GP
    into :total_GP
    from workdir.gp_data;
quit;

/* Count the number of unique GP patients who attended the ED in 2014 */
proc sql;
    select count(distinct ID) as GP_attended_ED
    into :GP_attended_ED
    from workdir.ed_data
    where ID in (select distinct ID from workdir.gp_data);
quit;

/* Calculate the proportion of GP patients who attended the ED in 2014 */
data _null_;
    proportion_GP_attended_ED = symget("GP_attended_ED") / symget("total_GP");
    put "Proportion of GP patients who attended the ED in 2014: " proportion_GP_attended_ED=percent9.2;
run;

/* 1.3. Calculate total number of monthly ED admissions for all GP patients. 
Create a figure to show monthly trends of ED admissions and interpret the findings. */
/* Extract month and year from ed_admission */
data workdir.monthly_ed_data;
    set workdir.ed_data;
    month_year = mdy(month(ed_admission), 1, year(ed_admission)); /* Create a new date variable where day is always 1 */
    format month_year monyy7.; /* Format month_year as month and year without day */
run;

/* Calculate total number of monthly ED admissions */
proc sql;
    create table monthly_ed_admissions as 
    select month_year, count(ID) as total_admissions
    from workdir.monthly_ed_data
    where ID in (select distinct ID from workdir.gp_data)
    group by month_year;
quit;

proc sql;
    create table ed_admissions2 as 
    select month_year, count(ID) as total_admissions
    from workdir.monthly_ed_data
    group by month_year;
quit;

proc print data=monthly_ed_admissions; 
run;

/* Create line plot of monthly trends */
proc sgplot data=monthly_ed_admissions;
    series x=month_year y=total_admissions / markers;
    xaxis display=(nolabel);
    yaxis label='Total ED Admissions';
    title 'Monthly Trends of ED Admissions';
run;

/* 1.4. Create a table showing differences between patients who did and did not attend the ED in 2014 in terms of socio-demographic characteristics 
[sex, age group, country of birth, and health care card] and health-related factors [smoking, risky alcohol consumption, obesity, and high blood pressure]. 
Comment on the findings. */
/* Add a new variable 'ED_attended'  */
proc sql;
    create table workdir.ed_attended_gp_data as
    select a.*, 
           (case when b.ID is not null then 1 else 0 end) as ED_attended
    from workdir.gp_data a
    left join (select distinct ID from workdir.ed_data) b
    on a.ID = b.ID;
quit;

/* Overwrite gp_data with the temporary dataset 
data workdir.gp_data;
    set workdir.ed_attended_gp_data;
run;
*/

/* Create a table for comparing the socio-demographic characteristics */
/* For categorical variables (like sex, Agegroup_GP, cob and healthcare_card), use PROC FREQ. For numerical variables like age, use PROC MEANS. */
/* Use PROC FREQ to get frequencies of categorical variables by ED_attended group, the variable in the TABLE statement can be changed to the ones want to be compared */
proc freq data=workdir.ed_attended_gp_data;
    tables ED_attended*sex ED_attended*Agegroup_GP ED_attended*cob ED_attended*healthcare_card/ chisq;
run;

/* Use PROC MEANS to get descriptive statistics of numerical variables by ED_attended group */
proc means data=workdir.ed_attended_gp_data;
    class ED_attended;
    var age BMI_GP;
    output out=table mean= / autoname;
run;

/* Use PROC CORR to get the point-biserial correlation coefficient is a correlation measure between a binary variable (ED_attended) and a continuous variable */
proc corr data=workdir.ed_attended_gp_data;
    var ED_attended age;
run;

proc corr data=workdir.ed_attended_gp_data;
    var ED_attended BMI_GP;
run;

/* Use PROC TTEST to get  the t-tes of age and BMI by ED_attended group */
proc ttest data=workdir.ed_attended_gp_data;
    class ED_attended;
    var age;
run;

proc ttest data=workdir.ed_attended_gp_data;
    class ED_attended;
    var BMI_GP;
run;

/* Create a table for comparing the health-related factors */
/* Change the variable in the TABLE statement to the ones want to be compared */
proc freq data=workdir.ed_attended_gp_data;
	tables ED_attended*Smoke_current_GP ED_attended*Risky_alcohol_GP ED_attended*Obese_GP ED_attended*HighBP_GP/ chisq;
run;

/* 1.5. Among GP patients who visited the ED, calculate the total number of ED admission for each person in 2014. 
Describe the distribution of numbers of ED admission using a histogram and descriptive statistics. Comment on the findings. */
/* calculate the total number of ED admissions for each GP patient in 2014 */
proc sql;
    create table ED_admissions_number as 
    select ID, count(ed_admission) as ED_visits
    from workdir.ed_data
    where ID in (select distinct ID from workdir.ed_attended_gp_data)
    group by ID;
quit;

/* draw the histogram (with a normal distribution curve) and get the descriptive statistics of ED visit times among GP patients in 2014 */
proc univariate data=ED_admissions_number;
    var ED_visits;
    histogram ED_visits / midpoints = 1 to 18 by 1 barlabel=count normal; 
    title 'Distribution of ED visit times among GP patients';
run;

/* 1.6. Continue with the results of step 1.5, select GP patients who had many ED visits (i.e. top 25% percentile). 
Examine and report socio-demographic and health-related characteristics of these patients. */
/* In previous results, 75% Q3 quantiles (6) boundary for the top 25% for the number of ED visits */
data workdir.gp_data_high_visits;
    merge workdir.ed_attended_gp_data(in=a) ED_admissions_number(in=b);
    by ID;
    if a and b and ED_visits >= 6;
run;

proc freq data=workdir.gp_data_high_visits;
    tables sex Agegroup_GP cob healthcare_card Smoke_current_GP Risky_alcohol_GP Obese_GP HighBP_GP;
run;

proc means data=workdir.gp_data_high_visits;
    var age BMI_GP;
run;

*************************************************************************** 
*** Research Question 2 (ED care perspective) 
*** The Sunnydale ED examines the quality of recording of adult patient smoking, 
*** risky alcohol consumption and obesity in the ED data, using the ICD-10-AM. 
**************************************************************************;
/* 2.1. Create three variables to flag ED records with these behaviours being recorded in any diagnosis field */
data workdir.flaged_ed_data;
    set workdir.ed_data;

    /* Flag for smoker */
    if dx1 in ('F17', 'Z72') or dx2 in ('F17', 'Z72') or dx3 in ('F17', 'Z72') or 
       dx4 in ('F17', 'Z72') or dx5 in ('F17', 'Z72') then smoker_flag = 1;
    else smoker_flag = 0;

    /* Flag for risky alcohol consumption */
    if dx1 = 'F10' or dx2 = 'F10' or dx3 = 'F10' or dx4 = 'F10' or dx5 = 'F10' then risky_alcohol_flag = 1;
    else risky_alcohol_flag = 0;

    /* Flag for obesity */
    if dx1 = 'E66' or dx2 = 'E66' or dx3 = 'E66' or dx4 = 'E66' or dx5 = 'E66' then obesity_flag = 1;
    else obesity_flag = 0;

run;

/* Optionally, use PROC PRINT to inspect the first few records to ensure the flags have been added correctly. 
proc print data=workdir.flaged_ed_data (obs=100);
run;
*/

/* 2.2.	Classify whether the patient smokes, drinks alcohol at risky level or is obese, if these risk factors are recorded in any ED records for a patient.
 Calculate and report the prevalence of smoking, risky alcohol consumption and obesity among ED patients */

/* Checking for discrepancies */
proc sort data=workdir.flaged_ed_data; 
    by ID age_ed sex_ed cob_ed interpreter health_insurance; 
run;

data check;
    set workdir.flaged_ed_data;
    by ID;

    if first.ID and last.ID then single_record=1;
    else single_record=0;
run;

proc freq data=check;
    tables single_record;
run;

/* Removing duplicates 
proc sort data=workdir.flaged_ed_data nodupkey; 
    by ID; 
run;
*/

/* Aggregating data at the patient level */
proc sql;
    create table aggregated_ed_data as
    select distinct /* or using select distinct insteat of select to remove duplicates */
        ID, sex_ed, cob_ed, interpreter, health_insurance,
        max(age_ed) as current_age_ed, /* Keeping the maximum age as current age for each patient */
        max(smoker_flag) as smoker_flag_aggregated,
        max(risky_alcohol_flag) as risky_alcohol_flag_aggregated,
        max(obesity_flag) as obesity_flag_aggregated
    from workdir.flaged_ed_data
    group by ID;
quit;

data workdir.aggregated_ed_data;
    set aggregated_ed_data;
run;

/* Classifying patients */
data workdir.classified_ed_data;
    set aggregated_ed_data;

    /* Classification for smokers */
    if smoker_flag_aggregated = 1 then smoker_ED = 1;
    else smoker_ED = 0;

    /* Classification for risky alcohol consumption */
    if risky_alcohol_flag_aggregated = 1 then risky_alcohol_ED = 1;
    else risky_alcohol_ED = 0;

    /* Classification for obesity */
    if obesity_flag_aggregated = 1 then obesity_ED = 1;
    else obesity_ED = 0;
run;

************************************************************; 
/* Checking for discrepancies again and create a new table */
proc sort data=workdir.classified_ed_data; 
    by ID current_age_ed sex_ed cob_ed interpreter health_insurance; 
run;

data check;
    set workdir.classified_ed_data;
    by ID;

    if first.ID and last.ID then single_record=1;
    else single_record=0;
run;

proc freq data=check;
    tables single_record;
run;

data workdir.dup_classified_ed_data; /* Creating a dataset with duplicates */
    set check;
    if single_record = 0;
run;

/* many duplicates is due to 1 year age difference, which is logically normal, Checking for discrepancies again and create a new table*/
proc sort data=workdir.classified_ed_data; 
    by ID age_ed sex_ed cob_ed interpreter health_insurance; 
run;

data check_age_difference_less_1;
    set workdir.classified_ed_data;
    by ID;

    if first.ID and last.ID then single_record=1;
    else single_record=0;
    
    retain prev_age_ed;

    if first.ID then prev_age_ed = age_ed;
    
    if single_record = 0 then do;
        if abs(age_ed - prev_age_ed) <= 1 then single_record = 1;
        else single_record = 0;
    end;
    
    prev_age_ed = age_ed;    
run;

proc freq data=check_age_difference_less_1;
    tables single_record ;
run;

/* Creating a dataset with duplicates */
data workdir.dup_classified_ed_data_2;
    set check_age_difference_less_1;
    if single_record = 0;
run;

/* Based on results all the duplicates is due to 1 year age difference,thus will only keep max age in classified_ed_data */
****************************************************;

/* Calculate and report the prevalence */
proc freq data=workdir.classified_ed_data;
    tables smoker_ED risky_alcohol_ED obesity_ED;
run;

/* Save workdir.classified_ed_data as classified_ed_data.sas7bdat in the work directory */
data classified_ed_data;
    set workdir.classified_ed_data;
run; 

/* 2.3.	Examine whether there are any differences between ED patients who did and did not visit a GP
 in terms of sex, age, country of birth, private health insurance, smoking, risky alcohol consumption and obesity. */
/* 2.3.1 Merge gp_data and classified_ed_data datasets on the ID variable. */
data workdir.gp_attended_ed_data;
    merge workdir.gp_data (in=a) classified_ed_data (in=b);
    by ID;
    if b; /* Keep only records that exist in classified_ed_data */
    
    /* Create the GP_attended variable */
    if a then GP_attended = 1;
    else GP_attended = 0;
run;

data gp_attended_ed_data;
    set workdir.gp_attended_ed_data;
run; 

/* check the number. */
PROC FREQ data=workdir.gp_attended_ed_data;
    tables GP_attended / nocum;
RUN;

/* 2.3.2 Categorize the age into two groups: under 60 and 60 & older. */
data workdir.gp_attended_ed_data;
    set workdir.gp_attended_ed_data;
    if current_age_ed < 60 then Agegroup_ED = 1;
    else Agegroup_ED = 2;
run;

/* 2.3.3 Use PROC FREQ or PROC MEANS (for continuous variables like age) to compare the groups who did and didn't visit a GP in terms of the variables of interest. */
proc freq data=workdir.gp_attended_ed_data;
    tables GP_attended*sex_ed GP_attended*cob_ed GP_attended*healthcare_card GP_attended*health_insurance
           GP_attended*smoker_ED GP_attended*risky_alcohol_ED GP_attended*obesity_ED 
           GP_attended*Agegroup_ED / chisq;
run;

proc means data=workdir.gp_attended_ed_data;
    class GP_attended;
    var current_age_ed;
    output out=age_comparison mean= / autoname;
run;


/* 2.4.	Calculate overall sensitivity (Sn) and specificity (Sp) of the recording of patient smoking in the ED data,
 using patient smoking information in the GP data as the gold standard. */
proc freq data=gp_attended_ed_data;
    tables Smoke_current_GP*smoker_ED / chisq;
    ods output chisq = chisq_output;
run;

/* 2.5.	Repeat calculation of Sn and Sp of the recording of smoking in ED data, separately for each patient’s sex, age group, cob and private health insurance
 (i.e. stratified by sociodemographic factors). */
/* 2.5.1 Sensitivity and Specificity by Sex */
/* check data type */
proc contents data=workdir.gp_attended_ed_data;
run;

/* Sort the dataset by sex_ed */
proc sort data=workdir.gp_attended_ed_data;
    by sex_ed;
run;

/* compute the Sensitivity (Sn) and Specificity (Sp) for the variables Smoke_current_GP and smoker_ED by sex */
proc freq data=workdir.gp_attended_ed_data;
    tables Smoke_current_GP*smoker_ED / chisq;
    by sex_ed;
run;

/* 2.5.2 Sensitivity and Specificity by Age Group */
/* Sort the dataset by Agegroup_ED */
proc sort data=workdir.gp_attended_ed_data;
    by Agegroup_ED;
run;

/* compute the Sensitivity (Sn) and Specificity (Sp) for the variables Smoke_current_GP and smoker_ED by Agegroup_ED */
proc freq data=workdir.gp_attended_ed_data;
    tables Smoke_current_GP*smoker_ED / chisq;
    by Agegroup_ED;
run;

/* 2.5.3 Sensitivity and Specificity by Country of Birth */
/* Sort the dataset by cob_ed */
proc sort data=workdir.gp_attended_ed_data;
    by cob_ed;
run;

/* compute the Sensitivity (Sn) and Specificity (Sp) for the variables Smoke_current_GP and smoker_ED by cob_ed */
proc freq data=workdir.gp_attended_ed_data;
    tables Smoke_current_GP*smoker_ED / chisq;
    by cob_ed;
run;

/* 2.5.4 Sensitivity and Specificity by Private Health Insurance */
/* Sort the dataset by health_insurance */
proc sort data=workdir.gp_attended_ed_data;
    by health_insurance;
run;

/* compute the Sensitivity (Sn) and Specificity (Sp) for the variables Smoke_current_GP and smoker_ED by health_insurance */
proc freq data=workdir.gp_attended_ed_data;
    tables Smoke_current_GP*smoker_ED / chisq;
    by health_insurance;
run;

*************************************************************************** 
*** Research Question 3 (Tobacco control perspective) 
*** assesses the baseline uptake of smoking cessation medicines using PBS data linked to GP and ED data.
*** Information about Sunnydale residents who had a dispensing of a smoking cessation medicine is contained in the PBS data,  
*** with medicines coded using Anatomical Therapeutic Chemical (ATC) classification. 
**************************************************************************;
/* 3.1.	Create a cohort of Sunnydale residents who smoke using information from the GP and ED data sources. 
How many smokers could you identify in the GP data alone, ED data alone, and using a combination of both GP/ED data sources. */
data workdir.gp_ed_smoker_merge_data;
    merge workdir.ed_attended_gp_data (in=a) classified_ed_data (in=b);
    by ID;

    /* Keep only smokers based on conditions */
    if smoker_ED = 1 or Smoke_current_GP = 1;
run;

data workdir.gp_ed_smoker_merge_data;
    set workdir.gp_ed_smoker_merge_data;
run;

/* check if at least one of Smoke_current_GP and smoker_ED variable = 1 */
proc sql;
    select count(*) as Count
    from workdir.gp_ed_smoker_merge_data
    where Smoke_current_GP = 1 or smoker_ED = 1;
quit;


/* 3.2.	Examine PBS data against the cohort defined in Step 3.1 and comment on the value of PBS data as an additional data source 
(i.e. on top of GP and ED data) to identify people who smoke and who were not identified in GP or ED data. */
/* Read and check PBS data */
data workdir.pbs_data;
	set original.assignmt2b_pbs_data;
run;

proc contents data=workdir.pbs_data;
run;

/* Identify smokers in PBS data based on smoking cessation medicines and add flags for the smoking cessation medicines*/
data workdir.pbs_flagged;
    set workdir.pbs_data;
    
    /* Initialize the flags */
	OtherACT = 0;
    Smoking_Cessation_Therapy = 0;
    NRT_patches = 0;
    Bupropion = 0;
    Varenicline = 0;
        
    /* Identify people based on the ATC codes for the smoking cessation medicines */
    if ATC in ("N07BA01", "N06AX12", "N07BA03") then Smoking_Cessation_Therapy = 1;
	else OtherACT = 1;
    /* Identify which specific therapy they used */
    if ATC = 'N07BA01' then NRT_patches = 1;
    else if ATC = 'N06AX12' then Bupropion = 1;
    else if ATC = 'N07BA03' then Varenicline = 1;    
run;

/* Filter for 2014 (if needed)
data workdir.pbs_flagged;
    set workdir.pbs_flagged;
    if year(supply_date) = 2014;
run;
*/

/*  check the number of unique IDs */
proc sql;
    select count(distinct ID) as Unique_ID_Count
    from workdir.pbs_flagged;
quit;

/* Aggregate to remove duplicates and keep maximum flag values */
proc sql;
    create table workdir.pbs_smokers as 
    select 
        ID, 
        max(OtherACT) as OtherACT,
        max(Smoking_Cessation_Therapy) as Smoking_Cessation_Therapy,
        max(NRT_patches) as NRT_patches,
        max(Bupropion) as Bupropion,
        max(Varenicline) as Varenicline
    from workdir.pbs_flagged
    group by ID;
quit;

proc contents data=workdir.pbs_smokers;
run;

/* Merge the PBS smokers with the GP and ED smoker cohort into a Sunnydale’s smoker cohort*/
data workdir.sunnydale_smoker;
    merge workdir.gp_ed_smoker_merge_data(in=a) workdir.pbs_smokers(in=b);
    by ID;
run;

/* crosstabulation of smoker identified from three data set */
proc freq data=workdir.sunnydale_smoker;
    tables smoker_ED*Smoke_current_GP*Smoking_Cessation_Therapy / list MISSING; /* The MISSING option includes missing values in frequency and crosstabulation tables */
run;

/* 3.3.	For the cohort created in Step 3.1, calculate the proportion of smokers who used any of the smoking cessation therapies, 
as well as each of the three individual medicine in 2014. Comment on your findings. */

/* Filter for smoker */
data workdir.filtered_sunnydale_smoker;
    set workdir.sunnydale_smoker;
    /* Check if at least one of the smoker flags is 1 */
    if smoker_ED = 1 or Smoke_current_GP = 1 or Smoking_Cessation_Therapy = 1;
run;

data workdir.filtered_sunnydale_smoker;
	set workdir.filtered_sunnydale_smoker;
run;

data workdir.PBS_attened_sunnydale_smoker;
    set workdir.filtered_sunnydale_smoker;
    /* Check if at least one of the smoker flags is 1 */
    if Smoking_Cessation_Therapy = 1;
run;

data workdir.PBS_attened_sunnydale_smoker;
	set workdir.PBS_attened_sunnydale_smoker;
run;

proc freq data=workdir.filtered_sunnydale_smoker;
    tables Smoking_Cessation_Therapy NRT_patches Bupropion Varenicline / nocum nopercent;
run;

proc freq data=workdir.PBS_attened_sunnydale_smoker;
    tables Smoking_Cessation_Therapy NRT_patches Bupropion Varenicline / nocum nopercent;
run;


