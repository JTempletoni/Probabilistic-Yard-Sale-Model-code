% ecdf and cdf

reshaped_wealth_data = reshape(X, 1, []);
data = reshaped_wealth_data;

% Estimate the ECDF
[f, x] = ecdf(data);

% Compute the CDF
cdf = normcdf(x, mean(data), std(data));
plot(cdf);

% Plot the ECDF and CDF
plot(x, f, 'LineWidth', 1.5);
hold on;
plot(x, cdf, 'r', 'LineWidth', 1.5);
hold off;
legend('ECDF', 'CDF');
xlabel('Wealth');
ylabel('Probability');
title('ECDF and CDF');

%two sample Kolmogorov_Smirov test 

%[h,p] = kstest2(f,cdf,'alpha',0.01)

