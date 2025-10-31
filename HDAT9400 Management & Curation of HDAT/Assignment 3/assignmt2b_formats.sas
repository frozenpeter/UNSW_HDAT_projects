
/* Formats for Assignment 2B */

proc format;
	value sexf
		1 = 'Male'
		2 = 'Female' 	;
	value cobf
		1 = 'Australia'
		2 = 'Overseas'	;
	value ynf
		1 = 'Yes'
		0 = 'No' 		;
	value triagef
	 	1 = 'Resuscitation'
		2 = 'Emergency'
		3 = 'Urgent'
		4 = 'Semi urgent'
		5 = 'Non urgent'	;
	value sepmodef
		1 = 'Admitted to hospital'
		2 = 'Departed ED'
		3 = 'Died in ED'
		4 = 'Dead on arrival'	;
	value Agegroup_GP
		1 = "Under 60 years old"
		2 = "60 years old and older";
		
	value ED_attended
		1 = "patients who did attend the ED in 2014"
		0 = "patients who did not attend the ED in 2014";
		
	value smoker_flag
		1 = "Yes, smoker"
		0 = "No";		
	value risky_alcohol_flag
		1 = "Yes, drinker"
		0 = "No";		
	value obesity_flag
		1 = "Yes, obese"
		0 = "No";		
		
	value smoker_ED
		1 = "Yes, smoker"
		0 = "No";		
	value risky_alcohol_ED
		1 = "Yes, drinker"
		0 = "No";		
	value obesity_ED
		1 = "Yes, obese"
		0 = "No";	
	value Agegroup_ED
		1 = "Under 60 years old"
		2 = "60 years old and older";
		
run;
