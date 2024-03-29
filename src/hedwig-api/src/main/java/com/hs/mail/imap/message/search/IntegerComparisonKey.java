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
package com.hs.mail.imap.message.search;

/**
 * This class implements search-criteria for integers.
 * 
 * @author Won Chul Doh
 * @since Jan 30, 2010
 *
 */
public abstract class IntegerComparisonKey extends ComparisonKey {

	protected int number;

	protected IntegerComparisonKey(int comparison, int number) {
		super(comparison);
		this.number = number;
	}

	public int getNumber() {
		return number;
	}

	public boolean equals(Object obj) {
		if (!(obj instanceof IntegerComparisonKey))
			return false;
		IntegerComparisonKey ick = (IntegerComparisonKey) obj;
		return ick.number == this.number && super.equals(obj);
	}

	public int hashCode() {
		return number + super.hashCode();
	}

}
