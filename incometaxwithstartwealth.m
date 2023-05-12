N = 20; %number of players
a = 0.1; %rand(); %random fraction in interval [0,1] won
n = 10000; % how many rounds of the game 
p = 0.5;  % win chance =, i.e. over player 1 wins, else player 2 wins
gamma = 0.; % income/transaction tax rate
SWP = 2; % players who start wealthier i.e. starting wealth players (SWP)
SW = 0.486; % starting wealth of each SWP

X = zeros(t, N); %initialize array of wealth
X(1,1:SWP) = SW; % Give first k players more starting wealth
 % Initialize remaining players with reduced equal wealth based on 1-SWP*SW
 % e.g 1-2*0.4
X(1,SWP+1:end) = (1 - SWP*SW) / (N-SWP);

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

    distro = rand();
    if distro <= p  % k1 wins
        k = a * min(k1,k2)*1;
        % calculate tax on winning player's wealth
        b = gamma*k; % tax rate, where b is some fraction of the wealth won that is then redistributed
        %wealth of players not in game for next round
        X(t+1,:) = (1)*X(t,:);
        %add values back to array
        X(t+1, i) = X(t, i) + k - b;
        X(t+1, j) = X(t, j) - k;
    else %k2 wins
        k = a * min(k1,k2)*1;
        % calculate tax on winning player's wealth
        b = gamma*k; % tax rate, where b is some fraction of the wealth won that is then redistributed
        %wealth of players not in game for next round
        X(t+1,:) = (1)*X(t,:);
        %add values back to array
        X(t+1, i) = X(t, i) - k;
        X(t+1, j) = X(t, j) + k - b;
    end
    % redistribute tax amount equally among all agents
    X(t+1,:) = X(t+1,:) + b/N;
end
 

plot(X)


sumofrows = sum(X,2);

Finalwealth = X(end,:);

T = transpose(Finalwealth);

winner = max(T);

