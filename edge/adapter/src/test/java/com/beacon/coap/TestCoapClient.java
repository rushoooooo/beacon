package com.beacon.coap;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import org.eclipse.californium.core.CoapClient;
import org.eclipse.californium.core.CoapResponse;
import org.eclipse.californium.elements.exception.ConnectorException;
import org.junit.Test;

public class TestCoapClient {
	
	
	@Test
	public void testClient() throws ConnectorException, IOException, URISyntaxException {
		//fancyGreeting
		URI uri = new URI("coap://127.0.0.1:5684/hello");
		CoapClient coapClient = new CoapClient(uri);
		CoapResponse response = coapClient.get();
		
		System.out.println(response.getCode());

		System.out.println(response.getOptions());

		System.out.println(response.getPayload());
		System.out.println(response.getResponseText());
		
		
		uri = new URI("coap://127.0.0.1:8083/rest/services/hello?coapMethodRestrict=GET");
		coapClient = new CoapClient(uri);
		response = coapClient.get();
		
		System.out.println(response.getCode());

		System.out.println(response.getOptions());

		System.out.println(response.getPayload());
		System.out.println(response.getResponseText());

	}
}
