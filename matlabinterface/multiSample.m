function samples = multiSample( set, variables, lowerBound, upperBound, forceField, numSamples );

	import java.util.*;

	constraints = set;
	samples = ArrayList();
	for i = 1:numSamples

		thisX = sample( constraints, variables, lowerBound, upperBound );

		if ( ~any( isnan( thisX ) ) )
			samples.add( thisX );

			constraints{end + 1} =  sprintf('%s > %1.5f', ...
							char(vpa(transpose(variables - thisX )*(variables - thisX ))), forceField);
		end

	end

	

end
