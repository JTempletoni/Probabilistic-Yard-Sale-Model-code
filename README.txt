In this folder all the code pretty much does what the name suggests, the file altNbyN is the alternate N player formulated by Chorro, the files beginning with NxN are the N player simulations. 

To use any of the code that produces plots and graphics you must first run one of these files as they create the array X(t,N) for time t and N players. Then when you run the code that produces the graphics it will use the array X(t,N). 

So if you want to run a 100 player game for 100000 time steps, open one of these files, change the parameters N and n as the games run from t=1 to t=n, then open say the file "lorentzfinished" choose X(end,:) and other times in the simulation to plot the lorenz curve for t = 100000, t = 50000, etc and get the Gini index for each too. 

The file probdensity plots the probability density for theh entire array X, the file kerneldensityPDF finds the PDF at different time steps specified.

The file findingstats, creates the plots with variance and median wealth over time. 

All of the files with 2player or twoplayer in the name create different plots used in the section on two player games.

The file ECDFandCDF plots the ECDF and CDF for the entire array X as well.