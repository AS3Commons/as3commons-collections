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
	import org.as3commons.collections.framework.IDuplicates;
	import org.as3commons.collections.framework.ISortOrder;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 22.03.2010
	 */
	public class ISortOrderDuplicatesTests extends ISortOrderDuplicateEqualsTests {

		public function ISortOrderDuplicatesTests(test : AbstractCollectionTestCase) {
			super(test);
		}

		private function get _duplicates() : ITestDuplicates {
			return _test.collection as ITestDuplicates;
		}
		
		private function get _sortOrder() : ITestSortOrder {
			return _test.collection as ITestSortOrder;
		}
		
		/*
		 * Initial state
		 */

		public function test_init_duplicates() : void {
			assertTrue(_test.collection is ISortOrder);
			assertTrue(_test.collection is IDuplicates);
		}
	
		/*
		 * Test add
		 */

		public function test_add_duplicates() : void {
			_sortOrder.addMock(TestItems.object1);
			assertTrue(_test.validateTestItemsStrictly([1]));

			_sortOrder.addMock(TestItems.object1);
			assertTrue(_test.validateTestItemsStrictly([1, 1]));

			_sortOrder.addMock(TestItems.object6);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 6]));

			_sortOrder.addMock(TestItems.object3);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 3, 6]));

			_sortOrder.addMock(TestItems.object2);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 2, 3, 6]));

			_sortOrder.addMock(TestItems.object1);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 1, 2, 3, 6]));

			_sortOrder.addMock(TestItems.object3);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 1, 2, 3, 3, 6]));

			_sortOrder.addMock(TestItems.object6);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 1, 2, 3, 3, 6, 6]));

			_sortOrder.addMock(TestItems.object3);
			assertTrue(_test.validateTestItemsStrictly([1, 1, 1, 2, 3, 3, 3, 6, 6]));
		}

		public function test_add_isStable_duplicates() : void {

			// functions are sorted only by their type
			
			var func1 : Function = function() : void {};
			var func2 : Function = function() : void {};
			var func3 : Function = function() : void {};

			_sortOrder.addMock(func1);
			assertTrue(_test.validateItemsStrictly([func1]));

			_sortOrder.addMock(1);
			assertTrue(_test.validateItemsStrictly([1, func1]));

			_sortOrder.addMock(func3);
			assertTrue(_test.validateItemsStrictly([1, func1, func3]));

			_sortOrder.addMock(4);
			assertTrue(_test.validateItemsStrictly([1, 4, func1, func3]));

			_sortOrder.addMock(TestItems.object1);
			assertTrue(_test.validateItemsStrictly([1, 4, func1, func3, TestItems.object1]));

			_sortOrder.addMock(func1);
			assertTrue(_test.validateItemsStrictly([1, 4, func1, func3, func1, TestItems.object1]));

			_sortOrder.addMock(func2);
			assertTrue(_test.validateItemsStrictly([1, 4, func1, func3, func1, func2, TestItems.object1]));

			_sortOrder.addMock("one");
			assertTrue(_test.validateItemsStrictly([1, 4, "one", func1, func3, func1, func2, TestItems.object1]));

			_sortOrder.addMock("one");
			assertTrue(_test.validateItemsStrictly([1, 4, "one", "one", func1, func3, func1, func2, TestItems.object1]));

			_sortOrder.addMock(func1);
			assertTrue(_test.validateItemsStrictly([1, 4, "one", "one", func1, func3, func1, func2, func1, TestItems.object1]));

			_sortOrder.addMock(func3);
			assertTrue(_test.validateItemsStrictly([1, 4, "one", "one", func1, func3, func1, func2, func1, func3, TestItems.object1]));

		}

		/*
		 * Test hasEqual
		 */

		public function test_hasEqual_duplicates() : void {
			
			TestItems.object2["index"] = 1;

			_sortOrder.addMock(TestItems.object1);
			_sortOrder.addMock(TestItems.object1);
			
			assertTrue(_duplicates.has(TestItems.object1));
			assertFalse(_duplicates.has(TestItems.object2));
			assertFalse(_duplicates.has(TestItems.object3));
			
			assertTrue(_sortOrder.hasEqual(TestItems.object1));
			assertTrue(_sortOrder.hasEqual(TestItems.object2));
			assertFalse(_sortOrder.hasEqual(TestItems.object3));
			
			_duplicates.remove(TestItems.object1);
			
			assertTrue(_duplicates.has(TestItems.object1));
			assertFalse(_duplicates.has(TestItems.object2));
			assertFalse(_duplicates.has(TestItems.object3));
			
			assertTrue(_sortOrder.hasEqual(TestItems.object1));
			assertTrue(_sortOrder.hasEqual(TestItems.object2));
			assertFalse(_sortOrder.hasEqual(TestItems.object3));

			_duplicates.remove(TestItems.object1);

			assertFalse(_duplicates.has(TestItems.object1));
			assertFalse(_duplicates.has(TestItems.object2));
			assertFalse(_duplicates.has(TestItems.object3));
			
			assertFalse(_sortOrder.hasEqual(TestItems.object1));
			assertFalse(_sortOrder.hasEqual(TestItems.object2));
			assertFalse(_sortOrder.hasEqual(TestItems.object3));

		}

		/*
		 * Test equal items
		 */

		public function test_equalItems_duplicates(): void {
			
			TestItems.object2["index"] = 1;
			TestItems.object3["index"] = 2;
			TestItems.object4["index"] = 2;

			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 2, 1, 3, 4]));
			
			assertTrue(_test.validateItemsStrictly(TestItems.itemArrayByIndices([1, 2, 2, 1]), _sortOrder.equalItems(TestItems.object1)));
			assertTrue(_test.validateItemsStrictly(TestItems.itemArrayByIndices([3, 4, 3, 4]), _sortOrder.equalItems(TestItems.object3)));
		}

		/*
		 * Test remove
		 */

		public function test_remove() : void {

			// functions are sorted only by their type
			
			var func1 : Function = function() : void {};
			var func2 : Function = function() : void {};
			var func3 : Function = function() : void {};

			_test.fillCollection([1, func3, func2, func2, "one", func1, 2, TestItems.object1, func2, 3, func3, "one"]);

			assertTrue(_test.validateItemsStrictly([1, 2, 3, "one", "one", func3, func2, func2, func1, func2, func3, TestItems.object1]));

			assertTrue(_duplicates.remove("one"));
			assertTrue(_test.validateItemsStrictly([1, 2, 3, "one", func3, func2, func2, func1, func2, func3, TestItems.object1]));

			assertTrue(_duplicates.remove(1));
			assertTrue(_test.validateItemsStrictly([2, 3, "one", func3, func2, func2, func1, func2, func3, TestItems.object1]));

			assertTrue(_duplicates.remove(func1));
			assertTrue(_test.validateItemsStrictly([2, 3, "one", func3, func2, func2, func2, func3, TestItems.object1]));

			assertTrue(_duplicates.remove(func2));
			assertTrue(_test.validateItemsStrictly([2, 3, "one", func3, func2, func2, func3, TestItems.object1]));

			assertTrue(_duplicates.remove(func3));
			assertTrue(_test.validateItemsStrictly([2, 3, "one", func2, func2, func3, TestItems.object1]));

		}

		/*
		 * Test remove all
		 */

		public function test_removeAll() : void {

			// functions are sorted only by their type
			
			var func1 : Function = function() : void {};
			var func2 : Function = function() : void {};
			var func3 : Function = function() : void {};

			_test.fillCollection([1, func3, func2, func2, "one", func1, 2, TestItems.object1, func2, 3, func3, "one"]);

			assertTrue(_test.validateItemsStrictly([1, 2, 3, "one", "one", func3, func2, func2, func1, func2, func3, TestItems.object1]));

			assertEquals(2, _duplicates.removeAll("one"));
			assertTrue(_test.validateItemsStrictly([1, 2, 3, func3, func2, func2, func1, func2, func3, TestItems.object1]));

			assertEquals(1, _duplicates.removeAll(1));
			assertTrue(_test.validateItemsStrictly([2, 3, func3, func2, func2, func1, func2, func3, TestItems.object1]));

			assertEquals(1, _duplicates.removeAll(func1));
			assertTrue(_test.validateItemsStrictly([2, 3, func3, func2, func2, func2, func3, TestItems.object1]));

			assertEquals(3, _duplicates.removeAll(func2));
			assertTrue(_test.validateItemsStrictly([2, 3, func3, func3, TestItems.object1]));

			assertEquals(2, _duplicates.removeAll(func3));
			assertTrue(_test.validateItemsStrictly([2, 3, TestItems.object1]));

		}

	}
}
