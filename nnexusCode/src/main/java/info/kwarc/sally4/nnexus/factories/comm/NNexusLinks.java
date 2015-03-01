package info.kwarc.sally4.nnexus.factories.comm;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties(ignoreUnknown = true)
public class NNexusLinks implements Comparable<NNexusLinks>{
	String link;
	int offset_begin;
	int offset_end;

	String scheme;
	String firstword;
	String domain;
	String category;
	String concept;
	String [] multilinks;
	
	String replaceString;

	int objectid;
	int conceptid;
	
	public String getLink() {
		return link;
	}
	
	public String[] getMultilinks() {
		return multilinks;
	}
	
	public int getOffset_begin() {
		return offset_begin;
	}
	public int getOffset_end() {
		return offset_end;
	}
	public String getScheme() {
		return scheme;
	}
	public String getFirstword() {
		return firstword;
	}
	public String getDomain() {
		return domain;
	}
	public String getCategory() {
		return category;
	}
	public String getConcept() {
		return concept;
	}
	public int getObjectid() {
		return objectid;
	}
	public int getConceptid() {
		return conceptid;
	}
	public String getReplaceString() {
		return replaceString;
	}
	public void setReplaceString(String replaceString) {
		this.replaceString = replaceString;
	}

	@Override
	public int compareTo(NNexusLinks o) {
		if (offset_begin < o.offset_begin)
			 return -1;
		if (offset_begin > o.offset_begin)
			 return 1;
		if (offset_end < o.offset_end)
			 return -1;
		if (offset_end > o.offset_end)
			 return 1;
		return 0;
	}
}
