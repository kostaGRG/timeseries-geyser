# timeseries-geyser

## Introduction
The computational task involves analyzing historical data (time series) from the Old Faithful geyser in the USA (see [Geyser](http://www.geyserstudy.org/geyser.aspx?pGeyserNo=OLDFAITHFUL)). The data concerns the time between successive eruptions of the geyser, namely the time in minutes from the start of one eruption to the start of the next. The duration of the eruptions is very short compared to the time between eruptions. We are interested in investigating whether there is any structure in the successive waiting times (times between successive eruptions) that may allow us to predict the waiting time until the next onset. We are also interested in whether the supposed structure changes in the different periods we study the problem, that is, from 1989 to 2011.

## Available data
The measurements have been divided and recorded in files for different years, as follows:

* eruption1989.dat: Consecutive measurements in a period shorter than one month (298 measurements).
* eruption2000.dat: Consecutive measurements for all days in the period from 11/10 to 25/11 (739 measurements).
* eruption2001.dat, …, eruption2011.dat: Consecutive measurements for the entire year for each of the years 2001, 2002, …, 2011.
The files have a varying number of measurements.

We will study 4 time series, specifically the time series for the years 1989, 2000, 2003 and 2011. We assume that all the time series are stationary. The data files are located in the folder named eruptionData, and all the MATLAB functions we use are also uploaded in a folder with the same name.

## First part: Linear Analysis for the years 1989,2000 and 2011
We want to check whether the system that generates the eruptions, and specifically the waiting times for the eruptions, remains the same in different periods, specifically for the years 1989, 2000, and 2011 (a difference of 11 years). You will use the time series of 298 observations for the year 1989 and select a segment of the same length (298 observations) from the time series for the years 2000 and 2011. The choice of segment for 2000 and 2011 should be random. The analysis will be conducted on each of the three time series of the same length for the years 1989, 2000, and 2011, using the same methods of linear analysis on each of the 3 time series. You should address the following questions:

Is the time series white noise, or are there significant autocorrelations? For this, you should include an appropriate hypothesis test based on autocorrelation. Are your conclusions the same for all 3 time series?
Following question 1, and if your conclusion in question 1 allows, what is the most suitable linear model for fitting and prediction? How good is the prediction for one time step ahead (or even two or three steps)? Do the models and predictions differ for the 3 time series?

## First part: Solution
Before any calculations were made, the time series were processed, and the lengths of the 2000 and 2011 series were adjusted to be equal to the length of the 1989 time series, as requested in the assignment brief.

### White noise
#### Year: 1989
To perform the white noise test, we first display the time series on the screen.

![Time series of eruptions for the year 1989](/images/timeseries_eruptions_1989.png)

Next, we examine the autocorrelation and partial autocorrelation of the time series for the first 20 time lags.

![Autocorrellation: year 1989](/images/autocorr_1989.png)
![Partial Autocorrellation: year 1989](/images/par_autocorr_1989.png)

We observe that the time series is NOT white noise, as there are autocorrelations outside the permissible significance limits for the first 15 lags! However, we can assert that the time series is stationary as it appears to have no upward or downward trend, and the variance seems to remain constant over time. Finally, from the partial autocorrelation diagram, we see that the values depend only on the previous value, as only the value for lag 1 of the partial autocorrelation is statistically significant.

We will now also apply the parametric Portmanteau test to the above time series and expect to reach the same conclusion, namely that the hypothesis that the samples are statistically uncorrelated is rejected.

Indeed, the Portmanteau test returns the following values for the parameters h and p-value:
h = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
pvalue = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

#### Year: 2000
We follow the exact same procedure, presenting the time series and its autocorrelation and partial autocorrelation for a maximum lag of 20.

![Time series of eruptions for the year 2000](/images/timeseries_eruptions_2000.png)
![Autocorrellation: year 2000](/images/autocorr_2000.png)
![Partial Autocorrellation: year 2000](/images/par_autocorr_2000.png)

Here, all values, except one, for both autocorrelation and partial autocorrelation, are within the permissible significance limits. Therefore, we can assert without hesitation that for the year 2000, the time series is a result of white noise. Let's confirm this with the Portmanteau test:

![Portmanteau test: year 2000](/images/portmanteau_2000.png)

All p-values are greater than the 0.05 limit, so we can be sure that we face white noise.

#### Year: 2011
For this time series, as with the previous ones, we can also consider the assumption of stationarity.

![Time series of eruptions for the year 2011](/images/timeseries_eruptions_2011.png)
![Autocorrellation: year 2011](/images/autocorr_2011.png)
![Partial Autocorrellation: year 2011](/images/par_autocorr_2011.png)

We will also need the Portmanteau test to ensure that the time series constitutes white noise, due to some borderline values.

![Portmanteau test: year 2011](/images/portmanteau_2011.png)

After reviewing the diagram resulting from the test, we consider this time series to be a result of white noise.

### Fitting Linear Model and Prediction
#### Year: 1989
We use the auxiliary function findBestArma that we created, which essentially performs a grid search for the values of parameters p and q, and returns the optimal linear model, the one with the smallest value in the AIC metric. The 1989 time series is best approximated in a linear manner when using an ARMA model with p=1 and q=1.

![Time series and ARMA fit for the year 1989](/images/timeseries_arma_1989.png)

To produce the above time series with predictions, we used the function predictNRMSE, which, in addition to the prediction values, also returns the values of the normalized RMSE, which we present:

![NRMSE for the year 1989](/images/nrmse_1989.png)

#### Year: 2000
If we attempt to perform the same process for the 2000 time series, it will return the optimal values as p=3 and q=3. Let's also look at the corresponding diagrams:

![Time series and ARMA fit for the year 2000](/images/timeseries_arma_2000.png)
![NRMSE for the year 2000](/images/nrmse_2000.png)

It appears that the model fails to make accurate predictions, a result of the white noise.

#### Year: 2011
Just as with the year 2000, here too, we observe the same behavior. The approximation was made using an ARMA(3,3) model.

![Time series and ARMA fit for the year 2011](/images/timeseries_arma_2011.png)
![NRMSE for the year 2011](/images/nrmse_2011.png)

### Conclusions

* For the years 2000 and 2011, we concluded that they represent white noise, which theoretically means they could not be approximated by any linear function, as they are based on randomness. After testing to see which model fits best, our function returns the model with p=3 and q=3, but it fails to provide satisfactory predictions.
* The approach we used for the year 1989 seems satisfactory when looking at the time series, and this view is confirmed by the diagram showing the NRMSE metric values.

## Second Part: Linear and Non-linear Analysis for the Year 2003
In the second stage of analysis, you will consider two time series formed from the year 2003. The first time series will include all observations, and the second will include a segment of the time series consisting of 500 observations.

You will investigate whether the series of eruption waiting times for the year 2003 has linear and/or non-linear (auto)correlations and how this is detected when considering a short series (500 observations, the second time series) or the entire available series (the first time series). Some steps of the analysis that you can perform for each of the two time series are:

1. Diagram of the time series.
2. Statistical independence test based on autocorrelation (Portmanteau test).
3. Estimation of the lag τ that gives the mutual information criterion.
4. Estimation of the embedding dimension m given by the criterion of false nearest neighbors, using the lag you found above.
5. Prediction with a local average model and local linear model for lag τ and embedding dimension m estimated above (and the same number of neighboring points).
6. Diagram of one-step-ahead predictions. Comparison with the corresponding predictions of the linear model (from the first part of the assignment). Comparison of the linear and non-linear model in terms of one-step-ahead prediction based on the nrmse.
7. Estimation of the correlation dimension for dimensions m=1,…,10, using the lag from the mutual information criterion with appropriate diagrams.

Based on the results from the measures, you should comment on the nature of the time series system, i.e., whether it is fully stochastic or not, and whether it is linear or non-linear. Does the system of your time series seem to differ from that of the years 1989, 2000, and 2011?

## Second Part: Solution
