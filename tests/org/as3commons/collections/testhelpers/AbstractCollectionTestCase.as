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

	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ITestOrder;
	import org.as3commons.collections.units.ITestSortOrder;
	import org.as3commons.collections.utils.ArrayUtils;

	/**
	 * @author Jens Struwe 18.03.2010
	 */
	public class AbstractCollectionTestCase extends TestCase {
		
		/*
		 * Test to override
		 */

		public function fillCollection(items : Array) : void {
		}

		public function createCollection() : ICollection {
			return null;
		}	

		/*
		 * Test neutralisation
		 */
		
		public var collection : ICollection;

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

		public function allKeys(iterator : IIterator) : Array {
			var keys : Array = new Array();
			var current : *;
			while (iterator.hasNext()) {
				current = iterator.next();
				if (iterator is IMapIterator) keys.push(IMapIterator(iterator).key);
				else keys.push(current); // key iterator
			}
			if (iterator is ICollectionIterator) ICollectionIterator(iterator).start();
			return keys;
		}

		public function validateItems(expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = collection.toArray();
			
			if (collection is ITestSortOrder) {
				ArrayUtils.mergeSort(expectedItems, new TestComparator());
				return ArrayUtils.arraysEqual(expectedItems, items);

			} else if (collection is ITestOrder) {
				return ArrayUtils.arraysEqual(expectedItems, items);

			} else {
				return ArrayUtils.arraysMatch(expectedItems, items);
			}
		}

		public function validateItemsStrictly(expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = collection.toArray();
			
			return ArrayUtils.arraysEqual(expectedItems, items);
		}

		public function validateTestItems(expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = collection.toArray();
			
			if (collection is ITestSortOrder) {
				expectedItems.sort(new TestComparator().compare);
				return TestItems.itemsEqual(expectedItems, items);

			} else if (collection is ITestOrder) {
				return TestItems.itemsEqual(expectedItems, items);

			} else {
				return TestItems.itemsMatch(expectedItems, items);
			}
		}

		public function validateTestItemsStrictly(expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = collection.toArray();
			
			return TestItems.itemsEqual(expectedItems, items);
		}
		
		/*
		 * Map keys
		 */

		public function validateKeys(expectedKeys : Array, keys : Array = null) : Boolean {
			if (!keys) keys = IMap(collection).keysToArray();
			
			if (collection is ITestSortOrder) {
				expectedKeys = sortKeys(expectedKeys, collection.toArray());
				return ArrayUtils.arraysEqual(expectedKeys, keys);

			} else if (collection is ITestOrder) {
				return ArrayUtils.arraysEqual(expectedKeys, keys);

			} else {
				return ArrayUtils.arraysMatch(expectedKeys, keys);
			}
		}

		public function validateKeysStrictly(expectedKeys : Array, keys : Array = null) : Boolean {
			if (!keys) keys = IMap(collection).keysToArray();
			
			return ArrayUtils.arraysEqual(expectedKeys, keys);
		}

		public function validateTestKeys(expectedKeys : Array, keys : Array = null) : Boolean {
			if (!keys) keys = IMap(collection).keysToArray();
			
			if (collection is ITestSortOrder) {
				expectedKeys = TestItems.keyArrayByIndices(expectedKeys);
				expectedKeys = sortKeys(expectedKeys, collection.toArray());
				return ArrayUtils.arraysEqual(expectedKeys, keys);

			} else if (collection is ITestOrder) {
				return TestItems.keysEqual(expectedKeys, keys);

			} else {
				return TestItems.keysMatch(expectedKeys, keys);
			}
		}

		public function validateTestKeysStrictly(expectedKeys : Array, keys : Array = null) : Boolean {
			if (!keys) keys = IMap(collection).keysToArray();
			
			return TestItems.keysEqual(expectedKeys, keys);
		}

		private function sortKeys(keys : Array, items : Array) : Array {
			var entries : Array = new Array();
			for (var i : int = 0; i < keys.length; i++) {
				entries.push(new LinkedMapNode(keys[i], IMap(collection).itemFor(keys[i])));
			}
			ArrayUtils.mergeSort(entries, new MapEntryComparator());

			var sortedKeys : Array = new Array();
			for (i = 0; i < entries.length; i++) {
				sortedKeys.push(LinkedMapNode(entries[i]).key);
			}

			return sortedKeys;
		}
	}
}

import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.testhelpers.TestComparator;

internal class MapEntryComparator extends TestComparator {
	override public function compare(item1 : *, item2 : *) : int {
		return super.compare(LinkedMapNode(item1).item, LinkedMapNode(item2).item);
	}
}
