package com.beacon.coap;

import org.apache.camel.ConsumerTemplate;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.aop.AopAutoConfiguration;

@SpringBootApplication
@EnableAutoConfiguration(exclude = {AopAutoConfiguration.class,})
public class CoapEdgeServer {

	ConsumerTemplate consumerTemplate;

	public static void main(String[] args) {
		SpringApplication.run(CoapEdgeServer.class, args);
	}

}
