package info.kwarc.sally4.nnexus.factories.comm;

//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks.Rule;
//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks.Rule.Pos;
//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks.Rule.Pos.PosArray;
//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks.Rule.Pos.PosArray.startEnd;

import java.util.LinkedHashMap;


public class MarpaStatus implements java.io.Serializable {
	/**
	 * 
	 */
	String status;
	LinkedHashMap<String, 
		LinkedHashMap<String, Integer[][]>[]> payload;
	String message;
	
	public String getMessage() {
		return message;
	}
	public String getStatus() {
		return status;
	}	
	public LinkedHashMap<String, 
	LinkedHashMap<String, Integer[][]>[]> getPayload() { return payload;}
}


//public static class Rule extends  {
//public Rule () {
//	super();
//}
//public class Pos {
//	public class PosArray {
//		public class startEnd {
//			Integer[] startEndPos;
//			public Integer[] getStartEndPos() { return startEndPos; }
//		}
//		startEnd[] startEndArray;
//		public startEnd[] getStartEndArray() { return startEndArray; } 
//	}
//	LinkedHashMap<String, PosArray> posArray;
//	public LinkedHashMap<String, PosArray> getPosArray() { return posArray;}
//}
// 
