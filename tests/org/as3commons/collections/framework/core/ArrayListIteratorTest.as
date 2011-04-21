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
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IOrderedList;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import org.as3commons.collections.mocks.ArrayListMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.iterators.IIteratorInsertionOrderTests;
	import org.as3commons.collections.units.iterators.IListIteratorTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class ArrayListIteratorTest extends AbstractIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new ArrayListMock();
		}

		override public function fillCollection(items : Array) : void {
			IOrderedList(collection).array = items;
		}

		override public function getIterator(index : uint = 0) : IIterator {
			return IOrderedList(collection).iterator(index);
		}

		override public function toArray() : Array {
			return IOrderedList(collection).toArray();
		}

		/*
		 * Units
		 */

		/*
		 * ListIterator tests
		 */

		public function test_listIterator() : void {
			new IListIteratorTests(this).runAllTests();
		}

		/*
		 * IIteratorInsertionOrderTests tests
		 */

		public function test_iteratorInsertionOrder() : void {
			new IIteratorInsertionOrderTests(this).runAllTests();
		}

		/*
		 * IOrderedListIterator
		 */

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(getIterator() is IOrderedListIterator);
		}

		/*
		 * Index
		 */

		public function test_index_notResetAfterReplace() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedListIterator = getIterator() as IOrderedListIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertEquals(1, iterator.index);

			iterator.replace(TestItems.object4);
			assertEquals(1, iterator.index);

			assertTrue(validateTestItems([1, 4, 3], toArray()));
		}

		public function test_index_resetAfterAdd() : void {
			fillCollection(TestItems.itemArray(3));

			var iterator : IOrderedListIterator = getIterator() as IOrderedListIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertEquals(1, iterator.index);
			
			iterator.addBefore(TestItems.object5);
			assertEquals(-1, iterator.index);

			assertStrictlyEquals(TestItems.object5, iterator.previous());
			assertEquals(2, iterator.index);

			iterator.addAfter(TestItems.object6);
			assertEquals(-1, iterator.index);

			assertTrue(validateTestItems([1, 2, 6, 5, 3], toArray()));
		}

	}
}
