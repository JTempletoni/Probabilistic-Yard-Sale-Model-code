%2 Player Game with taxes 

% must be zero sum, i.e a(i) + b(i) = 1 

% Define the parameters
p = 0.5; % Probability of winning player
n = 1000; % Number of rounds
a = 0.1; %fraction won or lost
b = 0.01; % tax rate of 1%

% Initialize the variables
A = 1; % Initial asset
X = zeros(1,n); % Player A's asset over rounds
Y = zeros(1,n); % Player B's asset over rounds
X(1) = A/2; % Initialization of Player A's asset
Y(1) = A/2 % Initialization of Player B's asset

% Simulate wealth exchange
for n = 1:n-1

   % determining winner,  Generating a fraction between 0 and 1
    distro = rand()
   disp(distro)
   if distro >= p  % X wins
       X(n+1) = (1-b)*X(n) + a * min(X(n),1-X(n))*1 + b/2; % Equations from chorro
       Y(n+1) = (1-b)*Y(n) - a * min(Y(n),1-Y(n))*1 + b/2;
   else            % Y wins
       X(n+1) = (1-b)*X(n) - a * min(X(n),1-X(n))*1 + b/2;
       Y(n+1) = (1-b)*Y(n) + a * min(Y(n),1-Y(n))*1 + b/2;
   end
end

% Then finding the winner and plotting their share of wealth over time
 
if (X(n) > Y(n))
   disp('Player X is the richest')
else
   disp('Player Y is the richest')
end
if max(X(n)) > max(Y(n))
    plot(X,'r');
else
    plot(Y,'b');
end