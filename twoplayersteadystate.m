% Define the parameters
p = 0.5; % Probability of winning player
n = 1000; % Number of rounds
a = 0.1; %fraction won or lost

% Define the range of b values to consider
b_range = [0.1, 0.2, 0.3, 0.4, 0.5];

% Initialize the variables
A = 1; % Initial wealth
num_samples = 100000; % Number of Monte Carlo samples
X = zeros(num_samples, n); % Player A's wealth over rounds for all samples
Y = zeros(num_samples, n); % Player B's wealth over rounds for all samples
num_bins = 1000;
% Simulate wealth exchange for each b value
for j = 1:length(b_range)
    b = b_range(j);
    for i = 1:num_samples
        % Initialization of Player A's and Player B's wealth
        X(i, 1) = A/2;
        Y(i, 1) = A/2;

        % Simulate wealth exchange
        for t = 1:n-1
            % determining winner,  Generating a fraction between 0 and 1
            distro = rand();
            if distro <= p  % X wins
                X(i, t+1) = X(i, t) + a * min(X(i, t), 1-X(i, t)) * (1-b); % Update Player A's wealth
                Y(i, t+1) = Y(i, t) - a * min(Y(i, t), 1-Y(i, t)) * (1-b); % Update Player B's wealth
            else             % Y wins
                X(i, t+1) = X(i, t) - a * min(X(i, t), 1-X(i, t)) * (1-b); % Update Player A's wealth
                Y(i, t+1) = Y(i, t) + a * min(Y(i, t), 1-Y(i, t)) * (1-b); % Update Player B's wealth
            end   
        end
    end

    % Compute the steady-state density using histogram
    density_X = histcounts(X(:, end), 'Normalization', 'pdf', 'BinMethod', 'fd');
    density_Y = histcounts(Y(:, end), 'Normalization', 'pdf', 'BinMethod', 'fd');

    % Plot the steady-state density for Player A and Player B
    figure();
    hold on;
    histogram(X(:, end), 'Normalization', 'pdf', 'BinMethod', 'fd','DisplayStyle', 'stairs');
    histogram(Y(:, end), 'Normalization', 'pdf', 'BinMethod', 'fd','DisplayStyle', 'stairs');
    legend('Player A', 'Player B');
    xlabel('Wealth');
    ylabel('Density');
    title(sprintf('Steady-state density (b=%0.1f)', b));
    hold off;
end

% Plot the steady state densities
figure();
hold on;
for b = b_values
    % Simulate the game to find the steady state distribution
    [X_ss, Y_ss] = yard_sale_steady_state(p, a, b, num_bins, n, X, Y);
    
    % Plot the steady state distribution for the current value of b
    plot(X_ss, 'LineWidth', 1.5);
end

% Set the plot properties
xlabel('Wealth', 'FontSize', 12);
ylabel('Steady State Density', 'FontSize', 12);
title('Steady State Density of Players in the Yard-Sale Game', 'FontSize', 14);
legend('b = 0.01', 'b = 0.1', 'b = 0.5', 'FontSize', 12);
grid on;
hold off;