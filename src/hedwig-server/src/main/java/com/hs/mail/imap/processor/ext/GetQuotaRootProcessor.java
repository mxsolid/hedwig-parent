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

import javax.mail.Quota;

import com.hs.mail.imap.ImapSession;
import com.hs.mail.imap.mailbox.Mailbox;
import com.hs.mail.imap.mailbox.MailboxManager;
import com.hs.mail.imap.message.request.ImapRequest;
import com.hs.mail.imap.message.request.ext.GetQuotaRootRequest;
import com.hs.mail.imap.message.responder.ext.QuotaResponder;
import com.hs.mail.imap.message.response.HumanReadableText;
import com.hs.mail.imap.message.response.ext.QuotaResponse;
import com.hs.mail.imap.user.UserManager;

/**
 * 
 * @author Won Chul Doh
 * @since Apr 19, 2010
 *
 */
public class GetQuotaRootProcessor extends AbstractQuotaProcessor {

	@Override
	protected void doProcess(ImapSession session, ImapRequest message,
			QuotaResponder responder) throws Exception {
		GetQuotaRootRequest request = (GetQuotaRootRequest) message;
		String mailboxName = request.getMailbox();
		Mailbox mailbox = null;
		if (!"".equals(mailboxName)) {
			// If not root folder
			MailboxManager mManager = getMailboxManager();
			mailbox = mManager.getMailbox(session.getUserID(), mailboxName);
			if (mailbox == null) {
				responder.taggedNo(request, HumanReadableText.MAILBOX_NOT_FOUND);
				return;
			}
		} else {
			mailbox = Mailbox.getDefaultMailbox(session.getUserID());
		}
		UserManager uManager = getUserManager();
		Quota quota = uManager.getQuota(mailbox.getOwnerID(),
				mailbox.getMailboxID(), "");
		responder.respond(new QuotaResponse(quota, mailboxName));
		responder.okCompleted(request);
	}

}
