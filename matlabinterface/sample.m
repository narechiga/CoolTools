function aSample = sample( set, variables, lower, upper )

	[sampleresult, samplemodel] = querySolver( set, variables, lower, upper );	

	if ( strcmp(sampleresult, 'unsat' ) )
		warning('No sample found');
		aSample = NaN;
	else
		aSample = extractCEX( samplemodel );
	end
end
