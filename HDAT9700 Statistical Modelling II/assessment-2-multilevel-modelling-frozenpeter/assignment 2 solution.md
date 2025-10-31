HDAT9700: Assessment 2 - Chapters 3-5
================
Mark Hanly
November 2024

## Section 1

### Question 1

*What is the hierarchical data structure for this analysis?*

This is a two-level hierarchy with 4,847 hospitals nested within 30
hospitals.

### Question 2

*With reference to appropriate Figure(s) or Table(s), discuss whether
the national-level hospitals are performing better or worse compared to
provincial-level hospitals for the five satisfaction measures, having
accounted for case-mix.*

Figure 2 from the paper (copied below) presents the hospital random
intercepts for five measures of satisfaction following case-mix
adjustment. The national-level hospitals are denoted NA, NB and NC.

<figure>
<img src="liu-2023-fig2.png"
alt="From Liu, Meicen, et al. Frontiers in Public Health 11 (2023)" />
<figcaption aria-hidden="true">From Liu, Meicen, et al. Frontiers in
Public Health 11 (2023)</figcaption>
</figure>

The ranking for the national hospitals can be summarised as follows.

- **Administrative process** NA and NB average \| NC above average
- **Hospital environment** NA and NB average \| NC above average
- **medical care** NA below average \| NB average \| NC above average
- **symptom management** NA, NB, and NC average, although the point
  estimate for NA is below zero and the point estimate for NC is above
  zero
- **overall satisfaction** NA below average \| NB average \| NC above
  average

We can conclude that the national hospital NC is performing above
average for most measures, whereas the other two hospitals are average
or even below average (for NA in particular) compared to the
provincial-level hospitals.

## Section 2

### Question 1.

*Undertake an exploratory data analysis of the available data*

The dataset provides records on 7,690 individuals clustered within 40
hospitals, with an median of 208 patients per hospital (inter-quartile
range (IQR): 108-254). This is a two level hierarchy with patients at
level 1 clustered within hospitals at level 2. Among the 40 hospitals 9
were Private Hospitals and the 31 were Public Hospitals. Most (17/40)
were situated in urban areas, with 12 hospitals in regional areas and 11
in remote areas. Satisfaction scores ranged from 16 to 96, with a median
of 50 (IQR: 42-59) (Figure 1A). Age ranged from 22 to 98 years, with a
median of 72 years (IQR: 64-80 years) (Figure 1B) and half of the sample
(3,826/7,690) were women. Length of stay ranged from 1 to 25 days with a
median of 3 days (IQR 2-5 days).

<img src="submission_files/figure-gfm/univariate-vis-1.png"  />

The exploratory analysis suggests that average satisfaction scores were
higher for woman (median=53) compared to men (median=46) (Figure 2A).
Satisfaction increases with age, although there appears to be a step
change around about age 70 (Figure 2B). Satisfaction scores were higher
among patients who were readmitted (median=54) compared to those who
were not readmitted (median=48) (Figure 2C). There was no strong
relationship between between length of stay and satisfaction (Figure
2D).

<img src="submission_files/figure-gfm/bivariate-eda-1.png"  />

Satisfaction was higher on average among patients attending private
hospitals (median=63) compared to public hospitals (median=47) and
higher among remote hospitals (median=69) compared to regional
(median=48) or urban hospitals (median=48). The overall distribution of
satisfaction scores was very similar in regional and urban areas.

The distribution of satisfaction scores varied considerably across the
40 hospitals, from a median score of 38 in hospital 1034 to a median
score of around 79 in hospital 1039 (Figure 3A). We can also see that
the Private hospitals tended to outperform Public hospitals (Figure 3A)
and that hospitals in Remote areas tended to outperform those in
Regional or Urban areas (Figure 3B).

#### Figure 3. Distribution of satisfaction scores by hospital and other hospital-level characteristics

<img src="submission_files/figure-gfm/hospital-eda-1.png"  />

