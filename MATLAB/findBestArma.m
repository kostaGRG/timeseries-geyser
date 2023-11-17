
% Description:
% The function is responsible for finding the optimal ARMA linear model for values of the parameters p and q in the range [0, 5], using the AIC metric as a criterion.
% Arguments:
% xV: The time series we want to approximate.
% Tmax: The time steps of prediction that we are interested in.
% Outputs:
% p_optimal: The value of the p parameter of the optimal model.
% q_optimal: The value of the q parameter of the optimal model.


function [p_optimal,q_optimal] = findBestArma(xV,Tmax)
    min_aic = Inf;
    p_optimal = -1;
    q_optimal = -1;
    for p=0:5
        for q=0:5
            [~,~,~,~,temp_aic,~,~] = fitARMA(xV,p,q,Tmax);
            if temp_aic < min_aic
                p_optimal = p;
                q_optimal = q;
                min_aic = temp_aic;
            end
        end
    end


end