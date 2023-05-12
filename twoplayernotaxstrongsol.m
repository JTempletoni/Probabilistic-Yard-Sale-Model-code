% Parameters
T = 1; % Time horizon
N = 1000; % Number of time steps
dt = T/N; % Time step size
X0 = 0.5; % Initial condition

% Initialize arrays
X = zeros(N+1, 1); % Solution array
X(1) = X0;

% Generate Brownian increments
dW = sqrt(dt)*randn(N, 1);

% loop to calculate 
for i = 1:N
    X(i+1) = X(i) + min(X(i), 1-X(i))*dW(i);
end

% Plot solution
t = linspace(0, T, N+1);
plot(t, X);
xlabel('Time');
ylabel('X');
title('Strong solution of SDE');