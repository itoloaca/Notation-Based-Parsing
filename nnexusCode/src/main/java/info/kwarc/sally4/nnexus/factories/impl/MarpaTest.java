package info.kwarc.sally4.nnexus.factories.impl;

//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks;
//import info.kwarc.sally4.nnexus.factories.comm.MarpaLinks.Rule;
import info.kwarc.sally4.nnexus.factories.comm.MarpaStatus;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.camel.CamelContext;
import org.apache.camel.Exchange;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.jackson.JacksonDataFormat;
import org.apache.camel.impl.DefaultCamelContext;

public class MarpaTest extends RouteBuilder {
	public static void main(String[] args) throws Exception {

		CamelContext context = new DefaultCamelContext();
		context.addRoutes(new MarpaTest());
		context.start();
		MarpaStatus status = context.createProducerTemplate()
				.requestBody("direct:sendNNexus", 
			"text = <math xmlns=\"http://www.w3.org/1998/Math/MathML\" a=\"b\"><msup ><mi>L</mi> <mn>2</mn> </msup></math>", MarpaStatus.class);
		//System.out.print(status.getMessage());
	}

	@Override
	public void configure() throws Exception {
		JacksonDataFormat marpaJson = new JacksonDataFormat(MarpaStatus.class);

		from("direct:sendNNexus")
			.setHeader(Exchange.HTTP_METHOD, constant("POST"))
			.setHeader(Exchange.HTTP_QUERY, constant("embed=0"))
			.setHeader(Exchange.CONTENT_TYPE, constant("application/x-www-form-urlencoded"))
//			.inOut("http://nnexus.mathweb.org")
			.inOut("http://localhost:3000/initialize_grammar")
//			.inOut("http://localhost:3000/detect_notations")
			.convertBodyTo(String.class)
            .unmarshal(marpaJson)
            .bean(method(this, "convertToString"));
//		    .to("log:test");
//		   System.out.print(marpaJson.getClass());
		
	}
	
	static public String convertToString(MarpaStatus obj) {
		String result = "" ;
		result += obj.getStatus() + "\n";
		result += obj.getMessage() + "\n";
		for (Map.Entry<String,LinkedHashMap<String, Integer[][]>[]> 
			e: obj.getPayload().entrySet()) {
			result += e.getKey() + "\n";
			LinkedHashMap<String,Integer[][]>[] arr =  e.getValue();
			for (LinkedHashMap<String,Integer[][]> arrEl : arr) {
				for(Map.Entry<String,Integer[][]> innerEl : arrEl.entrySet()) {
					result += innerEl.getKey() + "\n";
					for (Integer[] i : innerEl.getValue()) {
						for (Integer j : i) {
							result += j + " ";
						}
						result += "\n";
					}
				}
			}
		}
		System.out.println(result);
		return result;
	}
	
}

