/*
 * Copyright 2010 the original author or authors.
 * 
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package com.hs.mail.imap.processor;

import org.apache.commons.lang3.StringUtils;

import com.hs.mail.imap.ImapSession;
import com.hs.mail.imap.message.request.CapabilityRequest;
import com.hs.mail.imap.message.request.ImapRequest;
import com.hs.mail.imap.message.responder.Responder;

/**
 * 
 * @author Won Chul Doh
 * @since Feb 1, 2010
 *
 */
public class CapabilityProcessor extends AbstractImapProcessor {
	
	private static final String VERSION = "IMAP4rev1";
	
	private final static String[] capabilities = { 
			VERSION,
			"CHILDREN", 	// RFC3348
			"LITERAL+",		// RFC2088
			"NAMESPACE",	// RFC2342
			"QUOTA", 		// RFC2087
			"SORT",			// RFC5256
			"THREAD=ORDEREDSUBJECT",// RFC5256
			"THREAD=REFERENCES", 	// RFC5256
			"XREVOKE"		// CUSTOM 
	};
	
	@Override
	protected void doProcess(ImapSession session, ImapRequest message,
			Responder responder) {
		CapabilityRequest request = (CapabilityRequest) message;
		responder.untagged(request.getCommand() + " " + StringUtils.join(capabilities, ' ')
				+ "\r\n");
		responder.okCompleted(request);
	}

}
