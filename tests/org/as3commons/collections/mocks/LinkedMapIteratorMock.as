/**
 * Copyright 2010 The original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.as3commons.collections.mocks {
	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.framework.core.LinkedMapIterator;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.iterators.ITestIteratorInsertionOrder;
	import org.as3commons.collections.units.iterators.ITestIteratorNextPreviousLookup;

	/**
	 * @author Jens Struwe 25.03.2010
	 */
	public class LinkedMapIteratorMock extends LinkedMapIterator implements
		ITestIteratorInsertionOrder,
		ITestIteratorNextPreviousLookup
	{
		public function LinkedMapIteratorMock(map : LinkedMap, next : LinkedMapNode = null) {
			super(map, next);
		}

		public function addBeforeMock(item : *) : Boolean {
			return addBefore(UniqueMapKey.key, item);
		}
		
		public function addAfterMock(item : *) : Boolean {
			return addAfter(UniqueMapKey.key, item);
		}
		
		public function get previousMock() : * {
			return LinkedMap(_collection).itemFor(previousKey);
		}
		
		public function get nextMock() : * {
			return LinkedMap(_collection).itemFor(nextKey);
		}

	}
}
