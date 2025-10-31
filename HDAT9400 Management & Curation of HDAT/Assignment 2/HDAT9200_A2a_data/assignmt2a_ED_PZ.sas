/* Description: ED data cleaning */
/* Purpose: SAS code for data cleaning */
/* Written by Group 2a */
/* Date written 03/07/2023 */
/* Updated: 10/07/2023 */


************ Part B: Cleaning GP data ******;

* Step 1: Assign a library to later save a dataset from the session;
* NOTE: remember to change user ID to uXXXXXXX when running this code;
libname Ass2 "/home/u63441830/HDAT9400/Assignment2/group";
%include "/home/u63441830/HDAT9400/Assignment2/group/assignmt2a_formats.sas";

data ed_data;
set Ass2.assignmt2a_ed_data;
run;

* Step 2: Data Exploration*
*View the content of dataset;
proc contents data=ed_data;
run;

* Step 3: Summary statistics;
proc means data=ed_data n nmiss mean min max median range std;
run;

/*Step 4: Cleaning and Standardising the data according to data dictionary*/
data ed_data_cleaned_1;
	set ed_data;

	/* a) Data dictionary states that ed_admission date must be between 01/01/2014 and 31/12/2014 */
	if ed_admission < '01JAN2014'd or ed_admission > '31DEC2014'd then ed_admission = .;

	/* b) Data dictionary states that ed_separation date must be between 01/01/2014 and 31/12/2014 */
	if ed_separation < '01JAN2014'd or ed_separation > '31DEC2014'd then ed_separation = .;

	/* c) Clean sex_ed variable */
	if missing(sex_ed) then sex_ed_clean = .; /* Set missing if sex_ed is missing */
	else if sex_ed in ('Male', '1') then sex_ed_clean = 1;
	else if sex_ed in ('Female', '2') then sex_ed_clean = 2;
	else sex_ed_clean = .; /* Set missing if not Male or Female */

	/* d) Clean cob_ed variable */
	if missing(cob_ed) then cob_ed_clean = .; /* Set missing if cob_ed is missing */
	else if cob_ed in ('Australia', '1') then cob_ed_clean = 1;
	else if cob_ed in ('Overseas', '2') then cob_ed_clean = 2;
	else cob_ed_clean = .; /* Set missing if not Australia or Overseas */

	/* e) Clean interpreter variable */
	if missing(interpreter) then interpreter_clean = .; /* Set missing if interpreter is missing */
	else if interpreter in ('No', '0') then interpreter_clean = 0;
	else if interpreter in ('Yes', '1') then interpreter_clean = 1;
	else interpreter_clean = .; /* Set missing if not Yes or No */

	/* f) Clean health_insurance variable */
	if missing(health_insurance) then health_insurance_clean = .; /* Set missing if health_insurance is missing */
	else if health_insurance in ('No', '0') then health_insurance_clean = 0;
	else if health_insurance in ('Yes', '1') then health_insurance_clean = 1;
	else health_insurance_clean = .; /* Set missing if not Yes or No */

	/* g) Clean triage_category variable */
	if missing(triage_category) then triage_category_clean = .; /* Set missing if triage_category is missing */
	else if triage_category in ('Resuscitation', '1') then triage_category_clean = 1;
	else if triage_category in ('Emergency', '2') then triage_category_clean = 2;
	else if triage_category in ('Urgent', '3') then triage_category_clean = 3;
	else if triage_category in ('Semi urgent', '4') then triage_category_clean = 4;
	else if triage_category in ('Non urgent', '5') then triage_category_clean = 5;
	else triage_category_clean = .; /* Set missing if not a valid category */

	/* h) Clean separation_mode variable */
	if missing(separation_mode) then separation_mode_clean = .; /* Set missing if separation_mode is missing */
	else if separation_mode in ('Admitted to hospital', '1') then separation_mode_clean = 1;
	else if separation_mode in ('Departed ED', '2') then separation_mode_clean = 2;
	else if separation_mode in ('Died in ED', '3') then separation_mode_clean = 3;
	else if separation_mode in ('Dead on arrival', '4') then separation_mode_clean = 4;
	else separation_mode_clean = .; /* Set missing if not a valid mode */

