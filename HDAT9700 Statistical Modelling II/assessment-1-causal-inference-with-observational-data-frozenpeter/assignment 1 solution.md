HDAT9700: Assessment 1 - Chapters 1-2
================
Mark Hanly
October 2024

## Section 1

### Question 1: Draw a Directed Acyclic Graph (DAG)

The DAG below represents my assumptions about the causal relationship
between FNP Program participants and low birth weight (LBW, defined as
birthweight \<2,500g). The causal model implies that the FNP program
affects birthweight directly (FNP → LBW) and indirectly through the
mediating factors of antenatal care, maternal smoking during pregnancy
and nutrition).

<img src="myDAG.png" width="1518" style="display: block; margin: auto;" />

### Question 2: Highlight any non-causal or backdoor path(s) and potential variables that might be useful to close the path(s).

There are several backdoor paths represented in the DAG, including:

- FNP ← SES → LBW
- FNP ← Maternal age → LBW
- FNP ← Maltreatment → Stress → LBW
- FNP ← SES ← Ethnicity → LBW
- FNP ← Maternal age ← Ethnicity → LBW
- Ethnicity ← Maternal age ← Maternal age → LBW

These paths could be closed by controlling for maternal age, SES,
Ethnicity and Maltreatment. Age and ethnicity are (usually) relatively
easy to record. SES is more of a multifaceted construct that
incorporates factors like income, education, social class, and location.
Maltreatment is a difficult variable to record in many contexts.
Maltreatment often goes unreported or undisclosed and strict governance
protocols are necessary to join up statutory maltreatment reports with
other person-level data.

### Question 3: Describe the distribution of the propensity score for mothers who participated in the program and unexposed mothers.

The distribution of propensity scores for program participants and
non-participants is provided in Supplementary Figure 2 from the paper
and reproduced below.

![From Cavallaro et al (2023)](cavallaro-app-fig2.png) We can see that
estimated propensities are right-skewed for FNP participants and
non-participants, although more so for the participants, who have a
higher median propensity (0.39 versus 0.31). The propensities range from
0 to 1 for both groups, with overlap across this range, thus we can see
that the assumption of positivity is met, at least with respect to the
propensity score.

## Section 2

### Question 1: Undertake an exploratory analysis, using tables and/or figures to describe the distribution and key associations in the data.

The dataset includes observations for 11,174 mother-child pairs, of whom
1,787 (16%) participated in the FNP program. Maternal age ranged from 16
to 25 years with an median of 20 years (IQR=18-23), and participating
mothers were significantly younger compared to non-participants (mean =
18.1 years versus 20.9 years.) The population was 40% White, 14% South
Asian, 11% Black and 34% other backgrounds. Participants were less
likely to be White (29.3%) compared to non-Participants (44.3%).

    ## 
    ## --------Summary descriptives table by 'fnp'---------
    ## 
    ## ________________________________________________________________ 
    ##                    [ALL]          0            1       p.overall 
    ##                   N=11174       N=9387       N=1787              
    ## ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
    ## mat_age         20.5 (2.87)  20.9 (2.82)  18.1 (1.64)    0.000   
    ## ethnicity:                                              <0.001   
    ##     White       4677 (41.9%) 4154 (44.3%) 523 (29.3%)            
    ##     South Asian 1542 (13.8%) 1243 (13.2%) 299 (16.7%)            
    ##     Black       1192 (10.7%) 957 (10.2%)  235 (13.2%)            
    ##     Other       3763 (33.7%) 3033 (32.3%) 730 (40.9%)            
    ## deprivation     5.53 (2.86)  5.22 (2.82)  7.12 (2.54)   <0.001   
    ## bweight          3165 (305)   3191 (301)   3029 (290)   <0.001   
    ## lbw2:                                                    0.000   
    ##     No          9387 (84.0%) 9387 (100%)   0 (0.00%)             
    ##     Yes         1787 (16.0%)  0 (0.00%)   1787 (100%)            
    ## devVuln:                                                 0.078   
    ##     0           8837 (79.1%) 7452 (79.4%) 1385 (77.5%)           
    ##     1           2337 (20.9%) 1935 (20.6%) 402 (22.5%)            
    ## ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

