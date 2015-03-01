package info.kwarc.sally4.nnexus.factories.impl;

import info.kwarc.sally.comm.mathhubdocument.TextPosition;
import info.kwarc.sally4.framing.DocumentLevelService;
import info.kwarc.sally4.framing.SallyFrameMenu;
import info.kwarc.sally4.mhw.base.IMathHubDocument;
import info.kwarc.sally4.nnexus.factories.comm.NNexusLinks;
import info.kwarc.sally4.nnexus.factories.comm.NNexusStatus;
import info.kwarc.sally4.servlet.SallyServlet;
import info.kwarc.sally4.servlet.impl.ServletController;
import info.kwarc.sally4.theo.Theo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.apache.camel.CamelContext;
import org.apache.camel.Exchange;
import org.apache.camel.Header;
import org.apache.camel.Processor;
import org.apache.camel.builder.RouteBuilder;
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
public class NNexusInstance extends RouteBuilder implements Runnable {
	final public static String factoryid = "info.kwarc.sally4.nnexus.factories.impl.NNexusInstance";
	final public static String frame = "sallyframes";
	final public static String theoid = "theo";

	Logger log;
	List<List<NNexusLinks>> last_links = null;
	String last_text = null;

	public NNexusInstance() {
		log = LoggerFactory.getLogger(getClass());
	}

	@Property
	IMathHubDocument doc;

	@Requires
	SallyServlet servlet;
    ServletController sc;

	@Requires(id=frame, filter="(filterThatWillNeverSucceed=1)")
	SallyFrameMenu sallyFrames;

	@Requires(id=theoid, filter="(filterThatWillNeverSucceed=1)")
	Theo theo;
	
	final String uuid = UUID.randomUUID().toString().replace("-", "");
	String serviceId;

	DocumentLevelService serv;
	
	@Validate
	void start() throws Exception {
		log = LoggerFactory.getLogger(getClass());
		CamelContext context = new DefaultCamelContext();
		
		context.addComponent("sallyservlet", servlet.getCamelComponent());
		sc = servlet.init(context, getClass().getClassLoader())
			.initTemplating("templates");

		context.addComponent("http", new HttpComponent());
		context.addRoutes(this);
		context.start();
		
		serv = new DocumentLevelService(doc.getSallyClient().getEventBusContext(), "SemantizationServices", "NNexus", servlet.getURL()+"/nnexus/static/icon.gif", this);	
		serv.start();
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
				offset -= s.length() + 1;
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
		if (last_links == null || last_links.size()<=idx)
			return;
		
		NNexusLinks lnk = last_links.get(idx).get(0);
		log.info("Selectig link "+lnk.getOffset_begin()+"-"+lnk.getOffset_end());
		doc.selectText(textPosFromOffset(last_text, lnk.getOffset_begin()), textPosFromOffset(last_text, lnk.getOffset_end()));
	};

	public void linkRequest(@Header("idx") Integer idx, @Header("variant") Integer variant) throws Exception {
		if (last_links == null || last_links.size()<=idx)
			return;
		
		NNexusLinks lnk = last_links.get(idx).get(variant);
		log.info("Linking variant "+lnk.getOffset_begin()+"-"+lnk.getOffset_end());
		doc.replaceText(textPosFromOffset(last_text, lnk.getOffset_begin()), textPosFromOffset(last_text, lnk.getOffset_end()), lnk.getReplaceString());
	};

	
	public List<List<NNexusLinks>> prepareNNexusResults() {
		last_text = doc.getText();
		log.info("Sending text "+last_text);
		NNexusStatus status = getContext().createProducerTemplate().requestBody("direct:sendNNexus", last_text, NNexusStatus.class);
		return groupLinks(status);
	}
	
	@Override
	public void configure() throws Exception {
		JacksonDataFormat nnexusJson = new JacksonDataFormat(NNexusStatus.class);

		from("direct:sendNNexus")
			.setHeader(Exchange.HTTP_METHOD, constant("POST"))
			.setHeader(Exchange.HTTP_QUERY, constant("embed=0"))
			.setHeader(Exchange.CONTENT_TYPE, constant("application/x-www-form-urlencoded"))
			.inOut("http://nnexus.mathweb.org")
			.unmarshal(nnexusJson);

		from("sallyservlet:///nnexus/"+uuid)
			.bean(method(this, "prepareNNexusResults"))
			.marshal(nnexusJson)
			.convertBodyTo(String.class)
			.setHeader("uuid", constant(uuid))
			.to(sc.tpl("index.html")); 

		from("sallyservlet:///nnexus/"+uuid+"/select")
			.bean(method(this, "selectRequest"));

		from("sallyservlet:///nnexus/"+uuid+"/doLink")
			.bean(method(this, "linkRequest"));

	}	

}
