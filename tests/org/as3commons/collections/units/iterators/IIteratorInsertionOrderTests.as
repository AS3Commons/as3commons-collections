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
package org.as3commons.collections.units.iterators {
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.AbstractIteratorUnitTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 22.03.2010
	 */
	public class IIteratorInsertionOrderTests extends AbstractIteratorUnitTestCase {

		public function IIteratorInsertionOrderTests(test : AbstractIteratorTestCase) {
			super(test);
		}

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_test.getIterator() is ITestIteratorInsertionOrder);
		}

		/*
		 * Test current
		 */

		public function test_current_resetAfterAdd() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object4));
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object4, iterator.previous());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object5));
			assertTrue(undefined === iterator.current);

			assertTrue(_test.validateTestItems([1, 2, 5, 4, 3]));
		}

		/*
		 * Test add before
		 */

		public function test_addBefore() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object4));
			assertTrue(_test.validateTestItems([4, 1, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object1, iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object5));
			assertTrue(_test.validateTestItems([4, 1, 5, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertStrictlyEquals(TestItems.object3, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertStrictlyEquals(TestItems.object3, iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object6));
			assertTrue(_test.validateTestItems([4, 1, 5, 2, 3, 6]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object6, iterator.previous());
			assertStrictlyEquals(TestItems.object3, iterator.previous());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object3, iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object7));
			assertTrue(_test.validateTestItems([4, 1, 5, 2, 7, 3, 6]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			iterator.start();
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object8));
			assertTrue(_test.validateTestItems([8, 4, 1, 5, 2, 7, 3, 6]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			iterator.end();
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object9));
			assertTrue(_test.validateTestItems([8, 4, 1, 5, 2, 7, 3, 6, 9]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		public function test_addBefore_withEmptyCollection() : void {
			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertTrue(_test.validateTestItems([]));
			assertFalse(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object1));
			assertTrue(_test.validateTestItems([1]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(undefined === iterator.next());
			assertStrictlyEquals(TestItems.object1, iterator.previous());
		}

		public function test_addBefore_atStart() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object4));
			assertTrue(_test.validateTestItems([4, 1, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());

			assertStrictlyEquals(TestItems.object4, iterator.previous());
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object5));
			assertTrue(_test.validateTestItems([5, 4, 1, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		public function test_addBefore_atEnd() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;
			iterator.end();

			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addBeforeMock(TestItems.object4));
			assertTrue(_test.validateTestItems([1, 2, 3, 4]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());

			assertTrue(iterator.addBeforeMock(TestItems.object5));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		/*
		 * Test add after
		 */

		public function test_addAfter() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object4));
			assertTrue(_test.validateTestItems([4, 1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object4, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object5));
			assertTrue(_test.validateTestItems([4, 5, 1, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object5, iterator.next());
			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object1, iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object6));
			assertTrue(_test.validateTestItems([4, 5, 1, 6, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object6, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertStrictlyEquals(TestItems.object3, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertStrictlyEquals(TestItems.object3, iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object7));
			assertTrue(_test.validateTestItems([4, 5, 1, 6, 2, 3, 7]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(TestItems.object3, iterator.previous());
			assertStrictlyEquals(TestItems.object2, iterator.previous());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object8));
			assertTrue(_test.validateTestItems([4, 5, 1, 6, 8, 2, 3, 7]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			iterator.start();
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object9));
			assertTrue(_test.validateTestItems([9, 4, 5, 1, 6, 8, 2, 3, 7]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			iterator.end();
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object10));
			assertTrue(_test.validateTestItems([9, 4, 5, 1, 6, 8, 2, 3, 7, 10]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		public function test_addAfter_withEmptyCollection() : void {
			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertTrue(_test.validateTestItems([]));
			assertFalse(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object1));
			
			assertTrue(_test.validateTestItems([1]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(undefined === iterator.previous());
			assertStrictlyEquals(TestItems.object1, iterator.next());
		}

		public function test_addAfter_atStart() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object4));
			assertTrue(_test.validateTestItems([4, 1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());

			assertTrue(iterator.addAfterMock(TestItems.object5));
			assertTrue(_test.validateTestItems([5, 4, 1, 2, 3]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		public function test_addAfter_atEnd() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;
			iterator.end();

			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object4));
			assertTrue(_test.validateTestItems([1, 2, 3, 4]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());

			assertStrictlyEquals(TestItems.object4, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			assertTrue(iterator.addAfterMock(TestItems.object5));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		/*
		 * Test iterator replace
		 */
		
		public function test_replace() : void {
			_test.fillCollection(TestItems.itemArray(5));

			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;
			
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5]));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
			
			assertFalse(iterator.replace(TestItems.object6));

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object1, iterator.current);

			assertTrue(iterator.replace(TestItems.object6));
			assertTrue(_test.validateTestItems([6, 2, 3, 4, 5]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.current);

			assertTrue(iterator.replace(TestItems.object7));
			assertTrue(_test.validateTestItems([7, 2, 3, 4, 5]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object7, iterator.current);

			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertStrictlyEquals(TestItems.object3, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object3, iterator.current);

			assertTrue(iterator.replace(TestItems.object8));
			assertTrue(_test.validateTestItems([7, 2, 8, 4, 5]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object8, iterator.current);
			
			iterator.end();
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);
			
			assertFalse(iterator.replace(TestItems.object9));

			assertStrictlyEquals(TestItems.object5, iterator.previous());
			assertStrictlyEquals(TestItems.object5, iterator.current);

			assertTrue(iterator.replace(TestItems.object9));
			assertTrue(_test.validateTestItems([7, 2, 8, 4, 9]));
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object9, iterator.current);

			assertStrictlyEquals(TestItems.object9, iterator.next());
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertStrictlyEquals(TestItems.object9, iterator.current);

			assertTrue(iterator.replace(TestItems.object10));
			assertTrue(_test.validateTestItems([7, 2, 8, 4, 10]));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertStrictlyEquals(TestItems.object10, iterator.current);
		}

		public function test_replace_withSameItem() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ITestIteratorInsertionOrder = _test.getIterator() as ITestIteratorInsertionOrder;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next()); // 1 2 | 3
			
			assertTrue(iterator.replace(TestItems.object4));
			assertFalse(iterator.replace(TestItems.object4));
			assertTrue(iterator.replace(TestItems.object5));
		}

	}
}
