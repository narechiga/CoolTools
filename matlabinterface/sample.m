% Nikos Arechiga 2014

function aSample = sample( set, variables, lower, upper )
% Uses dReal to sample a given set

	[sampleresult, samplemodel] = querySolver( set, variables, lower, upper );	

	if ( strcmp(sampleresult, 'unsat' ) )
		warning('No sample found');
		aSample = NaN;
	else
		aSample = extractCEX( samplemodel, variables );
	end
end
