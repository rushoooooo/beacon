package com.beacon.coap.router;

import org.apache.camel.ExchangePattern;
import org.apache.camel.spring.SpringRouteBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.beacon.coap.service.GreetingService;

@Component
public class CoAPRouterBuilder extends SpringRouteBuilder {

	@Autowired
    GreetingService service;
    
    @Override
    public void configure() throws Exception {
         from("coap://0.0.0.0:5684/hello")
         		.convertBodyTo(String.class)
                .setExchangePattern(ExchangePattern.InOut)
                .bean(service, "getGreeting1")
                ;
         
         from("direct:greetingRequest")
         .setExchangePattern(ExchangePattern.InOut)
         .bean(service, "getGreeting");
         
         restConfiguration("coap")
         .host("0.0.0.0")
         .port("8083")
         .contextPath("/rest/services");
         
         rest("/hello")
         .get()
         .route()
         .bean(service, "getGreeting")
         .transform(body().convertToString());
    }

}
