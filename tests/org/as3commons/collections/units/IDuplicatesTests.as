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
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.AbstractCollectionUnitTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 18.03.2010
	 */
	public class IDuplicatesTests extends AbstractCollectionUnitTestCase {

		public function IDuplicatesTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		private function get _duplicates() : ITestDuplicates {
			return _test.collection as ITestDuplicates;
		}
		
		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_test.collection is IDuplicates);
		}
	
		/*
		 * Test add
		 */

		public function test_add_duplicates_returnValue() : void {
			_duplicates.addMock(TestItems.object2);
			_duplicates.addMock(TestItems.object4);
			_duplicates.addMock(TestItems.object2);
			_duplicates.addMock(TestItems.object1);
			_duplicates.addMock(TestItems.object3);
			_duplicates.addMock(TestItems.object1);
			_duplicates.addMock(TestItems.object1);

			assertEquals(7, _duplicates.size);
			assertEquals(7, _duplicates.toArray().length);

			assertTrue(_test.validateTestItems([2, 4, 2, 1, 3, 1, 1]));
		}

		/*
		 * Test count
		 */

		public function test_count_withEmptyCollection() : void {
			assertEquals(0, _duplicates.count(TestItems.object5));
		}

		public function test_count_withWrongItem() : void {
			_test.fillCollection(TestItems.itemArray(4));

			assertEquals(0, _duplicates.count(TestItems.object5));
		}

		public function test_count() : void {
			_test.fillCollection(TestItems.itemArray(4));
			
			assertEquals(1, _duplicates.count(TestItems.object1));
			
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 1]));
			assertEquals(2, _duplicates.count(TestItems.object1));
			assertEquals(5, _duplicates.size);
			
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 1, 1]));
			assertEquals(3, _duplicates.count(TestItems.object1));
			assertEquals(6, _duplicates.size);

			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 1, 1, 2]));
			assertEquals(2, _duplicates.count(TestItems.object2));
			assertEquals(7, _duplicates.size);
		}

		public function test_count_withNull() : void {
			_test.fillCollection([TestItems.object1, null, null, TestItems.object2, null]);
			
			assertEquals(3, _duplicates.count(null));
		}

		/*
		 * Test remove
		 */

		public function test_remove() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 1, 1, 2, 2, 3, 4]));
			assertEquals(7, _test.collection.size);

			assertTrue(_test.collection.remove(TestItems.object1));
			assertEquals(6, _test.collection.size);
			assertTrue(_test.validateTestItems([1, 1, 2, 2, 3, 4]));

			assertTrue(_test.collection.remove(TestItems.object4));
			assertEquals(5, _test.collection.size);
			assertTrue(_test.validateTestItems([1, 1, 2, 2, 3]));

			assertTrue(_test.collection.remove(TestItems.object2));
			assertEquals(4, _test.collection.size);
			assertTrue(_test.validateTestItems([1, 1, 2, 3]));

			assertTrue(_test.collection.remove(TestItems.object1));
			assertEquals(3, _test.collection.size);
			assertTrue(_test.validateTestItems([1, 2, 3]));

			assertTrue(_test.collection.remove(TestItems.object3));
			assertEquals(2, _test.collection.size);
			assertTrue(_test.validateTestItems([1, 2]));
		}

		/*
		 * Test remove all
		 */

		public function test_removeAll_withEmptyCollection() : void {
			assertTrue(_test.validateItems([]));
			assertEquals(0, _duplicates.removeAll(TestItems.object5));
			assertTrue(_test.validateItems([]));
		}

		public function test_removeAll_withWrongItem() : void {
			_test.fillCollection(TestItems.itemArray(4));

			assertEquals(0, _duplicates.removeAll(TestItems.object5));
			assertTrue(_test.validateTestItems([1, 2, 3, 4]));
		}

		public function test_removeAll() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 1, 1, 2]));

			assertEquals(3, _duplicates.count(TestItems.object1));
			assertEquals(2, _duplicates.count(TestItems.object2));
			assertEquals(7, _duplicates.size);
			
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 1, 1, 2]));
			
			assertEquals(3, _duplicates.removeAll(TestItems.object1));
			assertEquals(0, _duplicates.count(TestItems.object1));
			assertEquals(4, _duplicates.size);
			assertTrue(_test.validateTestItems([2, 3, 4, 2]));
			assertFalse(_test.collection.has(TestItems.object1));

			assertEquals(2, _duplicates.removeAll(TestItems.object2));
			assertEquals(0, _duplicates.count(TestItems.object1));
			assertEquals(2, _duplicates.size);
			assertTrue(_test.validateTestItems([3, 4]));
			assertFalse(_test.collection.has(TestItems.object2));
		}

	}
}
