%prob density func


reshaped_wealth_data = reshape(X, 1, []);
% assign data for pdf
data = reshaped_wealth_data;

% Estimate the PDF using a histogram with bins and histcounts
nbins = 500;
[counts, edges] = histcounts(data, nbins, 'Normalization', 'pdf');

% Plot the PDF
plot(edges(1:end-1), counts, 'LineWidth', 1.5);
xlabel('Share of wealth');
ylabel('Probability Density');
title('Probability Density Function');