run;


* Save the cleaned ED dataset as ED_data_cleaned_1.sas7bdat in the same folder;
libname output "/home/u63441830/HDAT9400/Assignment2/group";
data output.ed_data_cleaned_1;
   set ed_data_cleaned_1;
run;
* Clear the output library reference;
libname output clear;


*Step 5: After manulaay checked the quality of Standardising drop and rename edited columns;
data ed_data_cleaned_2;
set ed_data_cleaned_1; 
	drop sex_ed;
	drop cob_ed;
	drop interpreter;
	drop health_insurance;
	drop triage_category;
	drop separation_mode;
	rename sex_ed_clean = sex_ed;
	rename cob_ed_clean = cob_ed;
	rename interpreter_clean = interpreter;
	rename health_insurance_clean = health_insurance;
	rename triage_category_clean = triage_category;
	rename separation_mode_clean = separation_mode;
run;

* Save the cleaned ED dataset as ED_data_cleaned_2.sas7bdat in the same folder;
libname output "/home/u63441830/HDAT9400/Assignment2/group";
data output.ed_data_cleaned_2;
   set ed_data_cleaned_2;
run;
* Clear the output library reference;
libname output clear;

*Step 6: remove exact duplicates;
proc sort data=ed_data_cleaned_2  DUPOUT=ed_data_exact_dup_excl   NODUPKEY  OUT=ed_data_wo_exact_dup;
	BY _ALL_;
run;

* Save the cleaned ED dataset as ED_data_cleaned_3.sas7bdat in the same folder;
libname output "/home/u63441830/HDAT9400/Assignment2/group";
data output.ed_data_cleaned_3;
   set ed_data_wo_exact_dup;
run;
* Clear the output library reference;
libname output clear;



/* Step 1: Sort the original dataset (ed_data_cleaned_3) by ID */
proc sort data=Ass2.ed_data_cleaned_3;
  by id;
run;

/* Step 2: Remove duplicates based on id and age_ed */
data ed_data_cleaned_4 inconsistent_data_removed;
  set Ass2.ed_data_cleaned_3;
  by id;

  /* Step 3: Check if there are multiple rows of data with the same ID */
  if first.id then do;
    count = 1;
    flag_age = 0;
    flag_sex = 0;
    flag_cob = 0;
    age_ed_previous = age_ed;
    sex_ed_previous = sex_ed;
    cob_ed_previous = cob_ed;
  end;
  
  else do;
    count + 1;
    /* Check for inconsistent age_ed */
    if not missing(age_ed) and not missing(age_ed_previous) and age_ed ne age_ed_previous then do;
      flag_age = 1;
      output inconsistent_data_removed;
    end;

    /* Check for inconsistent sex_ed */
    else if not missing(sex_ed) and not missing(sex_ed_previous) and sex_ed ne sex_ed_previous then do;
      flag_sex = 1;
      output inconsistent_data_removed;
    end;

    /* Check for inconsistent cob_ed */
    else if not missing(cob_ed) and not missing(cob_ed_previous) and cob_ed ne cob_ed_previous then do;
      flag_cob = 1;
      output inconsistent_data_removed;
    end;
	
	else do;
		output ed_data_cleaned_4;
		age_ed_previous = age_ed;
		sex_ed_previous = sex_ed;
		cob_ed_previous = cob_ed;
	end;
  end;

  /* Step 4: Move data into appropriate datasets */
  if last.id then do;
    if count = 1 then output ed_data_cleaned_4;
    drop count flag_age flag_sex flag_cob age_ed_previous sex_ed_previous cob_ed_previous;
  end;

run;
