package info.kwarc.sally4.nnexus.factories.comm;


public class NNexusStatus {
	String status;
	NNexusLinks[] payload;
	String message;
	
	public String getMessage() {
		return message;
	}
	public NNexusLinks[] getPayload() {
		return payload;
	}
	public String getStatus() {
		return status;
	}
}
