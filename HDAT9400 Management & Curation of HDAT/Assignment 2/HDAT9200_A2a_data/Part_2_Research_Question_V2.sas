/* Description: Research Questions */
/* Purpose: SAS code for Research Questions */
/* Written by Group 2a */
/* Date written 10/07/2023 */
/* Updated: 12/07/2023*/

/* 2.0 Prepare */
/* Step 1: Assign a library to later save a dataset from the session */
/* NOTE: remember to change user ID to uXXXXXXX when running this code */
libname Ass2 "/home/u63441830/HDAT9400/Assignment2/group";
%include "/home/u63441830/HDAT9400/Assignment2/group/assignmt2a_formats.sas";

/* Step 2: Read the dataset into a data step */
data gp_data;
	set Ass2.gp_data_new_variables;
run;

/* Step 3: List all the columns in the dataset */
proc contents data=gp_data;
run;

/* 1 Summary Statistics */
/* Step 1: Table 1 Generate the summary statistics table using PROC MEANS */
proc means data=gp_data n nmiss mean min max median std;
run;

/* 2 Socio-demographic Analysis */
/* Step 1: Sort the dataset by age */
proc sort data=gp_data;
  by age;
run;

/* Step 2: Create age groups */
data gp_data_age_groups;
  set gp_data;
  if age < 30 then age_group = 'Under 30';
  else if age < 40 then age_group = '30-39';
  else if age < 50 then age_group = '40-49';
  else if age < 60 then age_group = '50-59';
  else if age < 70 then age_group = '60-69';
  else age_group = '70 and above';
run;

/* Step 3: Calculate the distribution of variables within each age group */
proc freq data=gp_data_age_groups;
  tables age_group * sex;
  tables age_group * cob;
  tables age_group * healthcare_card;
  tables cob * healthcare_card / nocol norow;
run;


/* 3 Lifestyle Factors */
/* Step 1: Generate the smoke status by age group table using PROC FREQ */
proc freq data=gp_data_age_groups;
  where not missing(smoke_status_gp);
  tables smoke_status_gp * age_group / nocol norow;
run;

/* Step 2: Generate the smoke status by age group table using PROC FREQ */
proc freq data=gp_data_age_groups;
  tables smoke_status_gp * age_group / nocol norow nopercent;
run;

/* Step 3: Generate the smoke status by age group and sex table using PROC FREQ */
proc freq data=gp_data_age_groups;
  tables sex * smoke_status_gp/ nocol;
run;

/* Step 4: Average age at which patients started and stopped smoking */
proc means data=gp_data_age_groups mean;
  where ever_smoked = 1; /* Filter for patients who have ever smoked */
  var age_start age_stop;
run;



/*	Analysis of alcohol consumption */
/* Step 1: Distribution of the number of alcoholic drinks per day among age group and sex */
proc freq data=gp_data_age_groups;
	where sex in (1, 2) and not missing(drinks_day);
	tables age_group * sex * drinks_day / missing;
run;
/* Step 2: Percentage of patients engaging in risky alcohol consumption (>2 drinks per day) among age group and sex */
proc freq data=gp_data_age_groups;
  where drinks_day > 2;
  tables age_group * sex / missing nopercent missing;
run;

/* Step 3: Generate the risky_alcohol_GP by age group table using PROC FREQ */
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
proc reg data=gp_data_regression plots(maxpoints=10000);
  model highBP_GP = BMI_GP;
run;
