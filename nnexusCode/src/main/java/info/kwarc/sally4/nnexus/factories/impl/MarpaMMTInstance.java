package info.kwarc.sally4.nnexus.factories.impl;

import info.kwarc.sally.comm.mathhubdocument.TextPosition;
import info.kwarc.sally4.framing.DocumentLevelService;
import info.kwarc.sally4.framing.SallyFrameMenu;
import info.kwarc.sally4.mhw.base.IMathHubDocument;
//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks;
import info.kwarc.sally4.nnexus.factories.comm.MarpaStatus;
import info.kwarc.sally4.nnexus.factories.comm.NNexusLinks;
import info.kwarc.sally4.nnexus.factories.comm.NNexusStatus;
import info.kwarc.sally4.servlet.SallyServlet;
import info.kwarc.sally4.theo.Theo;

import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.apache.camel.CamelContext;
import org.apache.camel.CamelExecutionException;
import org.apache.camel.Exchange;
import org.apache.camel.Header;
import org.apache.camel.Processor;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.freemarker.FreemarkerComponent;
import org.apache.camel.component.http.HttpComponent;
import org.apache.camel.component.jackson.JacksonDataFormat;
import org.apache.camel.impl.DefaultCamelContext;
import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Invalidate;
import org.apache.felix.ipojo.annotations.Property;
import org.apache.felix.ipojo.annotations.Requires;
import org.apache.felix.ipojo.annotations.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
public class MarpaMMTInstance extends RouteBuilder implements Runnable {
	final public static String factoryid = "info.kwarc.sally4.nnexus.factories.impl.MarpaMMTInstance";
	final public static String frame = "sallyframes";
	final public static String theoid = "theo";

	Logger log;
	List<List<NNexusLinks>> last_links = null;
	String last_text = null;

	public MarpaMMTInstance() {
		log = LoggerFactory.getLogger(getClass());
	}

	@Property
	IMathHubDocument doc;

	@Requires
	SallyServlet servlet;
		
	@Requires(id=frame, filter="(filterThatWillNeverSucceed=1)")
	SallyFrameMenu sallyFrames;

	@Requires(id=theoid, filter="(filterThatWillNeverSucceed=1)")
	Theo theo;
	
	final String uuid = UUID.randomUUID().toString().replace("-", "");
	DocumentLevelService serv;

	@Validate
	void start() throws Exception {
		log = LoggerFactory.getLogger(getClass());
		CamelContext context = new DefaultCamelContext();
		context.addComponent("sallyservlet", servlet.getCamelComponent());
		context.addComponent("http", new HttpComponent());
//		context.addComponent("freemarker", new TemplatingComponent("templates/", getClass().getClassLoader()));
		context.addComponent("freemarker", new FreemarkerComponent());

		context.addRoutes(this);
		context.start();
		
		serv = new DocumentLevelService(doc.getSallyClient().getEventBusContext(), "SemantizationServices", "Marpa", servlet.getURL()+"/nnexus/static/semantify.png", this); 
		serv.start();
		getContext().createProducerTemplate().asyncSendBody("direct:initMarpa", null);
	}

	@Invalidate
	void stop() throws Exception {
		getContext().stop();
		serv.stop();
	}

	public List<List<NNexusLinks>> groupLinks(NNexusStatus status) {
		NNexusLinks []links = status.getPayload();
		for (NNexusLinks link : links) {
			String[] uri = link.getLink().split("\\?");
			link.setReplaceString("\\trefi{"+uri[uri.length - 1]+"}");
		}
		List<List<NNexusLinks>> result = new ArrayList<List<NNexusLinks>>();

		Arrays.sort(links);
		NNexusLinks last = null;
		for (NNexusLinks l : links) {
			if (last == null || last.compareTo(l) != 0) {
				last = l;
				result.add(new ArrayList<NNexusLinks>());
			} 
			result.get(result.size() - 1).add(l);
		}
		this.last_links = result;
		return result;
	}

	@Override
	public void run() {
		theo.openNewWindow(servlet.getURL()+"/nnexus/"+uuid, "NNexus", null, null, 500, 400);
	}
	
	Processor p =  new Processor() {
		@Override
		public void process(Exchange exchange) throws Exception {
		}
	};

