grammar Soql;

query : selectClause WS? typeof WS? fromClause everythingElse ;

selectClause : SELECT WS (COUNT | (field WS? ( COMMA WS? field)*))? ;
field : NAME | '(' WS? query WS? ')' ;

typeof : (TYPEOF WS? NAME WS? (WHEN WS? NAME WS? THEN WS? (field WS? ( COMMA WS field)*) WS? )* (ELSE WS? (field WS? ( COMMA WS field)*) )* WS? END )? ;

fromClause : FROM WS tableName ( COMMA tableName )*
            (WS ignoreStuff)? ;
tableName : NAME WS? asClause? (USING WS? NAME)? ;
asClause : ((AS WS)? NAME) ;
everythingElse : .*? ;

ignoreStuff : WHERE? WITH? GROUP_BY? ORDER_BY? LIMIT? OFFSET? FOR? everythingElse;

SELECT : S E L E C T ;
FROM : F R O M ;
AS : A S ;
COUNT : C O U N T WS? '()' ;
TYPEOF : T Y P E O F ;
WHEN : W H E N ;
THEN : T H E N ;
ELSE : E L S E ;
END : E N D ;
USING : U S I N G ;

WHERE: W H E R E ;
WITH: W I T H ;
GROUP_BY: G R O U P WS B Y;
ORDER_BY: O R D E R WS B Y ;
LIMIT: L I M I T ;
OFFSET: O F F S E T ;
FOR: F O R ;

NAME : LETTER (NAMECHAR)* ;

WS : (ONE_SPACE+) ;
ONE_SPACE : (' ' | '\n' | '\r' | '\t') ;
COMMA : ',' ;

ANY_CHARACTER : . ;

fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');

fragment LETTER : 'a'..'z' | 'A'..'Z' ;
fragment DIGIT : '0'..'9' ;
fragment NAMECHAR : LETTER | DIGIT | '_' | '.' ;