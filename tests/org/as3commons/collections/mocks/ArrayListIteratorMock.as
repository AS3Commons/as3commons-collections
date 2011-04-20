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
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.core.ArrayListIterator;
	import org.as3commons.collections.units.iterators.ITestIteratorInsertionOrder;
	import org.as3commons.collections.units.iterators.ITestIteratorNextPreviousLookup;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class ArrayListIteratorMock extends ArrayListIterator implements
		ITestIteratorInsertionOrder,
		ITestIteratorNextPreviousLookup
	{

		public function ArrayListIteratorMock(list : ArrayList, index : uint = 0) {
			super(list, index);
		}
		
		public function addBeforeMock(item : *) : Boolean {
			var index : int = addBefore(item);
			return index > - 1;
		}
		
		public function addAfterMock(item : *) : Boolean {
			var index : int = addAfter(item);
			return index > -1;
		}
		
		public function replaceMock(item : *) : Boolean {
			return replace(item);
		}
		
		public function get previousMock() : * {
			return _array[previousIndex];
		}
		
		public function get nextMock() : * {
			return _array[nextIndex];
		}
	}
}
