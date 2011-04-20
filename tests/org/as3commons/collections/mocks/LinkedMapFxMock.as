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
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.fx.LinkedMapFx;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.ITestDuplicates;
	import org.as3commons.collections.units.ITestInsertionOrder;

	/**
	 * @author Jens Struwe 29.03.2010
	 */
	public class LinkedMapFxMock extends LinkedMapFx implements
		ITestInsertionOrder,
		ITestDuplicates
	{

		use namespace as3commons_collections;

		override public function iterator(cursor : * = undefined) : IIterator {
			return new LinkedMapIteratorMock(this, getNode(cursor));
		}

		public function addMock(item : *) : void {
			add(UniqueMapKey.key, item);
		}

		public function addFirstMock(item : *) : void {
			addFirst(UniqueMapKey.key, item);
		}
		
		public function addLastMock(item : *) : void {
			addLast(UniqueMapKey.key, item);
		}

	}
}
