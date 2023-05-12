
% Create a 10000x10 array
data = X;

% Initialize arrays to store the mean and standard deviation of each row
row_variation = zeros(n,1);
row_median = zeros(n,1);
row_paretoIndex = zeros(n,1);


% Loop through each row of the array and compute the variance and standard deviation
for i = 1:n
    warning('off','all') % turn off all warning messages
    row_variation(i) = var(data(i,:));
    row_median(i) = median(data(i,:));
    [params, ~] = gpfit(data(i,:), 'alpha');
    % Store the first parameter (the Pareto index) in the alpha_vals array
    row_paretoIndex(i) = params(1);

end

figure; 
subplot(2,1,1);
plot(row_variation,'DisplayName','row_variation');
title('Variance');
xlabel('rounds(n)');
ylabel('wealth(X)');

subplot(2,1,2);
plot(row_median,'DisplayName','row_median');
title('Median');
xlabel('rounds(n)');
ylabel('wealth(X)');
%subplot(3,1,3);
%plot(row_paretoIndex, 'DisplayName', 'row_paretoIndex');
%title('Pareto Index');

