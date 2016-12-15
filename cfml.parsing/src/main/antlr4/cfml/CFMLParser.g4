parser grammar CFMLParser;

options { tokenVocab=CFMLLexer; }

htmlDocument    
    : (scriptlet | SEA_WS)* xml? (scriptlet | SEA_WS)* dtd? (scriptlet | SEA_WS)* 
    	( cfmlElement | htmlElements)*
    ;

cfmlComment:
    CFML_COMMENT;

cfmlCloseTag:
    TAG_OPEN TAG_SLASH htmlTagName TAG_CLOSE;

htmlElements
    : htmlMisc* htmlElement htmlMisc*
    ; 

htmlElement     
    : cfmlCloseTag
    | TAG_OPEN htmlTagName htmlAttribute* TAG_CLOSE htmlContent TAG_OPEN TAG_SLASH htmlTagName TAG_CLOSE
    | TAG_OPEN htmlTagName htmlAttribute* TAG_SLASH_CLOSE
    | TAG_OPEN htmlTagName htmlAttribute* TAG_CLOSE
    
    | scriptlet
    | script
    | style
    ;

cfmlElement
    : cfmlComment
    | cfset
    | cfqueryparam
    ;
        
cfset
	: TAG_OPEN CFSET cfexpression (TAG_SLASH_CLOSE | TAG_CLOSE)
	; 

cfqueryparam
	: TAG_OPEN CFQUERYPARAM cfexpression (TAG_SLASH_CLOSE | TAG_CLOSE)
	; 	
 
	 
cfexpression
	: EXPRESSION
	; 

htmlContent     
    : htmlChardata? ((htmlElement | xhtmlCDATA | htmlComment) htmlChardata?)*
    ;

htmlAttribute   
    : htmlAttributeName TAG_EQUALS htmlAttributeValue
    | htmlAttributeName
    ;

htmlAttributeName
    : TAG_NAME
    ;

htmlAttributeValue
    : ATTVALUE_VALUE
    ;

htmlTagName
    : TAG_NAME
    ;

htmlChardata    
    : HTML_TEXT 
    | SEA_WS
    ;

htmlMisc        
    : htmlComment 
    | SEA_WS
    ;

htmlComment
    : HTML_COMMENT
    | HTML_CONDITIONAL_COMMENT
    ;

xhtmlCDATA
    : CDATA
    ;

dtd
    : DTD
    ;

xml
    : XML_DECLARATION
    ;

scriptlet
    : SCRIPTLET
    ;

script
    : SCRIPT_OPEN ( SCRIPT_BODY | SCRIPT_SHORT_BODY)
    ;

style
    : STYLE_OPEN ( STYLE_BODY | STYLE_SHORT_BODY)
    ;