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
	import org.as3commons.collections.framework.ISortedList;
	import org.as3commons.collections.mocks.SortedListMock;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestComparator;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.IListTests;
	import org.as3commons.collections.units.ISortOrderDuplicatesTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class SortedListTest extends AbstractCollectionTestCase {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new SortedListMock(new TestComparator());
		}

		override public function fillCollection(items : Array) : void {
			collection.clear();
			
			for each (var item : * in items) {
				ISortedList(collection).add(item);
			}
		}

		private function get _sortedList() : ISortedList {
			return collection as ISortedList;
		}

		/*
		 * Units
		 */

		/*
		 * List tests
		 */

		public function test_list() : void {
			new IListTests(this).runAllTests();
		}

		/*
		 * Order tests
		 */

		public function test_order() : void {
			new ISortOrderDuplicatesTests(this).runAllTests();
		}

		/*
		 * ISortedList
		 */

		/*
		 * Test add
		 */

		public function test_add(): void {
			
			assertEquals(0, _sortedList.add(TestItems.object5));
			assertEquals(1, _sortedList.add(TestItems.object5));

			assertEquals(0, _sortedList.add(TestItems.object4));
			assertEquals(1, _sortedList.add(TestItems.object4));
			
			assertTrue(validateTestItemsStrictly([4, 4, 5, 5]));
			
			assertEquals(4, _sortedList.add(TestItems.object6));
			assertEquals(5, _sortedList.add(TestItems.object6));

			assertEquals(0, _sortedList.add(TestItems.object2));
			assertEquals(1, _sortedList.add(TestItems.object2));

			assertTrue(validateTestItemsStrictly([2, 2, 4, 4, 5, 5, 6, 6]));

		}

		/*
		 * Test lesser index
		 */

		public function test_lesserIndex(): void {
			
			fillCollection([4, 2, 6, 4, 5, 2]); // 2, 2, 4, 4, 5, 6
			
			assertEquals(-1, _sortedList.lesserIndex(0));
			assertEquals(-1, _sortedList.lesserIndex(1));
			assertEquals(-1, _sortedList.lesserIndex(2));
			assertEquals(1, _sortedList.lesserIndex(3));
			assertEquals(1, _sortedList.lesserIndex(4));
			assertEquals(3, _sortedList.lesserIndex(5));
			assertEquals(4, _sortedList.lesserIndex(6));
			assertEquals(5, _sortedList.lesserIndex(7));
			assertEquals(5, _sortedList.lesserIndex(8));
		}

		/*
		 * Test higher index
		 */

		public function test_higherIndex(): void {
			
			fillCollection([4, 2, 6, 4, 5, 2]); // 2, 2, 4, 4, 5, 6
			
			assertEquals(0, _sortedList.higherIndex(0));
			assertEquals(0, _sortedList.higherIndex(1));
			assertEquals(2, _sortedList.higherIndex(2));
			assertEquals(2, _sortedList.higherIndex(3));
			assertEquals(4, _sortedList.higherIndex(4));
			assertEquals(5, _sortedList.higherIndex(5));
			assertEquals(-1, _sortedList.higherIndex(6));
			assertEquals(-1, _sortedList.higherIndex(7));
			assertEquals(-1, _sortedList.higherIndex(8));
		}

		/*
		 * Test equal indices
		 */

		public function test_equalIndices(): void {
			
			fillCollection([4, 2, 6, 4, 5, 4, 2]); // 2, 2, 4, 4, 4, 5, 6
			
			assertTrue(validateItemsStrictly([], _sortedList.equalIndices(0)));
			assertTrue(validateItemsStrictly([], _sortedList.equalIndices(1)));
			assertTrue(validateItemsStrictly([0, 1], _sortedList.equalIndices(2)));
			assertTrue(validateItemsStrictly([], _sortedList.equalIndices(3)));
			assertTrue(validateItemsStrictly([2, 3, 4], _sortedList.equalIndices(4)));
			assertTrue(validateItemsStrictly([5], _sortedList.equalIndices(5)));
			assertTrue(validateItemsStrictly([6], _sortedList.equalIndices(6)));
			assertTrue(validateItemsStrictly([], _sortedList.equalIndices(7)));
			assertTrue(validateItemsStrictly([], _sortedList.equalIndices(8)));
		}

	}
}
