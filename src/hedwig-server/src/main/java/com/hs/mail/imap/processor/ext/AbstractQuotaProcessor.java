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
package com.hs.mail.imap.processor.ext;

import org.jboss.netty.channel.Channel;

import com.hs.mail.imap.ImapSession;
import com.hs.mail.imap.message.request.ImapRequest;
import com.hs.mail.imap.message.responder.Responder;
import com.hs.mail.imap.message.responder.ext.QuotaResponder;
import com.hs.mail.imap.processor.AbstractImapProcessor;

/**
 * 
 * @author Won Chul Doh
 * @since Apr 19, 2010
 *
 */
public abstract class AbstractQuotaProcessor extends AbstractImapProcessor {

	@Override
	protected void doProcess(ImapSession session, ImapRequest request,
			Responder responder) throws Exception {
		doProcess(session, request, (QuotaResponder) responder);
	}
	
	protected abstract void doProcess(ImapSession session, ImapRequest request,
			QuotaResponder responder) throws Exception;
	
	@Override
	protected Responder createResponder(Channel channel, ImapRequest request) {
		return new QuotaResponder(channel, request);
	}

}
