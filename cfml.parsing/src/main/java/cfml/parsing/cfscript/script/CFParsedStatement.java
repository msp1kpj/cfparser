package cfml.parsing.cfscript.script;

import org.antlr.v4.runtime.CommonTokenStream;

/**
 * Abstract class that takes care of the line and column positions of parsed
 * elements.
 */

import org.antlr.v4.runtime.Token;

abstract public class CFParsedStatement implements CFScriptStatement, java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	protected int _line;
	protected int _col;
	protected Token token = null;
	CommonTokenStream tokens;
	
	protected CFParsedStatement(int line, int col) {
		_line = line;
		_col = col;
	}
	
	protected CFParsedStatement(Token t) {
		this(t.getLine(), t.getCharPositionInLine());
		token = t;
	}
	
	@Override
	public abstract String Decompile(int indent);
	
	@Override
	public void checkIndirectAssignments(String[] scriptSource) {
		// default behavior: do nothing
	}
	
	public int getLine() {
		return _line;
	}
	
	public int getColumn() {
		return _col;
	}
	
	public String Indent(int indent) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < indent; i++) {
			sb.append(' ');
		}
		return sb.toString();
	}
	
	public CommonTokenStream getTokens() {
		return tokens;
	}
	
	public void setTokens(CommonTokenStream tokens) {
		this.tokens = tokens;
	}
	
	public Token getToken() {
		return token;
	}
	
}