HDAT9700: Assessment 3 - Chapters 7-8
================
Mark Hanly
December 2024

## Section 1

### Q1. Describe the pre-intervention time series of total firearm deaths per 100,000 people (Figure 1a) in terms of trend and seasonality.

<figure>
<img src="ukert-2018-fig1a.png" alt="Figure 1A from Ukert (2018)" />
<figcaption aria-hidden="true">Figure 1A from Ukert (2018)</figcaption>
</figure>

Figure 1a from Ukert (2018) shows an overall downward trend in total
firearm mortality per 100,000 people in Australia between 1978 and 1996.
In 1978, there were around 4.3 firearm deaths per 100,000 people,
declining to around 2.7 deaths per 100,000 in 1996. The gradual downward
trend is reasonably consistent throughout this period, except for the
mid-to-late 80s where the rates were constant between around 4.1 and 4.3
deaths per 100,000 people.

Because these are annual data, seasonality cannot be detected here.

### Q2. In your own words, summarise what it means and what the purpose of (i) taking the first difference and (ii) including an autoregressive order 1.

The first difference of a time series is the difference between
consecutive observations. This is done to remove the trend from the
data, which is one step in achieving a stationary series.

An autoregressive model of order 1 (AR(1)) is a model that predicts the
value of a time series at time $t$ based on the value of the series at
time $t-1$. This is done to account for the autocorrelation in the data,
which is the correlation between observations at different time points.
In this case, the AR(1) model is used to account for the fact that the
value of the time series at time $t$ is likely to be related to the
value of the series at time $t-1$.

### Q3. Explain in your own words (i) what is the role of the robustness check, (ii) how is it implemented, and (iii) what is the interpretation.

The role of the robustness check here is to test whether changes in
firearm mortality rate can be attributed to the introduction of the 1996
firearm law. This is done by running a series of models with fictitious
intervention dates for years preceding the policy change, from 1990 to
1995. The robustness check shows that for the ARIMA model, the only
model that shows a significant effect is the one where the true
intervention date is modelled, with the results from the models with
fictitious intervention dates being non-significant. This suggests that
the results from the ARIMA model are robust to changes in the
intervention date. In contrast, the same robustness check applied to the
negative binomial model finds “significant” impacts even for the
fictitious intervention dates, suggesting that the negative binomial
model is not satisfactorily capturing the trend and autocorrelation in
the time series.

## Section 2

### Q1. Create a plot of the homicide rate over time

