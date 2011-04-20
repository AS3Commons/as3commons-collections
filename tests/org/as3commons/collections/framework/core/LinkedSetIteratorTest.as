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
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IOrderedSetIterator;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.mocks.LinkedSetMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
	import org.as3commons.collections.units.iterators.IIteratorInsertionOrderTests;
	import org.as3commons.collections.units.iterators.ISetIteratorTests;

	/**
	 * @author Jens Struwe 23.03.2010
	 */
	public class LinkedSetIteratorTest extends AbstractIteratorTestCase {
		
		use namespace as3commons_collections;

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new LinkedSetMock();
		}

		override public function fillCollection(items : Array) : void {
			LinkedSet(collection).clear();
			for each (var item : * in items) {
				LinkedSet(collection).add(item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			var item : *;
			if (index) {
				var i : uint = 0;
				var node : LinkedNode = LinkedSet(collection).firstNode_internal;
				while (node) {
					if (index == i) {
						item = LinkedNode(node).item;
						break;
					}
					node = node.right;
					i++;
				}
			}
			
			var iterator : ICollectionIterator = LinkedSet(collection).iterator(item) as ICollectionIterator;
			if (index && item === undefined) iterator.end();
			return iterator;
		}

		override public function toArray() : Array {
			return LinkedSet(collection).toArray();
		}

		/*
		 * Units
		 */

		/*
		 * SetIterator tests
		 */

		public function test_setIterator() : void {
			new ISetIteratorTests(this).runAllTests();
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
		 * LinkedSetIterator
		 */

		/*
		 * Test add
		 */

		public function test_addBefore_withExistingItem() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedSetIterator = getIterator() as IOrderedSetIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next()); // 1 2 | 3
			
			assertTrue(iterator.addBefore(TestItems.object4)); // 1 2 4 | 3
			assertFalse(iterator.addBefore(TestItems.object1));
			assertTrue(iterator.addBefore(TestItems.object5)); // 1 2 4 5 | 3
		}

		public function test_addAfter_withExistingItem() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedSetIterator = getIterator() as IOrderedSetIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next()); // 1 2 | 3
			
			assertTrue(iterator.addAfter(TestItems.object4)); // 1 2 | 4 3
			assertFalse(iterator.addAfter(TestItems.object1));
			assertTrue(iterator.addAfter(TestItems.object5)); // 1 2 | 5 4 3
		}

		/*
		 * Test replace with existing item
		 */

		public function test_replace_withExistingItem() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedSetIterator = getIterator() as IOrderedSetIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next()); // 1 [2] | 3
			
			assertTrue(iterator.replace(TestItems.object4)); // 1 [4] | 3
			assertTrue(validateTestItems([1, 4, 3]));

			assertFalse(iterator.replace(TestItems.object4)); // 1 [4] | 3
			assertTrue(validateTestItems([1, 4, 3]));

			assertFalse(iterator.replace(TestItems.object1)); // 1 [4] | 3
			assertTrue(validateTestItems([1, 4, 3]));

			assertTrue(iterator.replace(TestItems.object6)); // 1 [6] | 3
			assertTrue(validateTestItems([1, 6, 3]));
		}

	}
}
