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
	import org.as3commons.collections.SortedList;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.units.ITestDuplicates;
	import org.as3commons.collections.units.ITestSortOrderDuplicateEquals;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class SortedListMock extends SortedList implements 
		ITestSortOrderDuplicateEquals,
		ITestDuplicates
	{

		public function SortedListMock(comparator : IComparator = null) {
			super(comparator);
		}
		
		override public function iterator(cursor : * = undefined) : IIterator {
			return new SortedListIteratorMock(this, cursor);
		}

		public function addMock(item : *) : void {
			add(item);
		}
		
		public function lesser(item : *) : * {
			return itemAt(lesserIndex(item));
		}
		
		public function higher(item : *) : * {
			return itemAt(higherIndex(item));
		}

		public function equalItems(item : *) : Array {
			var indices : Array = equalIndices(item);
			var items : Array = new Array();
			for each (var index : uint in indices) {
				items.push(itemAt(index));
			}
			return items;
		}
	}
}
