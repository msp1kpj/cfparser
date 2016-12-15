package cfml.parsing.cfmentat.tag;

import net.htmlparser.jericho.EndTagType;
import net.htmlparser.jericho.Source;
import net.htmlparser.jericho.StartTag;
import net.htmlparser.jericho.Tag;

final class StartTagTypeCfQueryParam extends CFMLStartTag {
	protected static final StartTagTypeCfQueryParam INSTANCE = new StartTagTypeCfQueryParam();
	
	private StartTagTypeCfQueryParam() {
		super("CFML query param tag", "<cfqueryparam", ">", EndTagType.NORMAL, false, true, true);
	}
	
	@Override
	protected Tag constructTagAt(final Source source, final int pos) {
		final StartTag startTag = (StartTag) super.constructTagAt(source, pos);
		if (startTag == null)
			return null;
		return startTag;
	}
}