![](submission_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

### Q2. Describe the homicide rate time series in terms of the trend, seasonality, and outliers

Overall, the median homicide rate per 100,000 population per month was
0.50 (interquartile range, 0.46 to 0.56).

- *Trend*: The homicide rate was relatively constant prior to the
  intervention. After the intervention in October 2005, it started to
  increase until the end of the study period in December 2007. Looking
  at the seasonal plot, the homicide rate is mostly highest in 2007, at
  the end of the series post-intervention. This suggests that the change
  in the homicide rate post-intervention might best be described by a
  change in slope.

- *Seasonality*: The homicide rate appears lowest in February of each
  year, but no other clear patterns are observed during the rest of the
  year. The median value in February was 0.44 per 100,000, while it was
  highest in July (median=0.56). Given this, we will consider including
  seasonality in our regression models.

- *Outliers*: Looking at the seasonal plot, February 2005 (0.31
  homicides per 100,000) is lower than all other values. In contrast,
  the homicide rate in July 2008 is highest (0.78 homicides per
  100,000). However, in the “random” panel of the decomposition plot
  these values don’t appear quite as extreme suggesting it may be partly
  due to seasonal effects. Given this, and the lack of any prior
  evidence that there was anything different about these months, we will
  leave them as is.

![](submission_files/figure-gfm/q2_1-1.png)<!-- -->![](submission_files/figure-gfm/q2_1-2.png)<!-- -->

### Q3. Estimate the effect of the stand-your-ground law using segmented regression and ARIMA.

#### Segmented regression

Starting with segmented regression, I will fit two models:

- **Model 1** - hom_rate ~ time + syg + time.after + month
- **Model 2** - hom_rate ~ time + syg.lag1 + time.after.lag1 + month

Here, `time` is the time since start of the study, `syg` is an indicator
for the “Stand-your-ground” law (before=0, after=1), `time.after` is the
time since the law was implemented and `month` is a monthly dummy
variable. The second model tests for a delayed effect of the policy
change: `syg.lag1` and `time.after.lag1` are `syg` and `time.after`
delayed/lagged by one month.

The two models are presented below.

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">
 
</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Dependent variable
</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Dependent variable
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
p
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col7">
p
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
(Intercept)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.5018
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.4562 – 0.5473
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>\<0.001</strong>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.5009
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.4556 – 0.5461
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>\<0.001</strong>
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
time
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0004
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0011 – 0.0003
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.230
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0004
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0010 – 0.0003
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.242
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
syg
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0472
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0032 – 0.0975
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.066
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
time after
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0040
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0013 – 0.0068
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>0.005</strong>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthJan
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0212
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0328 – 0.0752
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.437
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0209
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0330 – 0.0749
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.442
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthFeb
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0683
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.1223 – -0.0143
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>0.014</strong>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0685
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.1224 – -0.0146
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>0.013</strong>
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthMar
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0380
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0919 – 0.0160
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.165
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0381
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0919 – 0.0157
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.163
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthApr
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0097
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0636 – 0.0442
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.721
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0098
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0635 – 0.0440
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.719
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthMay
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0354
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0184 – 0.0893
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.194
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0354
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0183 – 0.0892
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.193
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthJun
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0038
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0577 – 0.0500
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.888
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0037
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0575 – 0.0500
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.890
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthJul
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0704
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0165 – 0.1242
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>0.011</strong>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0705
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0168 – 0.1243
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>0.011</strong>
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthAug
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0143
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0395 – 0.0682
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.598
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0146
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0392 – 0.0683
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.591
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthSep
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0050
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0589 – 0.0489
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.853
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0047
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0585 – 0.0491
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.861
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthOct
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0152
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0387 – 0.0690
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.577
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0219
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0319 – 0.0758
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.420
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
monthNov
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0319
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0857 – 0.0218
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.241
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0321
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-0.0857 – 0.0216
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.238
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
syg lag1
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0559
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0048 – 0.1070
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>0.032</strong>
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
time after lag1
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0037
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.0008 – 0.0066
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>0.014</strong>
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
Observations
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">
96
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">
96
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
AIC
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
-272.099
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
-272.503
</td>
</tr>
</table>

The model fits are very similar, although the AIC is slightly lower for
Model 2. This suggests that the delayed effect of the policy change is
better captured by the second model.

#### ARIMA modelling

To begin, I will run `forecast::auto.arima()` fixing `d=1` to account
for the trend in the data. This suggests a model of the form
ARIMA(0,1,1)(0,0,2)\[12\]. I will then refit this model using
`astsa::sarima()` to include the variables `syg.lag1` and
`time.after.lag1` which capture the lagged step change and slope change
post-intervention.

    ## Series: flhom 
    ## ARIMA(0,1,1)(0,0,2)[12] 
    ## 
    ## Coefficients:
    ##           ma1    sma1    sma2
    ##       -0.8108  0.1649  0.2993
    ## s.e.   0.0639  0.1072  0.1333
    ## 
    ## sigma^2 = 0.004076:  log likelihood = 126.36
    ## AIC=-244.72   AICc=-244.28   BIC=-234.51

    ## initial  value -2.455556 
    ## iter   2 value -2.688127
    ## iter   3 value -2.735981
    ## iter   4 value -2.746804
    ## iter   5 value -2.768320
    ## iter   6 value -2.770850
    ## iter   7 value -2.771361
    ## iter   8 value -2.771622
    ## iter   9 value -2.771902
    ## iter  10 value -2.771955
    ## iter  11 value -2.771970
    ## iter  12 value -2.771970
    ## iter  12 value -2.771970
    ## final  value -2.771970 
    ## converged
    ## initial  value -2.790563 
    ## iter   2 value -2.809166
    ## iter   3 value -2.809737
    ## iter   4 value -2.812582
    ## iter   5 value -2.817971
    ## iter   6 value -2.819067
    ## iter   7 value -2.819530
    ## iter   8 value -2.819595
    ## iter   9 value -2.819598
    ## iter  10 value -2.819599
    ## iter  11 value -2.819599
    ## iter  11 value -2.819599
    ## iter  11 value -2.819599
    ## final  value -2.819599 
    ## converged
    ## <><><><><><><><><><><><><><>
    ##  
    ## Coefficients: 
    ##                 Estimate     SE  t.value p.value
    ## ma1              -1.0000 0.0402 -24.8562  0.0000
    ## sma1              0.2028 0.1106   1.8332  0.0701
    ## sma2              0.3133 0.1312   2.3879  0.0190
    ## syg.lag1          0.0518 0.0237   2.1889  0.0312
    ## time.after.lag1   0.0035 0.0014   2.5029  0.0141
    ## 
    ## sigma^2 estimated as 0.003316062 on 90 degrees of freedom 
    ##  
    ## AIC = -2.675005  AICc = -2.667908  BIC = -2.513707 
    ## 

![](submission_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

The residual plots indicate that the ARIMA model has adequately captured
the trend and seasonality in the data. The residuals are approximately
normally distributed, and there are no obvious patterns in the ACF plot.

### Q4. Using the “best” model from question (3), summarise your findings and write a conclusion describing the impact of the law on the homicide rate in Florida

Given it’s simplicity, I will use the segmented regression model with
the delayed effect of the policy change to estimate the impact of the
Stand-your-ground law.

Prior to the intervention in October 2005, the monthly homicide rate per
100,000 population in Florida was constant over time with a slope of
-0.0004 per month (95% CI -0.001 to 0.0003). In November 2005, one month
after the introduction of the Stand-your-ground law, the monthly
homicide rate per 100,000 population increased by a level shift of 0.056
(95% CI 0.005 to 0.107), and there was a change in slope of 0.004 (95%
CI 0.0008 to 0.007). This means that after the law was introduced, the
homicide rate was increasing by 0.004 per 100,000 population per month
up until the end of the study period in December 2007. Thus, the
introduction of the Stand-your-ground law was associated with an
increase in the homicide rate in Florida.

### Q5. Give two examples of possible negative control series for this intervention (be specific), and justify your selections. Explain in your own words how a negative control series helps with inference.

An appropriate control would be the homicide rate from a different US
state that did not introduce graduated licensing around this time (such
as New York, Texas, Ohio, or Virginia). Ideally, the negative control
should be as similar as possible to the population of interest, except
that they were not targeted by or exposed to the intervention. An
alternative negative control would be another outcome not targeted by
the law, such as firearm suicides in Florida. In the paper by Humphreys
et al, they used both of these negative controls:
<https://jamanetwork-com/journals/jamainternalmedicine/fullarticle/2582988>

One of the challenges of interrupted time series is that there may be
other confounding factors that led to a change in the homicide rate,
such as co-occurring interventions around the same time as the
introduction of the Stand-your-ground law, which may have been
responsible for the change in the homicide rate (e.g., other laws or
regulations that made firearms easier to obtain). The first step for
making use of a negative control series is to evaluate whether there
were any changes in this series at the time of the Stand-your-ground law
in October 2005. If we did observe a change in the control series that
is similar in magnitude to the change observed in the intervention
series, this tells us that there is something else causing the change,
rather than the introduction of the Stand-your-ground law. Thus, we
cannot say with certainty that the observed changes were due to the law.
On the other hand, if we observed no change in the negative control
series, this provides stronger evidence that the change in the homicide
rate was due to the Stand-your-ground law.
