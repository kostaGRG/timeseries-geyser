clear
close all
clc

rng(42)
%% 1. READ AND PLOT TIMESERIES
x2003 = readmatrix('./eruptionData/eruption2003.dat');
n = length(x2003);
n_minimized = 500;
x2003_minimized = x2003(randsample(n,n_minimized));

plot_timeseries(x2003,'x2003, eruptions of 2003');
plot_timeseries(x2003_minimized,'x2003 , eruptions of 2003, 500 samples');

%% 2. GET AUTOCORRELATION AND PORTMANTEAU TEST
alpha = 0.05;
zalpha = norminv(1-alpha/2);
autlim = zalpha/sqrt(n);

maxtau=20;
ac2003 = autocorrelation(x2003,maxtau,'x2003');
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)

pac2003 = parautocor(x2003,maxtau);
figure();
sizeofmark = 6;
plot(pac2003,'.-','markersize',sizeofmark)
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)
title('x2003 Partial Autocorrelation');
xlabel('lag \tau')
ylabel('r(\tau)')
h2003 = portmanteauLB(ac2003(2:size(ac2003,1),2),n,alpha,'x2003');

autlim_minimized = zalpha/sqrt(n_minimized);
ac2003_minimized = autocorrelation(x2003_minimized,maxtau,'x2003, 500 samples');
hold on;
plot([0 maxtau+1],autlim_minimized*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim_minimized*[1 1],'--g','linewidth',1.5)

pac2003_minimized = parautocor(x2003_minimized,maxtau);
figure();
sizeofmark = 6;
plot(pac2003_minimized,'.-','markersize',sizeofmark)
hold on;
plot([0 maxtau+1],autlim_minimized*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim_minimized*[1 1],'--g','linewidth',1.5)
title('x2003, 500 samples Partial Autocorrelation');
xlabel('lag \tau')
ylabel('r(\tau)')
h2003_minimized = portmanteauLB(ac2003_minimized(2:size(ac2003_minimized,1),2),n_minimized,alpha,'x2003, 500 samples');

%% 3. MUTUAL INFORMATION/τ ESTIMATION
mut_infos2003=mutualinformation(x2003,maxtau,ceil(sqrt(n/5)),'x2003');
t_optimal = 3;
mut_infos2003_minimized = mutualinformation(x2003_minimized,maxtau,ceil(sqrt(n_minimized/5)),'x2003, 500 samples');
t_optimal_minimized = 1;

%% 4. FALSE NEAREST NEIGHBORS/m ESTIMATION
escape = 20;
escape_minimized = 10;
window = 1;

false_percentages = falsenearest(x2003,t_optimal,10,escape,window,'x2003');
m = 4;
false_percentages_minimized = falsenearest(x2003_minimized,t_optimal_minimized,10,escape_minimized,window,'x2003, 500 samples');
m_minimized = 3;

%% LLP,LAP
% LOCAL AVERAGE PREDICTION LAP
nnei=30;
nnei_minimized = 15;
q=0;
Tmax=3;
[nrmse_llp2003,pred_llp2003] = localfitnrmse(x2003,t_optimal,m,Tmax,nnei,q,'x2003 LAP');
[nrmse_llp2003_minimized,pred_llp2003_minimized] = localfitnrmse(x2003_minimized,t_optimal_minimized,m_minimized,Tmax,nnei_minimized,q,'x2003, 500 samples LAP');

% LOCAL LINEAR PREDICTION LLP
q=m;
q_minimized = m_minimized;
Tmax=3;
[nrmse_lap2003,pred_lap2003] = localfitnrmse(x2003,t_optimal,m,Tmax,nnei,q,'x2003 LLP');
[nrmse_lap2003_minimized,pred_lap2003_minimized] = localfitnrmse(x2003_minimized,t_optimal_minimized,m_minimized,Tmax,nnei_minimized,q_minimized,'x2003, 500 samples LLP');

%% ARMA MODEL FITTING
tmax = 3;

[p_optimal2003,q_optimal2003] = findBestArma(x2003,tmax);

nlast = round(0.4*n);
[nrmse2003,pred2003] = predictARMAnrmse(x2003,p_optimal2003,q_optimal2003,tmax,nlast,'x2003');
figure
plot(x2003(n-size(pred2003)+1:n,1),'.-','markersize',sizeofmark);
hold on;
plot(pred2003(:,1),'.-','markersize',sizeofmark);
plot(pred_lap2003(n-size(pred2003)+2-pred_lap2003(1,1):length(pred_lap2003),2),'.-','markersize',sizeofmark);
plot(pred_llp2003(n-size(pred2003)+2-pred_llp2003(1,1):length(pred_llp2003),2),'.-','markersize',sizeofmark);
title('x2003 timeseries and predictions');
xlabel('lag \tau')
ylabel('value')
legend('actual timeseries','linear prediction for T=1','LAP prediction for T=1','LLP prediction for T=1');

[p_optimal2003_minimized,q_optimal2003_minimized] = findBestArma(x2003_minimized,tmax);

nlast = round(0.4*n_minimized);
[nrmse2003_minimized,pred2003_minimized] = predictARMAnrmse(x2003_minimized,p_optimal2003_minimized,q_optimal2003_minimized,tmax,nlast,'x2003, 500 samples');
figure
plot(x2003_minimized(n_minimized-size(pred2003_minimized)+1:n_minimized,1),'.-','markersize',sizeofmark);
hold on;
plot(pred2003_minimized(:,1),'.-','markersize',sizeofmark);
plot(pred_lap2003_minimized(n_minimized-size(pred2003_minimized)+2-pred_lap2003_minimized(1,1):length(pred_lap2003_minimized),2),'.-','markersize',sizeofmark);
plot(pred_llp2003_minimized(n_minimized-size(pred2003_minimized)+2-pred_llp2003_minimized(1,1):length(pred_llp2003_minimized),2),'.-','markersize',sizeofmark);
title('x2003, 500 samples timeseries and predictions');
xlabel('lag \tau')
ylabel('value')
legend('actual timeseries','linear prediction for T=1','LAP prediction for T=1','LLP prediction for T=1');

%% CALCULATE CORRELATION DIMENSION
mmax = 10;
correlationdimension(x2003,t_optimal,mmax,'x2003');
correlationdimension(x2003_minimized,t_optimal_minimized,mmax,'x2003,500 samples');