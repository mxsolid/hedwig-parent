package com.hs.mail.imap.message.builder.ext;

import com.hs.mail.imap.message.builder.ImapRequestBuilder;
import com.hs.mail.imap.message.request.ImapRequest;
import com.hs.mail.imap.message.request.ext.GetACLRequest;
import com.hs.mail.imap.server.codec.ImapMessage;

/**
 * 
 * @author Wonchul Doh
 * @since December 2, 2016
 *
 */
public class GetACLRequestBuilder extends ImapRequestBuilder {

	@Override
	public ImapRequest createRequest(String tag, String command,
			ImapMessage message) {
		String mailbox = message.getTokens().remove().value;
		return new GetACLRequest(tag, command, mailbox);
	}

}
