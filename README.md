# timeseries-geyser

## Contributors
1. Konstantinos Gerogiannis
   Email: kostas.gerogiannis04@gmail.com
   Github: https://github.com/kostaGRG

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
We want to investigate whether:

* The system is fully stochastic or not.
* The system is linear or non-linear.

Initially, we take the data from the corresponding file for the year 2003 and choose a time series with 500 random samples from the original. We will divide our analysis into steps to eventually reach conclusions about the time series. To distinguish between the two time series, the original and the one with the reduced samples, it is noted in the titles of each diagram which time series we have.

### Step 1: Plot time series
We can assert with relative certainty that our time series are stationary, since:
1. There is no trend in the time series; the measurements fluctuate around a constant value at all times.
2. The variance of the time series remains stable over time.

![Time series of eruptions for the year 2003](/images/timeseries_2003.png)
![Time series of eruptions (500 samples) for the year 2003](/images/timeseries500_2003.png)

### Step 2: Statistical Test for Independence Based on Autocorrelation (Portmanteau Test)
Let's now calculate the autocorrelation and partial autocorrelation for each time series.

#### Time series with full samples

![Autocorrellation: year 2003](/images/autocorr_2003.png)
![Partial Autocorrellation: year 2003](/images/par_autocorr_2003.png)

The above diagrams do not allow us to assert the presence of white noise. Indeed, the Portmanteau test for the time series is:

![Portmanteau test: year 2003](/images/portmanteau_2003.png)

Therefore, we reject the hypothesis that the time series is white noise.

#### Time series with 500 samples

![Autocorrellation for 500 samples: year 2003](/images/autocorr500_2003.png)
![Partial Autocorrellation for 500 samples: year 2003](/images/par_autocorr500_2003.png)

Here all the values are inside the green-coloured boundaries.

![Portmanteau test for 500 samples: year 2003](/images/portmanteau500_2003.png)

Clearly and with certainty, we now assert that for this small time series of 500 points, we have white noise, as both the correlation diagrams and the Portmanteau test confirm this estimation. Although we are certain of the white noise, we will continue the analysis for both time series for the sake of completeness.

### Step 3: Estimation of the lag τ using the mutual information criterion
We choose the time of lag τ as the time at which the first local minimum of the mutual information function occurs. For the original timeseries we select τ=3 and for the timeseries with 500 samples τ=1. 

![Mutual Information: year 2003](/images/mutual_information_2003.png)
![Mutual Information for 500 samples: year 2003](/images/mutual_information500_2003.png)

### Step 4: Estimation of the embedding dimension m using the criterion of false nearest neighbors (FNN)
In this step, we aim to calculate the dimension m. For this purpose, we call the auxiliary function falsenearest. Generally, the theory requires that the number of false neighbors decreases to less than 1%. We are unable to achieve this in this time series, even after experimenting with the values of the variables w and f. It is possible that we would need more samples to allow the function to provide values for larger m.

![False Nearest Neighbors: year 2003](/images/fnn_2003.png)

Here, the percentage of false neighbors for the maximum value of m=4 is approximately 5%. After conducting tests in the following steps of the analysis, we saw that we do not get better results using higher values, so we will choose the value m=4.

However, for the time series with 500 samples, the estimation is not as good, and the problem is more pronounced. Our function returns the following graphical representation:

![False Nearest Neighbors for 500 samples: year 2003](/images/fnn500_2003.png)

The minimum percentage of false neighbors we achieve is greater than 10%! We cannot rely on this value of m, but the analysis for this time series will necessarily continue based on it. Tests were also conducted on this time series for a larger m, but there was no improvement. Therefore, we will choose m = 3.

### Step 5: Prediction using a local average model and local linear model for the lag τ and embedding dimension m

For this specific step of the analysis, we will use the auxiliary function localfitnrmse, which will create a prediction model and return the normalized RMSE and the predictions made by the model. Depending on the value we give to the q argument of the function, we choose whether we want a Local Average Prediction (LAP) model or a Local Linear Prediction (LLP) model. We need to ensure that for each time series, the parameter with the number of neighbors has the same value for both predictions. Let's look at the diagrams of the normalized RMSE we get for the two prediction models and the two time series (a total of 4 diagrams). First for the year 2003:

