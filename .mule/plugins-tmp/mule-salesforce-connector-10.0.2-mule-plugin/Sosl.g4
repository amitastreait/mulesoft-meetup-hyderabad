grammar Sosl;

query : findClause WS? inClause? WS? returningClause? (WS everythingElse)?;

findClause: FIND WS? searchQuery;
searchQuery: LEFT_CURLY_BRACKET .*? RIGHT_CURLY_BRACKET;
inClause: IN WS .*? WS FIELDS;
returningClause: RETURNING WS? entities;
entities: entity (COMMA WS? entity)*;
entity: name WS? (entityFields)?;
entityFields: LEFT_ROUND_BRACKET WS? name (WS? COMMA WS? name WS?)* (WS? simpleFilter)? RIGHT_ROUND_BRACKET;
name: TEXT;
simpleFilter: (USING|WHERE|ORDER_BY|LIMIT|OFFSET) WS .*?;
everythingElse: .*?;

FIND: F I N D;
IN: I N;
RETURNING: R E T U R N I N G;
USING: U S I N G;
WHERE: W H E R E;
ORDER_BY: O R D E R WS B Y;
LIMIT: L I M I T;
OFFSET: O F F S E T;
FIELDS: F I E L D S;

TEXT: NAMECHAR+;

WS: (ONE_SPACE+) ;
ONE_SPACE: (' ' | '\n' | '\r' | '\t') ;
COMMA: ',' ;
LEFT_CURLY_BRACKET: '{';
RIGHT_CURLY_BRACKET: '}';
LEFT_ROUND_BRACKET: '(';
RIGHT_ROUND_BRACKET: ')';
SINGLE_QUOTE: '\'';
DOUBLE_QUOTE: '\"';


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
fragment SPECIAL_CHARACTERS : '~' | '!' | '@' | '#' | '$' | '%' | '^' | '&' | '*' | '-' | '+' | '=' | '.' | '_' | '\\' | '?';
fragment NAMECHAR : LETTER | DIGIT | SPECIAL_CHARACTERS ;