The average deprivation score was 5.5 (SD=2.9), with significantly
higher deprivation scores for participants (7.1) compared to
non-participants (5.2). Birthweight was normally distributed
(mean=3,165g, SD=305g) and on average was significantly lower among
children of participating mothers (mean=3,029) compared to
non-participating mothers (mean=3,191g). Overall, 20.9% children in the
study population were developmentally vulnerable, with a slightly higher
prevalence of vulnerability in the participant group (22.5%) compared to
the non-participant group (20.6%).

![](submission_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### Question 2: Undertake matching to evaluate the effect of program participation on the risk of low birthweight.

In line with the Section 1, matching variables are those that
potentially close backdoor paths between program participation and the
outcome of low birth weight, i.e. maternal age, area deprivation and
ethnicity. Developmental vulnerability measured at age five causally
comes after both the exposure and the outcome, and as such we should not
include it for matching.

I will undertake four different matching approaches:

1.  Exact matching
2.  Coarsened exact matching
3.  1:1 Propensity score matching
4.  2:1 Propensity score matching with a calipers

#### Exact matching

``` r
match1 <- matchit(fnp ~ mat_age + deprivation + ethnicity,
                   method = 'exact',
                   data=df)
```

Exact matching matches 1,769 program participants to 4,727
non-participants. A total of 18 participants are excluded.

    ##                Control Treated
    ## All (ESS)     9387.000    1787
    ## All           9387.000    1787
    ## Matched (ESS) 1861.269    1769
    ## Matched       4727.000    1769
    ## Unmatched     4660.000      18
    ## Discarded        0.000       0

#### Coarsened exact matching

``` r
match2 <- matchit(fnp ~ mat_age + deprivation + ethnicity,
                   method = 'cem',
                   group = list(
                     ethnicity = list(c('White'), c('South Asian', 'Black', 'Other'))
                     ),
                  cutpoints = (list(
                    mat_age = c(16,18,20,22)
                  )),
                   data=df)
```

With some experimentation I found that coarsening maternal age to
two-year bands was sufficient to retain all program participants in the
analysis. There probably isn’t a huge difference between a 18 year old
and 19 year old participant (for example), so this seems like a
reasonable trade off. Here, 1,787 participants are matched to 4,953
participants.

    ##                Control Treated
    ## All (ESS)     9387.000    1787
    ## All           9387.000    1787
    ## Matched (ESS) 1923.036    1787
    ## Matched       4953.000    1787
    ## Unmatched     4434.000       0
    ## Discarded        0.000       0

#### Propensity score matching

``` r
match3 <- matchit(fnp ~ mat_age + deprivation + ethnicity,
                   method = 'nearest',
                   distance = 'glm',
                   ratio = 1,
                   data=df)
```

Propensity score matching successfully matches the 1,787 participants
with an equal number of non-participants, based on their estimated
probability of participation.

    ##               Control Treated
    ## All (ESS)        9387    1787
    ## All              9387    1787
    ## Matched (ESS)    1787    1787
    ## Matched          1787    1787
    ## Unmatched        7600       0
    ## Discarded           0       0

#### Propensity score matching (2:1 with caliper)

``` r
match4 <- matchit(fnp ~ mat_age + deprivation + ethnicity,
                   method = 'nearest',
                   distance = 'glm',
                   ratio = 2,
                   caliper = 0.5,
                   data=df)
```

Introducing the caliper here results in 23 treated individuals with no
match, while the remaining 1,764 participants are matched at a 2 to 1
ratio with 2,911 non-participants.

    ##                Control Treated
    ## All (ESS)     9387.000    1787
    ## All           9387.000    1787
    ## Matched (ESS) 2613.772    1764
    ## Matched       2911.000    1764
    ## Unmatched     6476.000      23
    ## Discarded        0.000       0

### Question 3: Summarise the balance in the dataset before and after matching using appropriate figues and/or tables.

The figure below compares the standardised mean difference for the three
matching variables of maternal age, ethnicity and deprivation before and
after each of the four matching approaches.

![](submission_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

It is clear that for all approaches, balance is improved in the matched
data. Exact matching achieves total balance in all variables, while
coarsened exact matching achieves close to exact balance without
dropping any participants. Some minor imbalance remains following both
propensity matching approaches.

### Question 4: Use an appropriate linear model to estimate the effect of program participation in (i) the raw data and (ii) the matched data.

Based on the observations above, I will complete this question using the
results from the coarsened exact matching approach. I will fit three
models with low birth weight as the outcome and FNP participation as the
exposure.

1.  A model using the raw data
2.  A model using the balanced dataset following coarsened exact
    matching
3.  A model using the balanced dataset following coarsened exact
    matching that additionally controls for maternal characteristics of
    age, ethnicity, and area-level deprivation. The outcome is binary so
    I will use logistic regression. The results are presented below.

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">
 
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">

1.  Original data
    </th>
    <th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">

    2.  CEM
        </th>
        <th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">

        3.  CEM + controls
            </th>
            </tr>
            <tr>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">
            Predictors
            </td>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
            Odds Ratios
            </td>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
            CI
            </td>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
            Odds Ratios
            </td>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
            CI
            </td>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
            Odds Ratios
            </td>
            <td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col7">
            CI
            </td>
            </tr>
            <tr>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
            FNP participation
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
            2.65
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
            1.89 – 3.67
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
            0.65
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
            0.47 – 0.87
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
            0.62
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
            0.45 – 0.83
            </td>
            </tr>
            <tr>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
            Observations
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
            11174
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
            6740
            </td>
            <td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
            6740
            </td>
            </tr>

</table>

Based on the raw data, the odds of being born low birthweight was 2.7
times higher (95% CI 1.9 - 3.7) among FNP program participants to
non-participants. The direction of effect switches in the matched
analysis, which gives an estimated odds ratio of 0.65 (0.47-0.87) and
reducing to 0.62 (0.45-0.83) when control variables are included in the
analysis model. This suggests that FNP program participation reduced the
odds of low birthweight by about 35%.

The difference in the estimated effect of program participation on low
birth weight suggests that the higher odds in Model 1 is an artifact of
the confounding leading to a different profile of background
characteristics among the program participants and non-participants. The
apparent negative effeect of the program on the risk of being born low
birth weight disappears once these background characteristics are
appropriately balanced.

### Question 5: What are the implications for the positivity and consistency assumptions in this example?

Positivity assumes that every levels of treatment has a positive
probability of occurring across every level of the confounding
variables. This assumption is not met in the whole sample with respect
to the variable of maternal age: FNP program participants were
restricted to ages 16-21. In the matching analysis, women aged 22 and
over are excluded from the analysis, and the estimates of program
effectiveness can not be applied to this group.

Consistency assumes that there is a single well-defined version of the
treatment. We can’t assess this from the data, but in practice there is
often variation in how real-world programs are delivered. Of interest,
in the Cavallaro paper, the authors state that

> Historically, FNP has been delivered in a similar way in England as
> the NFP is delivered in the USA (although more flexibility has been
> introduced in recent years). The licensing agreement stipulated that
> sites should follow a number of core model elements, so that the FNP
> could be replicated consistently, in order for the conditions upon
> which the previous evidence from the USA were based to be replicated.
> However, there are notable differences in eligibility criteria.

Clearly there is a concerted effort here to ensure some degree of
consistency. Variations to the “core model elements” could impact on the
consistency assumption and make it difficult to pinpoint what aspects of
the program contributed to positive outcome.
