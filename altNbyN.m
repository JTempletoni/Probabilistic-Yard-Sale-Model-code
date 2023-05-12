% Alternate N by N player game where all players excahnge at each time step

N = 10; %number of players
a = 0.1; %rand(); %random fraction in interval [0,1] won
b = 0.1;
n = 10000;
p = 0.5;
t = 1;
       

X = ones(t, N); %initialize array of wealth
X(1,:) = (10/N);

for t = 1:n %loop over n time steps
    % random player wins, vector e at 
    rand1 = randi(N);
     e = X(t,rand1);

    %update wealth for every player , with e being the winner 
        X(t+1,:) = (1-b)*X(t,:) -(a/(N-1))*min(X(t,:)) + b/N;
        X(t+1,rand1) = (1-b)*e -(a/(N-1))*min(X(t,:)) + b/N + (a*N/(N-1))*min(X(t,:));
        
       
      
end

Finalwealth = X(end,:);

T = transpose(Finalwealth);

winner = max(T);
sumofrows = sum(X,2)

plot(X)

richest = max(X(n,:))