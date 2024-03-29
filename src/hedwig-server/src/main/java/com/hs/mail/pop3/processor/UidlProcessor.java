/*
 * Copyright 2018 the original author or authors.
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
package com.hs.mail.pop3.processor;

import java.util.List;
import java.util.StringTokenizer;

import org.apache.commons.collections.CollectionUtils;

import com.hs.mail.container.server.socket.TcpTransport;
import com.hs.mail.imap.message.MessageMetaData;
import com.hs.mail.pop3.POP3Exception;
import com.hs.mail.pop3.POP3Session;

/**
 * Handler for UIDL command.
 * 
 * Returns a listing of message identifiers to the client.
 * 
 * @author Won Chul Doh
 * @since April 12, 2018
 * 
 */
public class UidlProcessor extends AbstractPOP3Processor {
	
	@Override
	void doProcess(POP3Session session, TcpTransport trans, StringTokenizer st) {
		if (session.getState() == POP3Session.State.TRANSACTION) {
			if (st.hasMoreTokens()) {
				int num = POP3Utils.getNumberParameter(nextToken(st));
				doUIDL(session, num);
			} else {
				doUIDL(session);
			}
		} else {
			throw POP3Exception.INVALID_STATE;
		}

	}

	private void doUIDL(POP3Session session, int num) {
		MessageMetaData data = POP3Utils.getMetaData(session, num);
		StringBuilder responseBuffer = new StringBuilder(64)
				.append(OK_RESPONSE)
				.append(" ")
				.append(num)
				.append(" ")
				.append(data.getUid(session.getMailboxID()));
		session.writeResponse(responseBuffer.toString());
	}

	private void doUIDL(POP3Session session) {
		List<MessageMetaData> uidList = session.getUidList();

		StringBuilder responseBuffer = new StringBuilder(32)
				.append(OK_RESPONSE)
				.append(" ")
				.append("Unique-id listing follows");
		session.writeResponse(responseBuffer.toString());

		if (CollectionUtils.isNotEmpty(uidList)) {
			List<Long> deletedUidList = session.getDeletedUidList();
			for (int i = 0; i < uidList.size(); i++) {
				MessageMetaData data = uidList.get(i);
				if (!deletedUidList.contains(data.getUid())) {
					responseBuffer = new StringBuilder(64)
							.append(i + 1)
							.append(" ")
							.append(data.getUid(session.getMailboxID()));
					session.writeResponse(responseBuffer.toString());					
				}
			}
		}
		
		session.writeResponse(".");
	}

}
