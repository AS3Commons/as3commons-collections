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
package org.as3commons.collections.testhelpers {
	import flexunit.framework.TestCase;

	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.units.ITestOrder;
	import org.as3commons.collections.units.ITestSortOrder;
	import org.as3commons.collections.utils.ArrayUtils;

	/**
	 * @author Jens Struwe 18.03.2010
	 */
	public class AbstractIteratorTestCase extends TestCase {

		/*
		 * Test to override
		 */

		public function fillCollection(items : Array) : void {
		}

		public function createCollection() : * {
			return null;
		}

		public function getIterator(index : uint = 0) : IIterator {
			return null;
		}

		public function toArray() : Array {
			return null;
		}


		/*
		 * Test neutralisation
		 */

		public var collection : *;
		
		override public function setUp() : void {
			TestItems.init();
			collection = createCollection();
		}

		override public function tearDown() : void {
			TestItems.cleanUp();
		}

		/*
		 * Test public interface
		 */

		public function allItems(iterator : ICollectionIterator) : Array {
			var items : Array = new Array();
			while (iterator.hasNext()) {
				items.push(iterator.next());
			}
			iterator.start();
			return items;
		}

		public function allKeys(iterator : IMapIterator) : Array {
			var keys : Array = new Array();
			while (iterator.hasNext()) {
				iterator.next();
				keys.push(iterator.key);
			}
			iterator.start();
			return keys;
		}

		public function validateItems(expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = toArray();
			
			if (collection is ITestSortOrder) {
				ArrayUtils.mergeSort(expectedItems, new TestComparator());
				return ArrayUtils.arraysEqual(expectedItems, items);

			} else if (collection is ITestOrder) {
				return ArrayUtils.arraysEqual(expectedItems, items);

			} else {
				return ArrayUtils.arraysMatch(expectedItems, items);
			}
		}

		public function validateTestItems(expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = toArray();
			
			if (collection is ITestSortOrder) {
				expectedItems.sort(new TestComparator().compare);
				return TestItems.itemsEqual(expectedItems, items);

			} else if (collection is ITestOrder) {
				return TestItems.itemsEqual(expectedItems, items);

			} else {
				return TestItems.itemsMatch(expectedItems, items);
			}
		}

	}
}
