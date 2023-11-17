clear
close all
clc

rng(42)
%% READ DATA/ CHANGE LENGTH OF TIME SERIES
x1989 = readmatrix('./eruptionData/eruption1989.dat');
x2000 = readmatrix('./eruptionData/eruption2000.dat');
x2011 = readmatrix('./eruptionData/eruption2011.dat');

n1989 = length(x1989);
n2000 = length(x2000);
n2011 = length(x2011);

disp('~~~~~~~~~~~~~~~~~Lengths~~~~~~~~~~~~~~~~~~')
fprintf('1989: %d\n',n1989);
fprintf('2000: %d\n',n2000);
fprintf('2011: %d\n',n2011);

n_minimized = n1989;

x2000 = x2000(randsample(n2000,n_minimized));
x2011 = x2011(randsample(n2011,n_minimized));

disp('~~~~~~~~~~~~~~~New Lengths~~~~~~~~~~~~~~~~')
fprintf('1989: %d\n',length(x1989));
fprintf('2000: %d\n',length(x2000));
fprintf('2011: %d\n',length(x2011));

%% WHITE NOISE TEST
alpha = 0.05;
zalpha = norminv(1-alpha/2);
autlim = zalpha/sqrt(n_minimized);

% 1989
plot_timeseries(x1989,'eruptions 1989');
maxtau=20;
acf1989 = autocorrelation(x1989,maxtau,'x1989');
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)

pacf1989 = parautocor(x1989,maxtau);
figure();
sizeofmark = 6;
plot(pacf1989,'.-','markersize',sizeofmark)
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)
title('x1989 Partial Autocorrelation');
xlabel('lag \tau')
ylabel('r(\tau)')

[h1989,p1989,~,~] = portmanteauLB(acf1989(2:size(acf1989,1),2),n_minimized,alpha,'x1989');
disp('For the year 1989 and the first 20 lags:');
disp(['h= ' mat2str(int8(h1989))]);
disp(['pvalue= ' mat2str(p1989)]);

% 2000
plot_timeseries(x2000,'eruptions 2000');
acf2000 = autocorrelation(x2000,maxtau,'x2000');
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)

pacf2000 = parautocor(x2000,maxtau);
figure();
sizeofmark = 6;
plot(pacf2000,'.-','markersize',sizeofmark)
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)
title('x2000 Partial Autocorrelation');
xlabel('lag \tau')
ylabel('r(\tau)')

[h2000,p2000,~,~] = portmanteauLB(acf2000(2:size(acf2000,1),2),n_minimized,alpha,'x2000');
disp('For the year 1989 and the first 20 lags:');
disp(['h= ' mat2str(int8(h2000))]);
disp(['pvalue= ' mat2str(p2000)]);


% 2011
plot_timeseries(x2011,'eruptions 2011');
acf2011 = autocorrelation(x2011,maxtau,'x2011');
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)

pacf2011 = parautocor(x2011,maxtau);
figure();
sizeofmark = 6;
plot(pacf2011,'.-','markersize',sizeofmark)
hold on;
plot([0 maxtau+1],autlim*[1 1],'--g','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--g','linewidth',1.5)
title('x2011 Partial Autocorrelation');
xlabel('lag \tau')
ylabel('r(\tau)')

[h2011,p2011,~,~] = portmanteauLB(acf2011(2:size(acf2011,1),2),n_minimized,alpha,'x2011');
disp('For the year 1989 and the first 20 lags:');
disp(['h= ' mat2str(int8(h2011))]);
disp(['pvalue= ' mat2str(p2011)]);

%% FITTING LINEAR MODEL AND PREDICTION
tmax = 3;


[p_optimal1989,q_optimal1989] = findBestArma(x1989,tmax);

nlast = round(0.4*n_minimized);
[nrmse1989,pred1989] = predictARMAnrmse(x1989,p_optimal1989,q_optimal1989,tmax,nlast,'x1989');
figure
plot(x1989(n_minimized-size(pred1989)+1:n_minimized,1),'.-','markersize',sizeofmark);
hold on;
plot(pred1989(:,1),'.-','markersize',sizeofmark);
title('x1989 timeseries and ARMA fit');
xlabel('lag \tau')
ylabel('value')
legend('actual timeseries','prediction for T=1');


[p_optimal2000,q_optimal2000] = findBestArma(x2000,tmax);
nlast = round(0.4*n_minimized);
[nrmse2000,pred2000] = predictARMAnrmse(x2000,p_optimal2000,q_optimal2000,tmax,nlast,'x2000');
figure
plot(x2000(n_minimized-size(pred2000)+1:n_minimized,1),'.-','markersize',sizeofmark);
hold on;
plot(pred2000(:,1),'.-','markersize',sizeofmark);
title('x2000 timeseries and ARMA fit');
xlabel('lag \tau')
ylabel('value')
legend('actual timeseries','prediction for T=1');

[p_optimal2011,q_optimal2011] = findBestArma(x2011,tmax);
nlast = round(0.4*n_minimized);
[nrmse2011,pred2011] = predictARMAnrmse(x2011,p_optimal2011,q_optimal2011,tmax,nlast,'x2011');
figure
plot(x2011(n_minimized-size(pred2011)+1:n_minimized,1),'.-','markersize',sizeofmark);
hold on;
plot(pred2011(:,1),'.-','markersize',sizeofmark);
title('x2011 timeseries and ARMA fit');
xlabel('lag \tau')
ylabel('value')
legend('actual timeseries','prediction for T=1');
