package com.hs.mail.dns;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Collection;

import org.junit.BeforeClass;
import org.junit.Test;

public class DnsServerTest {
	
	private static DnsServer dns;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		dns = new DnsServer();
		dns.afterPropertiesSet();
	}

	@Test
	public void test() {
		String hostname = "msa.hinet.net";
		Collection<String> records = dns.findMXRecords(hostname);
		for (String record : records) {
			try {
				final InetAddress[] addresses = dns.getAllByName(record);
				System.out.println(record);
				for (InetAddress address : addresses) {
					System.out.println("\t" + address);
				}
			} catch (UnknownHostException e) {
			}
		}
	}

}
