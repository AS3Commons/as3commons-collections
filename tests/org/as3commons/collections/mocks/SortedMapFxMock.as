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
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.fx.SortedMapFx;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.ITestDuplicates;
	import org.as3commons.collections.units.ITestSortOrderDuplicateEquals;

	/**
	 * @author Jens Struwe 30.03.2010
	 */
	public class SortedMapFxMock extends SortedMapFx implements
		ITestSortOrderDuplicateEquals,
		ITestDuplicates
	{
		public function SortedMapFxMock(comparator : IComparator) {
			super(comparator);
		}
		
		override public function iterator(cursor : * = undefined) : IIterator {
			return new SortedMapIteratorMock(this, getNode(cursor));
		}

		public function addMock(item : *) : void {
			add(UniqueMapKey.key, item);
		}
		
		public function lesser(item : *) : * {
			return itemFor(lesserKey(item));
		}
		
		public function higher(item : *) : * {
			return itemFor(higherKey(item));
		}

		public function equalItems(item : *) : Array {
			var keys : Array = equalKeys(item);
			var items : Array = new Array();
			for each (var key : * in keys) {
				items.push(itemFor(key));
			}
			return items;
		}
	}
}