In Figure 3C I have presented the distribution of satisfaction scored
ordered by hospital size. Here, hospital size is a newly derived
variable measuring the total number of admissions from each hospital in
the dataset. This figure shows that hospitals in Rural areas tend to be
smaller than those in regional and urban areas. Even within area, there
appears to be a negative association between hospital size and
satisfaction, with higher scores in smaller hospitals.

To summarise, satisfaction scores appear to be influenced by patients’
sex, age and readmission status, and by hospital status, size and
location.

Next, we can explore whether the relationships between patient-level
factors and satisfaction varies by hospital.

#### Figure 4. The relationship between sex and satisfaction scores by hospital

<img src="submission_files/figure-gfm/hosp-eda-sex-1.png"  />

The higher satisfaction scores for women compared to men appears to be
consistent across the 40 hospitals.

#### Figure 5. The relationship between age and satisfaction scores by hospital

<img src="submission_files/figure-gfm/hosp-eda-age-1.png"  />

The positive relationship between age and satisfaction, with a change
around age 70, appears to be consistent across the 40 hospitals.

#### Figure 6. The relationship between readmission and satisfaction scores by hospital

<img src="submission_files/figure-gfm/hosp-eda-rx-1.png"  />

The higher satisfaction scores for readmission appears to be higher in
some hospitals (e.g. 1009) compared to others, where there is almost no
gap (e.g. 1032).

### Question 2.

*Fit a series of multilevel models and select the best-fitting model for
the data*

Before proceeding with the modelling, I will standardised the continuous
variables of age and hospital size, to facilitate model estimation. The
distribution of satisfaction scores in Regional and Urban areas is very
similar so I will group these categories, creating a single dummy
variable that indicates Rural areas versus Regional/Urban. I was also
create a dummy variable for patients aged over 70 years to explore the
change around this time. As discussed above, this is a two level
hierarchy so I will fit a series of two-level models with patients at
level 1 and hospital at level 2. To start however, I will fit a null
single-level model (**Model 0**) and a null two-level model or variance
components model (**Model 1**) to support the choice of a multilevel
model (Table 1).

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">
Table 1. Modelling hospital satisfaction: comparison of empty single
level model to empty random intercept model
</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">
 
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 0
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 1
</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">
Predictors
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
CI
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Intercept
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
50.58
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
50.30 – 50.86
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
54.90
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
51.36 – 58.44
</td>
</tr>
<tr>
<td colspan="5" style="font-weight:bold; text-align:left; padding-top:.8em;">
Random Effects
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
σ<sup>2</sup>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
67.6
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
τ<sub>00</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
130.2 <sub>id</sub>
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
ICC
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.7
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
N
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40 <sub>id</sub>
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
Observations
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
AIC
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
60900.745
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
54454.849
</td>
</tr>
</table>

