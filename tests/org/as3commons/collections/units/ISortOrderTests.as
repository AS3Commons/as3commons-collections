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
package org.as3commons.collections.units {
	import org.as3commons.collections.framework.ISortOrder;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class ISortOrderTests extends IOrderTests {
		
		public function ISortOrderTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		private function get _sortOrder() : ITestSortOrder {
			return _test.collection as ITestSortOrder;
		}

		/*
		 * Initial state
		 */

		public function test_init_sortOrder() : void {
			assertTrue(_sortOrder is ISortOrder);
		}
		
		/*
		 * Test add
		 */

		public function test_add() : void {
			_sortOrder.addMock(TestItems.object1);
			assertTrue(_test.validateTestItemsStrictly([1]));

			_sortOrder.addMock(TestItems.object6);
			assertTrue(_test.validateTestItemsStrictly([1, 6]));

			_sortOrder.addMock(TestItems.object3);
			assertTrue(_test.validateTestItemsStrictly([1, 3, 6]));

			_sortOrder.addMock(TestItems.object2);
			assertTrue(_test.validateTestItemsStrictly([1, 2, 3, 6]));

			_sortOrder.addMock(TestItems.object4);
			assertTrue(_test.validateTestItemsStrictly([1, 2, 3, 4, 6]));

			_sortOrder.addMock(TestItems.object5);
			assertTrue(_test.validateTestItemsStrictly([1, 2, 3, 4, 5, 6]));
		}

		/*
		 * Test hasEqual
		 */

		public function test_hasEqual() : void {
			
			TestItems.object2["index"] = 1;

			_sortOrder.addMock(TestItems.object1);
			
			assertTrue(_sortOrder.has(TestItems.object1));
			assertFalse(_sortOrder.has(TestItems.object2));
			assertFalse(_sortOrder.has(TestItems.object3));
			
			assertTrue(_sortOrder.hasEqual(TestItems.object1));
			assertTrue(_sortOrder.hasEqual(TestItems.object2));
			assertFalse(_sortOrder.hasEqual(TestItems.object3));
			
		}

		/*
		 * Test lesser
		 */

		public function test_lesser(): void {
			
			_test.fillCollection([4, 2, 7, 5, 1]); // 1, 2, 4, 5, 7
			
			assertTrue(undefined === _sortOrder.lesser(0));
			assertTrue(undefined === _sortOrder.lesser(1));
			assertEquals(2, _sortOrder.lesser(3));
			assertEquals(2, _sortOrder.lesser(4));
			assertEquals(4, _sortOrder.lesser(5));
			assertEquals(5, _sortOrder.lesser(6));
			assertEquals(5, _sortOrder.lesser(7));
			assertEquals(7, _sortOrder.lesser(8));
			assertEquals(7, _sortOrder.lesser(9));
		}

		public function test_lesser2(): void {
			
			_test.fillCollection([1, 5, 8, 10, 14]);
			
			assertTrue(undefined === _sortOrder.lesser(0));
			assertTrue(undefined === _sortOrder.lesser(1));
			assertEquals(1, _sortOrder.lesser(2));
			assertEquals(8, _sortOrder.lesser(9));
			assertEquals(8, _sortOrder.lesser(10));
			assertEquals(10, _sortOrder.lesser(11));
			assertEquals(10, _sortOrder.lesser(13));
			assertEquals(10, _sortOrder.lesser(14));
			assertEquals(14, _sortOrder.lesser(15));
		}

		/*
		 * Test higher
		 */

		public function test_higher(): void {
			
			_test.fillCollection([4, 2, 7, 5, 1]); // 1, 2, 4, 5, 7
			
			assertEquals(1, _sortOrder.higher(0));
			assertEquals(2, _sortOrder.higher(1));
			assertEquals(4, _sortOrder.higher(2));
			assertEquals(4, _sortOrder.higher(3));
			assertEquals(5, _sortOrder.higher(4));
			assertEquals(7, _sortOrder.higher(5));
			assertEquals(7, _sortOrder.higher(6));
			assertTrue(undefined === _sortOrder.higher(7));
			assertTrue(undefined === _sortOrder.higher(8));
		}

		public function test_higher2(): void {
			
			_test.fillCollection([1, 5, 8, 10, 14]);
			
			assertEquals(1, _sortOrder.higher(0));
			assertEquals(5, _sortOrder.higher(1));
			assertEquals(5, _sortOrder.higher(2));
			assertEquals(5, _sortOrder.higher(4));
			assertEquals(8, _sortOrder.higher(5));
			assertEquals(8, _sortOrder.higher(6));
			assertEquals(14, _sortOrder.higher(13));
			assertTrue(undefined === _sortOrder.higher(14));
			assertTrue(undefined === _sortOrder.higher(15));
		}

		/*
		 * Test equal items
		 */

		public function test_equalItems(): void {
			
			_test.fillCollection([1, 2, 3]);
			
			assertTrue(_test.validateItemsStrictly([1], _sortOrder.equalItems(1)));
			assertTrue(_test.validateItemsStrictly([2], _sortOrder.equalItems(2)));
			assertTrue(_test.validateItemsStrictly([3], _sortOrder.equalItems(3)));
		}

		/*
		 * Test remove
		 */

		public function test_remove_notContainedEqualItem() : void {
			
			TestItems.object2["index"] = 1;

			_sortOrder.addMock(TestItems.object1);
			
			assertTrue(_sortOrder.has(TestItems.object1));
			assertFalse(_sortOrder.has(TestItems.object2));
			
			assertTrue(_sortOrder.hasEqual(TestItems.object1));
			assertTrue(_sortOrder.hasEqual(TestItems.object2));

			assertFalse(_sortOrder.remove(TestItems.object2));
			assertTrue(_sortOrder.remove(TestItems.object1));
			
			assertFalse(_sortOrder.has(TestItems.object1));
			assertFalse(_sortOrder.has(TestItems.object2));
			
			assertFalse(_sortOrder.hasEqual(TestItems.object1));
			assertFalse(_sortOrder.hasEqual(TestItems.object2));

		}

	}
}
