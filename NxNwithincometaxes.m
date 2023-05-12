N = 10; %number of players
a = 0.1; %rand(); %random fraction in interval [0,1] won
n = 10000; % how many rounds of the game 
p = 0.5;  % win chance =, i.e. over player 1 wins, else player 2 wins
gamma = 0.3; % income tax rate
b = 0; % as a placeholder for first round 
X = zeros(n+1, N); %initialize array of wealth
X(1,:) = (1/N);
for t = 1:n %loop over n time steps

    %update wealth for every player 
    %generating random numbers for picking  2 elements\players to engage in the game 
    i = randi(N,1);
    j = randi(N,1);
    while i == j
         j = randi(N,1);
    end
    %pick two random elements from current row and they play a two player game,
    %update array X to give them a name 
      k1 = X(t, i); 
      k2 = X(t, j);
      %Y = array
      % Remove new Y elements from array X
      
  distro = rand();
    if distro <= p  % k1 wins

        k =   a * min(k1,k2)*1;
        b = gamma*k; % tax rate, where b = a^2
    %wealth of players not in game for next round
        X(t+1,:) = (1-b)*X(t,:) + b/N;
    %add values back to array
        X(t+1, i) = X(t, i) + k;
        X(t+1, j) = X(t, j) - k;
    else %k2 wins
        k =   a * min(k1,k2)*1;
   %wealth of players not in game for next round
        X(t+1,:) = (1-b)*X(t,:) + b/N;
    %add values back to array
        X(t+1, i) = X(t, i) - k;
        X(t+1, j) = X(t, j) + k;
    end
end

    
plot(X)

    


sumofrows = sum(X,2);

Finalwealth = X(end,:);

T = transpose(Finalwealth);

winner = max(T);

