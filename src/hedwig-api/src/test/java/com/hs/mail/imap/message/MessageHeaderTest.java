package com.hs.mail.imap.message;

import java.io.UnsupportedEncodingException;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import org.apache.james.mime4j.stream.RawField;
import org.junit.Test;

public class MessageHeaderTest {

	@Test
	public void test() {
		String body = "\"도원철\" <wonchul.do@konantech.com>, \"이문기\" <mklee@konantech.com>, wonchul.do@konantech.com";
		RawField rawField = new RawField("To", body);
		try {
			InternetAddress[] addresses = InternetAddress.parse(rawField.getBody());
			for (int i = 0; i < addresses.length; i++) {
				if (addresses[i].getPersonal() != null) {
					InternetAddress address = new InternetAddress(
							addresses[i].getAddress(),
							addresses[i].getPersonal(), "UTF-8");
					System.out.println(address.toString());
				} else {
					System.out.println(addresses[i].toString());
				}
			}
		} catch (AddressException e) {
		} catch (UnsupportedEncodingException e) {
		}
	}

}
