% Attempts to replicate "An economically realistic asset exchange model".
% different biases in exchanges, based on microeconomic
% foundations. probably best to use cases, biased in favour of wealthiest
% agent. Wealth attained advantage (WAA).

N = 10; %number of players
a = 0.1; %rand(); %random fraction in interval [0,1] won
b = 0.01; % tax rate, where b = a^2
e = 5; %basic parameter epsilon/delta for the WAA equation bias from Boghosian etc.
n = 10000; % how many rounds of the game

t = 1; % initial t
p_values = [];  %array to store values of p as it now varies depending on WAA

X = zeros(t, N); %initialize array of wealth
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
    %update array X to give them a name.
      k1 = X(t, i); % player 1
      k2 = X(t, j); % player 2
      distro = rand(); % ranom uniform distribution between 0 and 1
      k =   a * min(k1,k2)*1; % wealth won is a fraction "a" of the poorer players wealth
     if k1 > k2 % if player k1 is richer than k2
             p = 1/2 + e*(k1-k2)  %update win chance with wealth attained advantage,
             p_values = [p_values p] ;                     % i.e. richer player has higher probability
         if distro <= p  % k1 wins
            
        %wealth of players not in game for next round
            X(t+1,:) = (1-b)*X(t,:) + b/N;
        %add values back to array
            X(t+1, i) = X(t, i) + k; % k1 winning new wealth
            X(t+1, j) = X(t, j) - k; % k2 losing new wealth
        else %k2 wins
        %wealth of players not in game for next round
            X(t+1,:) = (1-b)*X(t,:) + b/N;
        %add values back to array
            X(t+1, i) = X(t, i) - k; % k1 losing new wealth
            X(t+1, j) = X(t, j) + k; % k2 winning new wealth
        end                         
     else % i.e k2 > k1, so k2 is richer 
         p = 1/2 + e*(k2-k1);
         p_values = [p_values p];
        if distro <= p  % k2 wins
             %wealth of players not in game for next round
            X(t+1,:) = (1-b)*X(t,:) + b/N;
        %add values back to array
            X(t+1, i) = X(t, i) - k;
            X(t+1, j) = X(t, j) + k;
         else %k1 wins    
        %wealth of players not in game for next round
            X(t+1,:) = (1-b)*X(t,:) + b/N;
        %add values back to array
            X(t+1, i) = X(t, i) + k;
            X(t+1, j) = X(t, j) - k;
             
         end
   
    end
end

    
plot(X);

M_row2 = reshape(X, 1, []);


sumofrows = sum(X,2);

Finalwealth = X(end,:);

T = transpose(Finalwealth);

winner = max(T);