	TextPosition textPosFromOffset(String text, int offset) {
		TextPosition result = new TextPosition();
		int row = 0;
		for (String s : text.split("\n")) {
			if (offset > s.length()) {
				offset -= s.length();
				row++;
			} else {
				result.setRow(row);
				result.setCol(offset);
				return result;
			}			
		}
		return null;
	}
	
	public void selectRequest(@Header("idx") Integer idx) throws Exception {		
		NNexusLinks lnk = last_links.get(idx).get(0);
		doc.selectText(textPosFromOffset(last_text, lnk.getOffset_begin()), textPosFromOffset(last_text, lnk.getOffset_end()));
	};
	
	public MarpaStatus prepareMarpaResults() throws CamelExecutionException, UnsupportedEncodingException {
		last_text = doc.getText();
		MarpaStatus result = getContext()
				.createProducerTemplate()
				.requestBody("direct:detectNotations", 
					"text=" + URLEncoder.encode(last_text, "UTF-8"), 
					MarpaStatus.class);
		return result;
	}
	
	@Override
	public void configure() throws Exception {
		JacksonDataFormat marpaJson = new JacksonDataFormat(MarpaStatus.class);
		InetAddress addr = InetAddress.getLocalHost();
		System.out.println("addr = " + addr.getHostAddress());
		String localhost = "http://" + addr.getHostAddress(); 
		String initialize_grammar = ":3000/initialize_grammar";
		String getContentMathML = ":8081/:marpa/getContentMathML?=";
		String detect_notations = ":3000/detect_notations";
		from("direct:initMarpa")
			.setHeader(Exchange.HTTP_METHOD, constant("POST"))
			.setHeader(Exchange.HTTP_QUERY, constant("embed=0"))
			.setHeader(Exchange.CONTENT_TYPE, constant("application/x-www-form-urlencoded"))
			.inOut(localhost + initialize_grammar)
			.to("log:receiving?showHeaders=true");
	
		from("direct:detectNotations")
			.setHeader(Exchange.HTTP_METHOD, constant("POST"))
			.setHeader(Exchange.HTTP_QUERY, constant("embed=0"))
			.setHeader(Exchange.CONTENT_TYPE, constant("application/x-www-form-urlencoded"))
			.to("log:sending?showHeaders=true")
			.convertBodyTo(String.class)
            .unmarshal(marpaJson)
		    .inOut(localhost + detect_notations);
            //.bean(method(this, "convertToString"))1
            //.convertBodyTo(String.class);
			
		from("direct:getContentMathML")
			.setHeader(Exchange.HTTP_METHOD, constant("POST"))
			.setHeader(Exchange.HTTP_QUERY, constant("embed=0"))
			.setHeader(Exchange.CONTENT_TYPE, constant("application/x-java-serialized-object"))
			.to("log:sending?showHeaders=true")
			.inOut(localhost + getContentMathML)
			.convertBodyTo(String.class)
			.to("log:sending?showHeaders=true");
				
			
		from("sallyservlet:///nnexus/"+uuid)
			.bean(method(this, "prepareMarpaResults"))
			.marshal(marpaJson)
			.to("log:JSON_RESULTS")
			.convertBodyTo(String.class)
			.setHeader("uuid", constant(uuid))
//			.to("freemarker:marpa.html"); 
			.to("freemarker:file:///home/itoloaca/Documents/sally4/nnexus/src/main/resources/templates/marpa.html"); 

		from("sallyservlet:///nnexus/"+uuid+"/select")
			.bean(method(this, "selectRequest"));
	}	
//	static public String convertToString(MarpaStatus obj) {
//		String result = "" ;
//		result += obj.getStatus() + "\n";
//		result += obj.getMessage() + "\n";
//		for (Map.Entry<String,LinkedHashMap<String, Integer[][]>[]> 
//			e: obj.getPayload().entrySet()) {
//			result += e.getKey() + "\n";
//			LinkedHashMap<String,Integer[][]>[] arr =  e.getValue();
//			for (LinkedHashMap<String,Integer[][]> arrEl : arr) {
//				for(Map.Entry<String,Integer[][]> innerEl : arrEl.entrySet()) {
//					result += innerEl.getKey() + "\n";
//					for (Integer[] i : innerEl.getValue()) {
//						for (Integer j : i) {
//							result += j + " ";
//						}
//						result += "\n";
//					}
//				}
//			}
//		}
//		System.out.println(result);
//		return result;
//	}
}
