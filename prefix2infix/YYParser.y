%{
import java.util.*;

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


%}

%language "Java"

%token NUMBER
%token IDENTIFIER
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token POWER
%token NEWLINE
%token LPAREN
%token RPAREN
%token COMPARATOR
%token COMMA

%left COMPARATOR /* <, >, <=, >=, =, != */
%left MINUS PLUS
%left TIMES DIVIDE
%left NEGATIVE
%right POWER

%token AND
%token OR
%token NOT
%token IMPLIES

%right IMPLIES
%right OR
%right AND
%left NOT


%%
input:
	NEWLINE
	| logic NEWLINE 			{ System.out.println( ANSI_CYAN + ANSI_BOLD + $1 + ANSI_RESET ); }
	| term NEWLINE				{ System.out.println( ANSI_RED + ANSI_BOLD + $1 + ANSI_RESET ); }
	;

logic:
	comparison 				{ $$ = $1; }

	// Throw a syntax error if less than two arguments
	| AND logiclist 			{ $$ = "(and " + (String)$1 + " " + (String)$3 + " )"; }
	| OR logiclist				{ $$ = "(or " + (String)$1 + " " + (String)$3 + " )"; }
	| NOT logic				{ $$ = "(not " + (String)$2 + " )"; }
	| LPAREN logic RPAREN			{ $$ = "( " + (String)$2 + ")"; }
	| IMPLIES logic logic			{ $$ = "(implies " + (String)$1 + " " + (String)$3 + " )"; }
;

comparison:
	LPAREN COMPARATOR term term RPAREN	{ $$ = "(" + (String)$2 +" "+ (String)$1 + " " + (String)$3 + ")"; }
	;


term:
	LPAREN IDENTIFIER termlist RPAREN 	{ $$ = "(" + (String)$1 + ", " + (String)$3 + ")";		}
	| NUMBER				{ $$ = (String)$1; 						}
	| IDENTIFIER				{ $$ = (String)$1; 						}
	| LPAREN term RPAREN 			{ $$ = "("+ (String)$2 +")"; 					}

	| LPAREN PLUS termlist RPAREN { 
		ArrayList<String> arguments = ((ArrayList<String>)$3);

		if ( arguments.size() < 2 ) {
			throw new Exception("Syntax error: addition has too few arguments");

		} else {
			$$ = "( " + interpolate( arguments, (String)$2 ) + " )";
		}
	}
	| LPAREN TIMES termlist RPAREN	{ 
		ArrayList<String> arguments = ((ArrayList<String>)$3);

		if ( arguments.size() < 2 ) {
			throw new Exception("Syntax error: multiplication has too few arguments");

		} else {
			$$ = "( " + interpolate( arguments, (String)$1 ) + " )";
		}

	}

	| LPAREN MINUS term RPAREN			{ $$ = "(- " + (String)$3 + ")";		}
	| LPAREN MINUS term term RPAREN			{ $$ = (String)$4 + " -  " + (String)$5 + ")";	}
	| LPAREN DIVIDE term term RPAREN		{ $$ = "( " + (String)$3 + "/" + (String)$4 + ")";		}
	| LPAREN POWER term term RPAREN			{ $$ = "( " + (String)$3 + "^" + (String)$4 + ")";		}
	;

logiclist:
	logic { 
		ArrayList<String> logicList = new ArrayList<>();
		logicList.add( (String)$1 );

		$$ = logicList;

	} | logiclist logic { 
		ArrayList<String> logicList = ((ArrayList<String>) $1);
		logicList.add( (String)$2 );

		$$ = logicList;
	}   
;


termlist:
	term { 
		ArrayList<String> termList = new ArrayList<>();
		termList.add( (String)$1 );

		$$ = termList;

	} | termlist term { 
		ArrayList<String> termList = ((ArrayList<String>) $1);
		termList.add( (String)$2 );

		$$ = termList;
	}
;

	
%%

%code{
	String interpolate( ArrayList<String> arguments, String operator ) {
	
		String returnString = "";

		Iterator<String> argumentIterator = arguments.iterator();
		String thisArgument;
		while( argumentIterator.hasNext() ) {
		
			thisArgument = argumentIterator.next();

			if ( argumentIterator.hasNext() ){
				returnString = returnString + " " + thisArgument + " " + operator;

			} else {
				returnString = returnString + " " + thisArgument; 

			}

		}
	
		return returnString;
	}
}


