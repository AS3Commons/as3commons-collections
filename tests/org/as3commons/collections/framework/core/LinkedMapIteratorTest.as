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
package org.as3commons.collections.framework.core {
	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IOrderedMapIterator;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.mocks.LinkedMapMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
	import org.as3commons.collections.units.iterators.IIteratorInsertionOrderTests;
	import org.as3commons.collections.units.iterators.IMapIteratorTests;

	/**
	 * @author Jens Struwe 23.03.2010
	 */
	public class LinkedMapIteratorTest extends AbstractIteratorTestCase {
		
		use namespace as3commons_collections;

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new LinkedMapMock();
		}

		override public function fillCollection(items : Array) : void {
			LinkedMap(collection).clear();
			for each (var item : * in items) {
				LinkedMap(collection).add(UniqueMapKey.key, item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			var key : *;
			var i : uint = 0;
			if (index) {
				var node : LinkedNode = LinkedMap(collection).firstNode_internal;
				while (node) {
					if (index == i) {
						key = LinkedMapNode(node).key;
						break;
					}
					node = node.right;
					i++;
				}
			}

			var iterator : ICollectionIterator = LinkedMap(collection).iterator(key) as ICollectionIterator;
			if (index && key === undefined) iterator.end();
			return iterator;
		}

		override public function toArray() : Array {
			return LinkedMap(collection).toArray();
		}

		/*
		 * Units
		 */

		/*
		 * MapIterator tests
		 */

		public function test_mapIterator() : void {
			new IMapIteratorTests(this).runAllTests();
		}

		/*
		 * IIteratorInsertionOrderTests tests
		 */

		public function test_iteratorInsertionOrder() : void {
			new IIteratorInsertionOrderTests(this).runAllTests();
		}

		/*
		 * StartIndexTests tests
		 */

		public function test_collectionIteratorStartIndex() : void {
			new ICollectionIteratorStartIndexTests(this).runAllTests();
		}
		
		/*
		 * LinkedMapIterator
		 */

		/*
		 * Test add
		 */

		public function test_addBefore_withExistingKey() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedMapIterator = getIterator() as IOrderedMapIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next()); // 1 2 | 3
			
			assertTrue(iterator.addBefore(10, TestItems.object4)); // 1 2 4 | 3
			assertFalse(iterator.addBefore(10, TestItems.object5));
			assertTrue(iterator.addBefore(11, TestItems.object5)); // 1 2 4 5 | 3
		}

		public function test_addAfter_withExistingKey() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedMapIterator = getIterator() as IOrderedMapIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next()); // 1 2 | 3
			
			assertTrue(iterator.addAfter(10, TestItems.object4)); // 1 2 | 4 3
			assertFalse(iterator.addAfter(10, TestItems.object5));
			assertTrue(iterator.addAfter(11, TestItems.object5)); // 1 2 | 5 4 3
		}

	}
}
