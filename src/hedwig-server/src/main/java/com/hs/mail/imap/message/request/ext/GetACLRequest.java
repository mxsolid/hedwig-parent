package com.hs.mail.imap.message.request.ext;

import com.hs.mail.imap.message.request.AbstractMailboxRequest;

/**
 * 
 * @author Wonchul Doh
 * @since December 2, 2016
 *
 */
public class GetACLRequest extends AbstractMailboxRequest {

	public GetACLRequest(String tag, String command, String mailbox) {
		super(tag, command, mailbox);
	}

}
