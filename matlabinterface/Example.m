% Nikos Arechiga 2014

%% querySolver
% This is the most basic of all the functions. Queries dReal for a satisfiability query. The function returns
% two arguments, the first is either 'sat' or 'unsat' and the other is the path to the model file. This can
% be used to examine the files generated when debugging, or to use extractCEX to get the relevant model.

%
syms x y;
X = [x; y];
Xlower = [-10; -10]; % dReal likes to look at bounded regions. This provides a lower bound on each variable
Xupper = [10; 10]; % an upper bound for each variable

% querySolver wants to see a cell array of strings that represent the formulas to try to satisfy. A list of
% formulas is taken to mean the conjunction of all of the formulas.
formula = {'x^2 + y^2 < -0.1'};
[result1, cexfile] = querySolver( formula, X, Xlower, Xupper );
% result1 should be 'unsat'

% Now we will consider the 'sat' case, in which we want to look at the resulting counterexample
formula = {'x^2 + y^2 > -0.1'};
[result2, cexfile] = querySolver( formula, X, Xlower, Xupper );
cex = extractCEX( cexfile, X );
% result2 should be sat, and 'cex' contains the counterexample


% The case in which we want to produce an element of a set is very common. One can address it by using
% querySolver and extractCEX, but the convenience function 'sample' can be used to abbreviate the process
aSample = sample( formula, X, Xlower, Xupper );

% While we're at it, another common task is to produce a bunch of samples from a set. Enter the function
% multiSample. Here we will obtain 10 samples separated by a radius of sqrt(0.1). The result is given
% in a java ArrayList, so you can use all the associated methods, such as get() and even iterate through
% the list using a java iterator.
someSamples = multiSample( formula, X, Xlower, Xupper, 0.1, 10);

sampleIterator = someSamples.iterator();
while ( sampleIterator.hasNext() )
	fprintf('Here is a sample!\n');
	sampleIterator.next()
end

% Print the 5th sample -- remember that java indices start at 0!
fprintf('Here is the fifth sample!\n');
someSamples.get(4)

% One more thing. If 'sample' fails, it throws a warning and returns 'NaN'. So it's good practice
% to check the output with isnan( ) when bad things can happen if there is no sample.
formula = {'x^2 + y^2 < -0.1'};
noSample = sample( formula, X, Xlower, Xupper );

if ( isnan( noSample ) )
	fprintf('onoz!: It was NaN!\n');
else
	fprintf('It was not NaN.\n');
end

