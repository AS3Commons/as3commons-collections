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
package org.as3commons.collections {
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IOrderedMap;
	import org.as3commons.collections.mocks.LinkedMapMock;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.IInsertionOrderDuplicatesTests;
	import org.as3commons.collections.units.IMapTests;

	/**
	 * @author Jens Struwe 25.03.2010
	 */
	public class LinkedMapTest extends AbstractCollectionTestCase {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new LinkedMapMock();
		}

		override public function fillCollection(items : Array) : void {
			collection.clear();
			for each (var item : * in items) {
				IOrderedMap(collection).add(UniqueMapKey.key, item);
			}
		}

		private function get _orderedMap() : IOrderedMap {
			return collection as IOrderedMap;
		}

		/*
		 * Units
		 */

		/*
		 * Collection tests
		 */

		public function test_map() : void {
			new IMapTests(this).runAllTests();
		}

		/*
		 * Order tests
		 */

		public function test_order() : void {
			new IInsertionOrderDuplicatesTests(this).runAllTests();
		}

		/*
		 * IOrderedMap
		 */

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_orderedMap is IOrderedMap);
		}

		/*
		 * Test add first last
		 */

		public function test_addFirst_withExistingKey() : void {
			fillCollection(TestItems.itemArray(3));
			
			assertTrue(_orderedMap.addFirst(4, TestItems.object4));
			assertFalse(_orderedMap.addFirst(4, TestItems.object5));
			assertTrue(_orderedMap.addFirst(5, TestItems.object4));
		}

		public function test_addLast_withExistingKey() : void {
			fillCollection(TestItems.itemArray(3));
			
			assertTrue(_orderedMap.addLast(4, TestItems.object4));
			assertFalse(_orderedMap.addLast(4, TestItems.object5));
			assertTrue(_orderedMap.addLast(5, TestItems.object4));
		}

		/*
		 * Test add before add after
		 */

		public function test_addBefore() : void {
			_orderedMap.add(TestItems.object1Key, TestItems.object1);
			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);
			
			assertTrue(_orderedMap.addBefore(TestItems.object1Key, TestItems.object4Key, TestItems.object4));

			assertTrue(validateTestKeys([4, 1, 2, 3]));
			assertTrue(validateTestItems([4, 1, 2, 3]));
			assertEquals(4, _orderedMap.size);

			assertTrue(_orderedMap.addBefore(TestItems.object3Key, TestItems.object5Key, TestItems.object5));

			assertTrue(validateTestKeys([4, 1, 2, 5, 3]));
			assertTrue(validateTestItems([4, 1, 2, 5, 3]));
			assertEquals(5, _orderedMap.size);
		}

		public function test_addBefore_existingKey() : void {
			_orderedMap.add(TestItems.object1Key, TestItems.object1);
			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);

			assertFalse(_orderedMap.addBefore(TestItems.object4Key, TestItems.object1Key, TestItems.object4));
			assertFalse(_orderedMap.addBefore(TestItems.object4Key, TestItems.object3Key, TestItems.object4));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		public function test_addBefore_wrongKey() : void {
			_orderedMap.add(TestItems.object1Key, TestItems.object1);
			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);

			assertFalse(_orderedMap.addBefore(TestItems.object4Key, TestItems.object4Key, TestItems.object4));
			assertFalse(_orderedMap.addBefore(TestItems.object5Key, TestItems.object5Key, TestItems.object5));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		public function test_addAfter() : void {
			_orderedMap.add(TestItems.object1Key, TestItems.object1);
			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);
			
			assertTrue(_orderedMap.addAfter(TestItems.object1Key, TestItems.object4Key, TestItems.object4));

			assertTrue(validateTestKeys([1, 4, 2, 3]));
			assertTrue(validateTestItems([1, 4, 2, 3]));
			assertEquals(4, _orderedMap.size);

			assertTrue(_orderedMap.addAfter(TestItems.object3Key, TestItems.object5Key, TestItems.object5));

			assertTrue(validateTestKeys([1, 4, 2, 3, 5]));
			assertTrue(validateTestItems([1, 4, 2, 3, 5]));
			assertEquals(5, _orderedMap.size);
		}

		public function test_addAfter_existingKey() : void {
			_orderedMap.add(TestItems.object1Key, TestItems.object1);
			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);

			assertFalse(_orderedMap.addAfter(TestItems.object4Key, TestItems.object1Key, TestItems.object4));
			assertFalse(_orderedMap.addAfter(TestItems.object4Key, TestItems.object3Key, TestItems.object4));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		public function test_addAfter_wrongKey() : void {
			_orderedMap.add(TestItems.object1Key, TestItems.object1);
			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);

			assertFalse(_orderedMap.addAfter(TestItems.object4Key, TestItems.object4Key, TestItems.object4));
			assertFalse(_orderedMap.addAfter(TestItems.object5Key, TestItems.object5Key, TestItems.object5));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		/*
		 * Test firstKey, lastKey
		 */

		public function test_firstKeylastKey() : void {
			assertTrue(undefined === _orderedMap.firstKey);
			assertTrue(undefined === _orderedMap.lastKey);
			
			_orderedMap.add(TestItems.object1Key, TestItems.object1);

			assertStrictlyEquals(TestItems.object1Key, _orderedMap.firstKey);
			assertStrictlyEquals(TestItems.object1Key, _orderedMap.lastKey);

			_orderedMap.add(TestItems.object2Key, TestItems.object2);
			_orderedMap.add(TestItems.object3Key, TestItems.object3);
			
			assertStrictlyEquals(TestItems.object1Key, _orderedMap.firstKey);
			assertStrictlyEquals(TestItems.object3Key, _orderedMap.lastKey);
		}

		/*
		 * Test nextKey, previousKey
		 */

		public function test_nextKeyPreviousKey() : void {
			
			// empty
			
			assertTrue(undefined === _orderedMap.nextKey(TestItems.object1Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object1Key));
			
			assertTrue(undefined === _orderedMap.nextKey(TestItems.object2Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object2Key));

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object3Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object3Key));

			// key1

			_orderedMap.add(TestItems.object1Key, TestItems.object1);

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object1Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object1Key));

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object2Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object2Key));

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object3Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object3Key));

			// key1, key2

			_orderedMap.add(TestItems.object2Key, TestItems.object2);

			assertStrictlyEquals(TestItems.object2Key, _orderedMap.nextKey(TestItems.object1Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object1Key));

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object2Key));
			assertStrictlyEquals(TestItems.object1Key, _orderedMap.previousKey(TestItems.object2Key));

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object3Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object3Key));

			// key1, key2, key3

			_orderedMap.add(TestItems.object3Key, TestItems.object3);

			assertStrictlyEquals(TestItems.object2Key, _orderedMap.nextKey(TestItems.object1Key));
			assertTrue(undefined === _orderedMap.previousKey(TestItems.object1Key));

			assertStrictlyEquals(TestItems.object3Key, _orderedMap.nextKey(TestItems.object2Key));
			assertStrictlyEquals(TestItems.object1Key, _orderedMap.previousKey(TestItems.object2Key));

			assertTrue(undefined === _orderedMap.nextKey(TestItems.object3Key));
			assertStrictlyEquals(TestItems.object2Key, _orderedMap.previousKey(TestItems.object3Key));
		}

	}
}
