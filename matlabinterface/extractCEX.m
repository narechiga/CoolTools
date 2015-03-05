function cex = extractCEX( filename, X )

	replaceSemicolons = sprintf('perl -p -i -e "s/;//g" %s\n', filename);
	system(replaceSemicolons);

	cexfile = fopen( filename, 'r');
	fgetl( cexfile ); % discard human-friendly header
	clear cex_output; clear cex_lo; clear cex_hi;
	cex_output = textscan( cexfile, '%s : [%n, %n]');
	fclose( cexfile );
	cex_label = cex_output{1}; cex_lo = cex_output{2}; cex_hi = cex_output{3};

	cex = [];
	for i = 1:length(cex_lo)
		cexindex = find(strcmp( sprintf('%s', char(X(i))), cex_label));
		cex = [cex; (cex_lo(cexindex) + cex_hi(cexindex))/2];
	end

end

