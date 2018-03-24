/**
 * Student name: 
 * Student ID: 
 */
grammar MC;

@lexer::header{
	package mc.parser;
}

@lexer::members{
@Override
public Token emit() {
    switch (getType()) {
    case UNCLOSE_STRING:       
        Token result = super.emit();
        // you'll need to define this method
        throw new UncloseString(result.getText());

    case ILLEGAL_ESCAPE:
    	result = super.emit();
    	throw new IllegalEscape(result.getText());

    case ERROR_CHAR:
    	result = super.emit();
    	throw new ErrorToken(result.getText());	

    default:
        return super.emit();
    }
}
}

@parser::header{
	package mc.parser;
}

options{
	language=Java;
}

//==========PARSER==========
program: decls main_func decls EOF;
decls: (var_decl | function_decl)*;
main_func: (var_type | VOID) 'main' LRB RRB block_statment;

var_decl: var_type var_id (COMMA var_id)* SEMI;
var_id: ID | ID LSB INT RSB;

//var_type: primitive type => boolean, int, float, string
var_type: BOOLEANTYPE | INTTYPE | FLOATTYPE | STRINGTYPE;

function_decl: function_type ID LRB parameter_list RRB block_statment;
parameter_list: (parameter_decls)?;
//function_type: primitive type, array pointer type or void type 
function_type: VOID | var_type (LSB RSB)?;
parameter_decls: parameter_decl (COMMA parameter_decl)*;
parameter_decl: var_type ID | var_type ID LSB RSB;

// statements
stmt: ifstmt | forstmt | dowhile | breakstmt | continuestmt | returnstmt | expstmt | block_statment;

ifstmt: IF LRB exp RRB stmt (ELSE stmt)?;
dowhile: DO stmt+ WHILE exp SEMI;
forstmt: FOR LRB exp? SEMI exp? SEMI exp? RRB stmt;

breakstmt: BREAK SEMI;
continuestmt: CONTINUE SEMI;
returnstmt: RETURN exp? SEMI;

expstmt: exp SEMI;

block_statment: LP var_decl* stmt* RP;

//expression
exp: term1 ASSIGN exp | term1;// assign
term1: term1 OROP term2 | term2;// or
term2: term2 ANDOP term3 | term3;// and
term3: term4 (EQOP | NEQOP) term4 | term4;// == !=
term4: term5 (LTOP | LTEOP | GTOP | GTEOP) term5 | term5;// < <= > >=
term5: term5 (ADDOP | SUBOP) term6 | term6;// + -
term6: term6 (MULTIOP | DIVOP | MODOP) term7 | term7;// * / %
term7: (NOTOP | SUBOP) term7 | term8;// - !
//term8: exp LSB exp RSB | term9;// [] 
term8: term9 LSB term9 RSB | term9;// [] 
term9: ID | INT | FLOAT | BOOLEAN | STRING | function_call |LP exp RP;
function_call: ID LRB null_exps RRB;
null_exps: (exps)?;
exps: exp (COMMA exp)*;

//==========LEXER==========
// comments
TRAD_COMMENT: '/*' ('\\'[bftrn'"\\]|[ ]|.)*? '*/' -> skip;
EOL_COMMENT: '//' ('\\'[bftrn'"\\]|[ ]|.)*? [\n] -> skip;

//----------token set----------
// keywords
STRINGTYPE: 'string';
BOOLEANTYPE: 'boolean';
TRUE: 'true';
FALSE: 'false';
FLOATTYPE: 'float';
INTTYPE: 'int';
BREAK: 'break';
CONTINUE: 'continue';
IF: 'if';
ELSE: 'else';
FOR: 'for';
RETURN: 'return';
VOID: 'void';
DO: 'do';
WHILE: 'while';

// identifiers
ID : [a-zA-Z_][a-zA-Z0-9_]* ;

// operators
ADDOP: '+';
SUBOP: '-';
MULTIOP: '*';
DIVOP: '/';

NOTOP: '!';
MODOP: '%';

OROP: '||';
ANDOP: '&&';

EQOP: '==';
NEQOP: '!=';

LTOP: '<';
LTEOP: '<=';
GTOP: '>';
GTEOP:'>=';

ASSIGN: '=';

// separators
LSB: '[';
RSB: ']';

LP: '{';
RP: '}';

LRB: '(';
RRB: ')';

SEMI: ';';
COMMA: ',';

// literals
fragment Digit: [0-9];
fragment MustD: Digit+;
fragment MayD: Digit*;
fragment Decimal: MustD'.'MayD|MayD'.'MustD;
fragment Exponent: [Ee][+-]?MustD;
INT: MustD;
FLOAT: Decimal Exponent?|MustD Exponent;
BOOLEAN: TRUE|FALSE;

//whitespace: blank, tab, formfeed, carriage return, newline
WS : [ \t\f\r\n]+ -> skip ; // skip spaces, tabs, newlines
//BACKSPACE: '\\b';
//FORMFEED: '\\f';
//SINGLEQOUTE: '\\\'';
//DOUBLEQOUTE: '\\\"';
//BACKSLASH: '\\\\';
//WHITESPACE: ' ';

fragment ABS: ('\\'[bftr'"\\]|[ ]|.)*?;
STRING: '"' ('\\'[bftr'"\\]|[ ]|.)*? '"';
UNCLOSE_STRING: '"' ('\\'[bftr'"\\]|[ ]|.)*? ('\\n')+ ('\\'[bftr'"\\]|[ ]|.)*?;
ILLEGAL_ESCAPE: '"' ('\\'[bftr'"\\]|[ ]|.)*? ('\\'~[bftrn'"\\])+ ('\\'[bftr'"\\]|[ ]|.)*? '"';
ERROR_CHAR: .;
