package info.kwarc.sally4.nnexus.factories;

import info.kwarc.sally4.framing.DocumentLevelService;
import info.kwarc.sally4.framing.SallyFrameMenu;
import info.kwarc.sally4.mhw.base.IMathHubDocument;
import info.kwarc.sally4.nnexus.factories.impl.MarpaMMTInstance;
import info.kwarc.sally4.nnexus.factories.impl.NNexusInstance;
import info.kwarc.sally4.servlet.SallyServlet;
import info.kwarc.sally4.theo.Theo;
import info.kwarc.sally4.util.InstanceCreator;

import java.util.ArrayList;
import java.util.List;

import org.apache.camel.CamelContext;
import org.apache.camel.impl.DefaultCamelContext;
import org.apache.felix.ipojo.ConfigurationException;
import org.apache.felix.ipojo.Factory;
import org.apache.felix.ipojo.MissingHandlerException;
import org.apache.felix.ipojo.UnacceptableConfiguration;
import org.apache.felix.ipojo.annotations.Bind;
import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Invalidate;
import org.apache.felix.ipojo.annotations.Requires;
import org.apache.felix.ipojo.annotations.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
@Instantiate
public class NNexusFactory {

	@Requires(filter="(factory.name="+NNexusInstance.factoryid +")")
	Factory factoryNNexus;

	@Requires(filter="(factory.name="+MarpaMMTInstance.factoryid+")")
	Factory factoryMarpa;

	List<DocumentLevelService> docLevelServices;

	@Requires
	SallyServlet servlet;

	Logger log;

	CamelContext context;
	
	@Validate
	void start() throws Exception {
		log = LoggerFactory.getLogger(getClass());
		docLevelServices = new ArrayList<>();
		context = new DefaultCamelContext();
		context.addComponent("sallyservlet", servlet.getCamelComponent());
		servlet.init(context, getClass().getClassLoader()).serveStaticFiles("nnexus/static", "static");
		context.start();
	}

	@Invalidate
	void stop() throws Exception {
		context.stop();
	}

	@Bind(aggregate=true)
	void onNewTextDocument(final IMathHubDocument doc) throws UnacceptableConfiguration, MissingHandlerException, ConfigurationException {

		String docQueue = doc.getSallyClient().getDocQueue();
		String envId = doc.getSallyClient().getEnvironmentID();

		InstanceCreator.init(factoryNNexus)
		.setInstanceName("NNexus for "+docQueue)
		.setProperty("doc", doc)
		.setDynamicRequirement(NNexusInstance.frame, "("+SallyFrameMenu.clientProperty+"="+docQueue+")")
		.setDynamicRequirement(NNexusInstance.theoid, "("+Theo.environmentID+"="+envId+")")
		.create();

		/*
		InstanceCreator.init(factoryMarpa)
			.setInstanceName("MarpaMMT for "+docQueue)
			.setProperty("doc", doc)
			.setDynamicRequirement(MarpaMMTInstance.frame, "("+SallyFrameMenu.clientProperty+"="+docQueue+")")
			.setDynamicRequirement(MarpaMMTInstance.theoid, "("+Theo.environmentID+"="+envId+")")
			.create();
		 */
	}

}
