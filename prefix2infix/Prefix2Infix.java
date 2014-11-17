import java.util.*;
import java.io.*;

class Prefix2Infix {

	public static void main (String [] args) {

        	// COLORS! OMG COLORS!
        	public static final String ANSI_RESET = "\u001B[0m";
        	public static final String ANSI_BLACK = "\u001B[30m";
        	public static final String ANSI_RED = "\u001B[31m";
        	public static final String ANSI_GREEN = "\u001B[32m";
        	public static final String ANSI_YELLOW = "\u001B[33m";
        	public static final String ANSI_BLUE = "\u001B[34m";
        	public static final String ANSI_PURPLE = "\u001B[35m";
        	public static final String ANSI_CYAN = "\u001B[36m";
        	public static final String ANSI_WHITE = "\u001B[37m";
        	public static final String ANSI_BOLD = "\u001B[1m";

		String input = null;
		Scanner in = new Scanner( System.in );

		if ( args.length > 0 ) {
			//System.out.println("I got an argument!: " + args[0] );
			String filename = args[0];
			
			try {
				BufferedReader reader = new BufferedReader( new FileReader( new File( filename )));

				String instring = reader.readLine();
				//System.out.println( instring );
				StringReader inreader = new StringReader( instring + "\n" );
				Lexer myLexer = new Lexer( inreader );
				YYParser myParser = new YYParser( myLexer );
				myParser.parse();

			} catch ( Exception e ) {
				System.err.println( e );
			}

		} else {

			try {
				do {
					System.out.print(ANSI_BOLD + "INPUT: " + ANSI_RESET + ANSI_YELLOW );
					input = in.nextLine() + "\n";
					StringReader inreader = new StringReader( input );
					Lexer myLexer = new Lexer( inreader );
					YYParser myParser = new YYParser( myLexer );
					myParser.parse()

				} while ( input != null );
			} catch ( Exception e ) {
				System.err.println( e );
			}
		}
	}
}