The comparison of the null single and multilevel models clearly supports
the use of a multilevel model for this dataset: there is a large drop in
AIC (60,901 to 54,455) and the Variance Partition Coefficient is 0.658
(i.e. $\frac{130.2}{67.6+130.2}$, indicating that 66% of the variation
in patient satisfaction scores is attributable to the hospital they were
admitted to.

The next stage of the modelling was to add patient and hospital level
covariates as fixed and random effects to build a series of more complex
models. First I fitted a model including all of the patient-specific
covariates (age, sex, length of stay and readmission status) as fixed
effects (**Model 2**). The estimated coefficient for length of stay was
non significant so I removed this (**Model 3**), which improved the
model fit, with a drop in AIC from 63,912 to 63,904. The exploratory
data analysis suggested a nonlinear association between age and
satisfaction. To reflect this I tested a quadratic term for age (**Model
4**). Comparing the AIC values for Models 4 to Model 3 indicates that
including the quadratic term for age improved the model, with the AIC
dropping from 49,100 to 49,085.

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">
Table 2. Multilvel models of hospital satisfaction
</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">
 
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 2
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 3
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 4
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 5
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Model 6
</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">
Predictors
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col7">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col8">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col9">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  0">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  1">
CI
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Intercept
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
57.28
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
53.68 – 60.87
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
57.28
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
53.68 – 60.87
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
57.06
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
53.46 – 60.65
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
60.51
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
59.84 – 61.18
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
60.60
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
60.08 – 61.12
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Age (standardised)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.00
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
3.87 – 4.14
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.00
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
3.87 – 4.13
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.11
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
3.97 – 4.25
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
4.11
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
3.98 – 4.25
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
4.11
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
3.98 – 4.25
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Sex = Male
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.22
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.48 – -6.96
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.22
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.48 – -6.96
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
-7.49 – -6.97
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
-7.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
-7.49 – -6.97
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
-7.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
-7.49 – -6.97
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Length of stay (standardised)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.02
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.15 – 0.11
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Readmission = Yes
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
5.44
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
5.13 – 5.74
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
5.44
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
5.13 – 5.74
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
5.44
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
5.14 – 5.74
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
5.44
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
5.14 – 5.74
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
5.40
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
4.86 – 5.94
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Age-squared
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.13 – 0.32
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
0.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
0.13 – 0.32
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
0.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
0.13 – 0.33
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Size (standardised)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
-6.75
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
-7.26 – -6.25
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
-6.55
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
-6.92 – -6.19
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Status = Public
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
-10.25
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
-10.98 – -9.52
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
-10.48
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
-11.05 – -9.91
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Remote
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
4.14
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
2.78 – 5.49
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
4.85
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
3.81 – 5.89
</td>
</tr>
<tr>
<td colspan="11" style="font-weight:bold; text-align:left; padding-top:.8em;">
Random Effects
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
σ<sup>2</sup>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
33.5
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
33.5
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
33.4
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
33.4
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
33.1
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
τ<sub>00</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
133.9 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
133.9 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
133.9 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.6 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.3 <sub>id</sub>
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
τ<sub>11</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
1.9 <sub>id.readmissionYes</sub>
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
ρ<sub>01</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
 
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.7 <sub>id</sub>
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
N
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40 <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40 <sub>id</sub>
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
Observations
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
AIC
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
49105.497
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
49100.041
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
49085.340
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
48892.376
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
48840.830
</td>
</tr>
</table>

Next I added the three hospital-specific variables, indicating size,
status and remote areas (**Model 5**). All three variables were
significant, reflected in a large drop in AIC. Finally, because the
exploratory analysis suggested that the effect of readmission varied
across hospitals, I added a random effect for the effect of readmission
(**Model 6**). The inclusion of this term was supported by the drop in
AIC from 48,892 to 48,840.

### Question 3.

*For your chosen model, check the model validity and communicate the
model results using appropriate visualisations*

The posterior estimates of the hospital-level random intercepts (Figure
7A) and random slopes for the effect of length of stay (Figure 7B) from
the final model for patient satisfaction are presented below. These
plots confirm that the random effects are reasonably normally
distributed, as expected (as there are only 40 higher level units, we
can expect and accept some slight deviations from normality).

#### Figure 7. Posterior estimates of the random intercepts and random slopes

<img src="submission_files/figure-gfm/random-effects-1.png"  />

Caterpillar plots for the hospital level random-intercepts (Figure 7C)
and random slope for readmission (Figure 7D) are also presented. These
plots reinforce the strong hospital-level effect on patient satisfaction
in this dataset, with some hospitals falling significantly below
(e.g. hospitals 1032 and 1007) and others falling significantly above
(e.g. hospitals 1006 and 1019) the average hospital performance. The
variable effect of readmission across hospitals can also be seen clearly
(Figure 4D), with effects that are considerably above average in some
hospitals (e.g. 1006) and below average in others (e.g. 1007). In Figure
8 below we can observe the positive covariance between the random
intercept and random slope terms. Note that hospitals with above average
baseline satisfaction tend to have an above average effect of
readmission (e.g 1019). Conversely, hospitals with below average
baseline satisfaction tend to have a below average effect of readmission
(e.g Hospital 1034).

#### Figure 8. The association between random intercept and random slope for Readmission

<img src="submission_files/figure-gfm/covar-1.png"  />

### Question 4.

*For your chosen model, provide a written interpretation of all of the
model parameters*

The final preferred model for patient satisfaction is a two-level
hierarchical multilevel model with 7,690 patients at level 1 and 40
hospitals at level 2. The fixed part of the model includes a patient’s
sex, a linear term for age and an additional indicator for age greater
than 70 years, and a binary indicator for whether or not the hospital
admission was a readmission. Hospital characteristics included the
hospital size (i.e. the number of admissions in the data source), status
(public or private) and a dummy indicator for hospitals in remote areas.
The random part of the model includes a random intercept for each
hospital and a random slope for the effect of readmission varying across
hospitals.

Table 3 below presents the model estimates. Recall that age and hospital
size are standardised so the baseline refers to the ‘average’ age and
hospital size, and a “one-unit change” corresponds to a one standard
deviation change in the scale of the unstandardised variable.

The model intercept indicates an average satisfaction score of 60.6 (95%
CI: 60.1, 61.1) for the baseline patient, a 72 year old female following
first admission to an averaged-sized private hospital in a regional or
urban area. Male patients return satisfaction scores that were 7.2
points lower on average (95% CI: -7.5, -7.0). Readmitted patients
returned satisfaction scores that were 5.4 points higher on average (95%
CI: 4.9, 5.9). Patients admitted to Public Hospitals returned scores
that were -10.5 points lower on average (95% CI: -11.0, -9.9). Finally,
patients admitted to hospitals in remote areas returned scores that were
4.8 points higher on average (95% CI: 3.8, 5.9).

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">
Table 3. Final model of patient satisfaction
</caption>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;nodv  text-align:left; ">
Predictors
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;nodv  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;nodv  ">
CI
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Intercept
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
60.6
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
60.1 – 61.1
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Age (standardised)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.1
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.0 – 4.2
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Age-squared
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.2
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.1 – 0.3
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Sex (Male)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.2
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-7.5 – -7.0
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Readmission = Yes
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
5.4
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.9 – 5.9
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Size (standardised)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-6.6
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-6.9 – -6.2
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Status = Public
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-10.5
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-11.0 – -9.9
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Remote
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
4.8
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
3.8 – 5.9
</td>
</tr>
<tr>
<td colspan="3" style="font-weight:bold; text-align:left; padding-top:.8em;">
Random Effects
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
σ<sup>2</sup>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
33.07
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
τ<sub>00</sub> <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.25
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
τ<sub>11</sub> <sub>id.readmissionYes</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
1.93
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
ρ<sub>01</sub> <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.75
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
N <sub>id</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
40
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
Observations
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
7690
</td>
</tr>
</table>

The residual within-hospital variance was 33.1. The between hospital
variance was 0.25 and combined with the grand mean intercept, this
indicates that the average satisfaction score for the ‘baseline
individual’ lies between 59.6 and 61.6 for 95% of hospitals
(i.e. $60.6 \pm  \sqrt{0.25} \times 1.96$). The estimated variance of
the effect of being readmitted across hospitals was 1.93, suggesting
that the change in satisfaction score associated with being admitted
ranged between 2.7 and 8.1 for 95% of hospitals
(i.e. $5.5 \pm  \sqrt{1.93} \times 1.96$). There was a positive
correlation between the random intercept for hospital and the random
slope for readmission (0.75), as seen in Figure 8. This reinforces that
hospitals with above average satisfaction scores had above average
effects of readmission. Put differently, the positive association
between readmission and satisfaction scores was stronger in hospitals
with higher satisfaction scores.

Figure 9 below presents hospital-specific predictions for patient
satisfaction by age, for baseline patients.

#### Figure 9. Hospital-specific predictions for patient satisfaction by age

<img src="submission_files/figure-gfm/predictions1-1.png"  />

The hospital specific random intercepts can be clearly seen, with the
positive association between age and satisfaction scores increasing
among older patients.

------------------------------------------------------------------------
