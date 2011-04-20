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
	import org.as3commons.collections.framework.IOrderedSet;
	import org.as3commons.collections.mocks.LinkedSetMock;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.IInsertionOrderTests;
	import org.as3commons.collections.units.ISetTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class LinkedSetTest extends AbstractCollectionTestCase {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new LinkedSetMock();
		}

		override public function fillCollection(items : Array) : void {
			collection.clear();
			for each (var item : * in items) {
				IOrderedSet(collection).add(item);
			}
		}

		private function get _orderedSet() : IOrderedSet {
			return collection as IOrderedSet;
		}

		/*
		 * Units
		 */

		/*
		 * Set tests
		 */

		public function test_set() : void {
			new ISetTests(this).runAllTests();
		}

		/*
		 * Order tests
		 */

		public function test_order() : void {
			new IInsertionOrderTests(this).runAllTests();
		}

		/*
		 * IOrderedSet
		 */

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_orderedSet is IOrderedSet);
		}

		/*
		 * Test add first last
		 */

		public function test_addFirst_withExistingItem() : void {
			fillCollection(TestItems.itemArray(3));
			
			assertTrue(_orderedSet.addFirst(TestItems.object4));
			assertFalse(_orderedSet.addFirst(TestItems.object4));
			assertTrue(_orderedSet.addFirst(TestItems.object5));
		}

		public function test_addLast_withExistingItem() : void {
			fillCollection(TestItems.itemArray(3));
			
			assertTrue(_orderedSet.addLast(TestItems.object4));
			assertFalse(_orderedSet.addLast(TestItems.object4));
			assertTrue(_orderedSet.addLast(TestItems.object5));
		}

		/*
		 * Test add before add after
		 */

		public function test_addBefore() : void {
			_orderedSet.add(TestItems.object1);
			_orderedSet.add(TestItems.object2);
			_orderedSet.add(TestItems.object3);
			
			assertTrue(_orderedSet.addBefore(TestItems.object1, TestItems.object4));

			assertTrue(validateTestItems([4, 1, 2, 3]));
			assertTrue(validateTestItems([4, 1, 2, 3]));
			assertEquals(4, _orderedSet.size);

			assertTrue(_orderedSet.addBefore(TestItems.object3, TestItems.object5));

			assertTrue(validateTestItems([4, 1, 2, 5, 3]));
			assertTrue(validateTestItems([4, 1, 2, 5, 3]));
			assertEquals(5, _orderedSet.size);
		}

		public function test_addBefore_existingItem() : void {
			_orderedSet.add(TestItems.object1);
			_orderedSet.add(TestItems.object2);
			_orderedSet.add(TestItems.object3);

			assertFalse(_orderedSet.addBefore(TestItems.object1, TestItems.object1));
			assertFalse(_orderedSet.addBefore(TestItems.object3, TestItems.object3));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		public function test_addBefore_wrongItem() : void {
			_orderedSet.add(TestItems.object1);
			_orderedSet.add(TestItems.object2);
			_orderedSet.add(TestItems.object3);

			assertFalse(_orderedSet.addBefore(TestItems.object4, TestItems.object4));
			assertFalse(_orderedSet.addBefore(TestItems.object5, TestItems.object5));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		public function test_addAfter() : void {
			_orderedSet.add(TestItems.object1);
			_orderedSet.add(TestItems.object2);
			_orderedSet.add(TestItems.object3);
			
			assertTrue(_orderedSet.addAfter(TestItems.object1, TestItems.object4));
			
			assertTrue(validateTestItems([1, 4, 2, 3]));
			assertTrue(validateTestItems([1, 4, 2, 3]));
			assertEquals(4, _orderedSet.size);

			assertTrue(_orderedSet.addAfter(TestItems.object3, TestItems.object5));

			assertTrue(validateTestItems([1, 4, 2, 3, 5]));
			assertTrue(validateTestItems([1, 4, 2, 3, 5]));
			assertEquals(5, _orderedSet.size);
		}

		public function test_addAfter_existingItem() : void {
			_orderedSet.add(TestItems.object1);
			_orderedSet.add(TestItems.object2);
			_orderedSet.add(TestItems.object3);

			assertFalse(_orderedSet.addAfter(TestItems.object1, TestItems.object3));
			assertFalse(_orderedSet.addAfter(TestItems.object1, TestItems.object3));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		public function test_addAfter_wrongItem() : void {
			_orderedSet.add(TestItems.object1);
			_orderedSet.add(TestItems.object2);
			_orderedSet.add(TestItems.object3);

			assertFalse(_orderedSet.addAfter(TestItems.object4, TestItems.object4));
			assertFalse(_orderedSet.addAfter(TestItems.object5, TestItems.object5));
			assertTrue(validateTestItems([1, 2, 3]));
		}

		/*
		 * Test replace
		 */

		public function test_replace() : void {
			assertTrue(_orderedSet.add(TestItems.object1));
			assertTrue(_orderedSet.add(TestItems.object2));
			assertTrue(_orderedSet.add(TestItems.object3));
			
			assertTrue(validateTestItems([1, 2, 3]));

			assertTrue(_orderedSet.replace(TestItems.object1, TestItems.object4));
			assertTrue(_orderedSet.replace(TestItems.object2, TestItems.object5));
			
			assertTrue(validateTestItems([4, 5, 3]));
			assertEquals(3, _orderedSet.size);
		}

		public function test_replace_mixedItems() : void {
			assertTrue(_orderedSet.add(null));
			assertTrue(_orderedSet.add(-1));
			assertTrue(_orderedSet.add(10));
			assertTrue(_orderedSet.add("-1"));
			assertTrue(_orderedSet.add("1"));
			assertTrue(_orderedSet.add("true"));
			assertTrue(_orderedSet.add(true));
			assertTrue(_orderedSet.add(TestItems.object8));
			
			assertTrue(_orderedSet.replace(null, 1));
			assertTrue(_orderedSet.replace(-1, 2));
			assertTrue(_orderedSet.replace(10, 3));
			assertTrue(_orderedSet.replace("-1", 4));
			assertTrue(_orderedSet.replace("1", 5));
			assertTrue(_orderedSet.replace("true", 6));
			assertTrue(_orderedSet.replace(true, 7));
			assertTrue(_orderedSet.replace(TestItems.object8, 8));

			assertTrue(validateItems([1, 2, 3, 4, 5, 6, 7, 8]));
			assertEquals(8, _orderedSet.size);
		}

		public function test_replace_sameItem() : void {
			assertTrue(_orderedSet.add(TestItems.object1));
			assertTrue(_orderedSet.add(TestItems.object2));
			assertTrue(_orderedSet.add(TestItems.object3));
			
			assertFalse(_orderedSet.replace(TestItems.object1, TestItems.object1));
			assertFalse(_orderedSet.replace(TestItems.object2, TestItems.object2));

			assertTrue(validateTestItems([1, 2, 3]));
			assertEquals(3, _orderedSet.size);
		}

		public function test_replace_itemTwice() : void {
			assertTrue(_orderedSet.add(TestItems.object1));
			assertTrue(_orderedSet.add(TestItems.object2));
			assertTrue(_orderedSet.add(TestItems.object3));
			
			assertFalse(_orderedSet.replace(TestItems.object1, TestItems.object3));
			assertFalse(_orderedSet.replace(TestItems.object2, TestItems.object3));

			assertTrue(validateTestItems([1, 2, 3]));
			assertEquals(3, _orderedSet.size);
		}

		public function test_replace_itemTwice_mixedItems() : void {
			assertTrue(_orderedSet.add(null));
			assertTrue(_orderedSet.add(-1));
			assertTrue(_orderedSet.add(1));
			assertTrue(_orderedSet.add("-1"));
			assertTrue(_orderedSet.add("1"));
			assertTrue(_orderedSet.add("true"));
			assertTrue(_orderedSet.add(true));
			assertTrue(_orderedSet.add(TestItems.object8));
			
			assertFalse(_orderedSet.replace(null, -1));
			assertFalse(_orderedSet.replace(-1, 1));
			assertFalse(_orderedSet.replace(1, "-1"));
			assertFalse(_orderedSet.replace("-1", "1"));
			assertFalse(_orderedSet.replace("1", "true"));
			assertFalse(_orderedSet.replace("true", true));
			assertFalse(_orderedSet.replace(true, TestItems.object8));
			assertFalse(_orderedSet.replace(TestItems.object8, null));

			assertTrue(validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertEquals(8, _orderedSet.size);
		}

		public function test_replace_wrongItem() : void {
			assertTrue(_orderedSet.add(TestItems.object1));
			assertTrue(_orderedSet.add(TestItems.object2));
			assertTrue(_orderedSet.add(TestItems.object3));
			
			assertFalse(_orderedSet.replace(TestItems.object4, TestItems.object4));
			assertFalse(_orderedSet.replace(null, TestItems.object5));

			assertTrue(validateTestItems([1, 2, 3]));
			assertEquals(3, _orderedSet.size);
		}

	}
}
