%lorenz curve and gini index
wealth1 = sort(X((end-1)/4,:)); % for wealth near beginning
wealth2 = sort(X((end-1)/2,:)); % for wealth mid way
wealth3 = sort(X(end,:));% specify any X(t,N) to get the lorenz curve and gini index.
% the above code just sorts it into ascending order so that it can be
% plotted
n1 = length(wealth1);
n2 = length(wealth2);
n3 = length(wealth3);


%then find the data and compute gini
% for wealth 1
cumulative_wealth1 = cumsum(wealth1) / sum(wealth1);
cumulative_population1 = linspace(0, 1, n1);
area_below_lorenz1 = trapz(cumulative_population1, cumulative_wealth1);
area_below_equality1 = trapz(cumulative_population1, cumulative_population1);
gini1 = 1 - 2 * (area_below_lorenz1);


% for wealth 2
cumulative_wealth2 = cumsum(wealth2) / sum(wealth2);
cumulative_population2 = linspace(0, 1, n2);
area_below_lorenz2 = trapz(cumulative_population2, cumulative_wealth2);
area_below_equality2 = trapz(cumulative_population2, cumulative_population2);
gini2 = 1 - 2 * (area_below_lorenz2);

% for wealth 3
cumulative_wealth3 = cumsum(wealth3) / sum(wealth3);
cumulative_population3 = linspace(0, 1, n3);
area_below_lorenz3 = trapz(cumulative_population3, cumulative_wealth3);
area_below_equality3 = trapz(cumulative_population3, cumulative_population3);
gini3 = 1 - 2 * (area_below_lorenz3);

hold on
ylim([0 1])
box on
plot(cumulative_population1, cumulative_population1, '--k'); %equality line
plot(cumulative_population1, cumulative_wealth1, '-');
plot(cumulative_population2, cumulative_wealth2, '-');
plot(cumulative_population3, cumulative_wealth3, '-');
hold on;

title('Lorenz curves')
xlabel('Cumulative share of population');
ylabel('Cumulative share of wealth');
legend('Equality line' ,['Lorenz curve at t = 25000 (Gini = ' num2str(gini1) ')'],['Lorenz curve at t = 50000 (Gini = ' num2str(gini2) ')'],['Lorenz curve at t = 100000 (Gini = ' num2str(gini3) ')'],'Location','northwest');
