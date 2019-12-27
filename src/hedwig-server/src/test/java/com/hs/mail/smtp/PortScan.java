package com.hs.mail.smtp;

import java.net.InetAddress;
import java.net.Socket;

import org.junit.Test;

public class PortScan {

	@Test
	public void test() throws Exception {
		int tries = 100;
		while (--tries > 0) {
			Socket soc = new Socket(InetAddress.getByName("localhost"), 25);
			Thread.sleep(5000);
			soc.close();
			Thread.sleep(5000);
		}
	}

}
