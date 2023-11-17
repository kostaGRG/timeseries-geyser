function plot_timeseries(xV, tittxt)
figure()
clf
plot(xV,'.-')
xlabel('t')
ylabel('x(t)')
title(sprintf([tittxt,' Time Series']))