package com.beacon.coap.service;

import org.springframework.stereotype.Service;

import com.beacon.coap.pojo.Greeting;

@Service
public class GreetingService {
	public Greeting getGreeting() {
        return new Greeting(System.currentTimeMillis(), "some kewl greeting");
    }
	
	public String getGreeting1() {
        return new Greeting(System.currentTimeMillis(), "some kewl greeting").toString();
    }
}
