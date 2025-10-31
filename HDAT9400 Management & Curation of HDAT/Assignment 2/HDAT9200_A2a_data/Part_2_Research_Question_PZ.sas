/* Description: Research Questions */
/* Purpose: SAS code for Research Questions */
/* Written by Group 2a */
/* Date written 10/07/2023 */
/* Updated: 12/07/2023*/


* Step 1: Assign a library to later save a dataset from the session;
* NOTE: remember to change user ID to uXXXXXXX when running this code;
libname Ass2 "/home/u63441830/HDAT9400/Assignment2/group";
%include "/home/u63441830/HDAT9400/Assignment2/group/assignmt2a_formats.sas";

/* Step 2: Read the dataset into a data step */
data gp_data;
	set Ass2.gp_data_new_variables;
run;

/* Step 3: List all the columns in the dataset */
proc contents data=gp_data;
run;

/* Step 4: Table 1 Generate the summary statistics table using PROC MEANS */
proc means data=gp_data n nmiss mean min max median std;
run;

/* Step 5: Table 2 Smoke Status by Age Group */
/* Step 5.1: Sort the dataset by age */
proc sort data=gp_data;
  by age;
run;

/* Step 5.2: Create age groups */
data gp_data_age_groups;
  set gp_data;
  if age < 30 then age_group = 'Under 30';
  else if age < 40 then age_group = '30-39';
  else if age < 50 then age_group = '40-49';
  else if age < 60 then age_group = '50-59';
  else if age < 70 then age_group = '60-69';
  else age_group = '70 and above';
run;

/* Step 5.3: Generate the smoke status by age group table using PROC FREQ */
proc freq data=gp_data_age_groups;
  tables smoke_status_gp * age_group / nocol norow nopercent;
run;


/* Step 6: Table 3 Risky Alcohol Consumption by Age Group */
/* Step 6.1: Generate the risky_alcohol_GP by age group table using PROC FREQ */
proc freq data=gp_data_age_groups;
  tables risky_alcohol_GP * age_group / nocol norow nopercent;
run;


/* Step 7: Table 4 Prevalence of Obesity and High Blood Pressure */
/* Step 7.1: Create BMI groups and handle missing values */
data gp_data_bmi_groups;
  set gp_data;
  if missing(BMI_GP) then bmi_group = 'Missing';
  else if BMI_GP < 18.5 then bmi_group = 'Underweight';
  else if BMI_GP < 25 then bmi_group = 'Standard';
  else if BMI_GP < 30 then bmi_group = 'Overweight';
  else bmi_group = 'Obesity';
run;

/* Step 7.2: Calculate the prevalence of BMI groups and high blood pressure using PROC FREQ */
proc freq data=gp_data_bmi_groups;
  tables bmi_group * highBP_GP / nocol norow nopercent missing;
run;

/* Step 7.3: Perform Linear regression analysis */
/* Option 1: Removing missing values */
data gp_data_regression;
  set gp_data;
  if not missing(highBP_GP) and not missing(BMI_GP);
run;
proc reg data=gp_data_regression plots(maxpoints=100000);
  model highBP_GP = BMI_GP;
run;
