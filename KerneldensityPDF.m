% Flatten the array X then use kernel density estimate to create PDF
X_start = reshape(X(1000,:), [], 1);
X_mid = reshape(X(50000,:), [], 1);
X_end = reshape(X(end,:), [], 1);


% Compute the kernel density estimate of X_flat
[f1, x] = ksdensity(X_start);
[f2, x] = ksdensity(X_mid);
[f3, x] = ksdensity(X_end);
% Plot the density curve
figure;
plot(x, f1)
hold on
plot(x, f2)
plot(x, f3)
legend('density at t=1000','density at t=50000','density at t=100000')


xlabel('Wealth')
ylabel('Probability Density')
title('Probability density of the distribution of wealth over time')