![LAP NRMSE: year 2003](/images/lap_2003.png)
![LLP NRMSE: year 2003](/images/llp_2003.png)

The LLP model fails to predict, but the LAP for a one-step-ahead time frame adapts somewhat better.

For the timeseries with 500 samples:

![LAP NRMSE for 500 samples: year 2003](/images/lap500_2003.png)
![LLP NRMSE for 500 samples: year 2003](/images/llp500_2003.png)

We observe that the performance is disappointing; the errors we get in the outputs are enormous, which is expected, considering we have assumed Gaussian noise.

### Step 6: Prediction with a Linear Model / Diagram of One-Step-Ahead Predictions

We continue the analysis by adjusting with a linear model, as we did for the time series in the first part, and we show the resulting NRMSE.

#### Time series with full samples
![ARMA: year 2003](/images/arma_2003.png)

For all three models, the prediction error, even for Τ=1, is high. To minimize NRMSE, the linear model is the better choice. We also provide the time series with the predictions.

![Predictions: year 2003](/images/predictions_2003.png)

Since the above chart is not readable, we also show the zoomed-in view of a random time period:

![Predictions zoomed: year 2003](/images/predictions_zoomed_2003.png)

Judging from the predictions and errors, the best prediction model selected is the linear model ARMA(4,1) for the full time series of the year 2003.

#### Time series with 500 samples

![ARMA for 500 samples: year 2003](/images/arma500_2003.png)
![Predictions for 500 samples: year 2003](/images/predictions500_2003.png)

For this particular time series, it seems that no model is capable of approximating it. Another confirmation of the white noise claim is that the most suitable model for linear approximation is ARMA(0).

### Step 7: Estimation of correlation dimension for dimensions m=1,...,10
#### Time series with full samples
For the continuation of the analysis and the determination of the correlation dimension, we use the correlationdimension function, and by analyzing the plots, we will decide on our correlation dimension. For the entire time series, we have the following figures:

![Correlation integral: year 2003](/images/corr_integral_2003.png)

We would expect to see the slopes converge in the log(C(r))/log(r) plot for all values of m over a range of r values. This is not happening. The plot does not have the typical shape that we would expect based on what we have seen in the theory of the course.

![Local Slope: year 2003](/images/local_slope_2003.png)

As was evident from the previous plot, the slope remains zero for several values of r (constant value of log(C(r))) and there is no horizontalization of the slope anywhere. Only for values close to 1.2 is there a temporary stabilization of the slope, but we consider it insufficient to estimate any value.

![Correlation dimension: year 2003](/images/corr_dimension_2003.png)

The paradox in this plot is that with the increase in m, the estimated dimension v does not stabilize but instead increases. The estimation of v is almost constant up to the value m=6, with v = 0.55. However, the uncertainty is very high and increases as the embedding dimension grows.

![Log distances: year 2003](/images/distances_2003.png)

#### Time series with full samples
![Correlation integral for 500 samples: year 2003](/images/corr_integral500_2003.png)

A similar behavior is observed for this time series, and we cannot identify a stable region in the slope of the plot.

![Local Slope for 500 samples: year 2003](/images/local_slope500_2003.png)

The unpredictable behavior of the plot is even more pronounced, similar in shape to the previous one.

![Correlation dimension for 500 samples: year 2003](/images/corr_dimension500_2003.png)

The same applies to the estimation of v, where as m increases, its value constantly increases, and the uncertainty grows.

![Log distances for 500 samples: year 2003](/images/distances500_2003.png)

### Conclusions
* For the time series of 500 measurements from the year 2003, we can now confidently claim that it is purely stochastic, meaning it is a result of white noise only. The reasons for this conclusion were discussed at various points in the extensive analysis (auto-correlation, model approximation, etc.). Therefore, we cannot model or predict it. This specific time series exhibits similar behavior to the time series from the year 2000 or 2011.
* For the time series of the year 2003, we cannot say that its system is purely stochastic. Auto-correlations did not lead us to the conclusion of the existence of white noise only. However, we can assert that the system generating it is linear, as the best and only suitable approximation was achieved with the ARMA(4,1) model. Non-linear analysis attempts encountered significant issues in selecting the embedding dimension 'm' and the correlation dimension 'v'. This time series behavior resembles that of the time series from 1989, which was studied in the first part of the work.
