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
	import org.as3commons.collections.framework.IOrder;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.AbstractCollectionUnitTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 18.03.2010
	 */
	public class IOrderTests extends AbstractCollectionUnitTestCase {

		public function IOrderTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		private function get _order() : ITestOrder {
			return _test.collection as ITestOrder;
		}

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_order is IOrder);
		}

		/*
		 * Test get first
		 */

		public function test_first_withEmptyCollection() : void {
			assertTrue(_order.first === undefined);
		}

		public function test_first() : void {
			_test.fillCollection(TestItems.itemArray(4));

			assertStrictlyEquals(TestItems.object1, _order.first);
		}

		public function test_first2() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([3, 4, 5]));

			assertStrictlyEquals(TestItems.object3, _order.first);
			
			_test.fillCollection(TestItems.itemArrayByIndices([2, 3, 4, 5]));
			assertStrictlyEquals(TestItems.object2, _order.first);

			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 5]));
			assertStrictlyEquals(TestItems.object1, _order.first);
		}

		/*
		 * Test get last
		 */

		public function test_last_withEmptyCollection() : void {
			assertTrue(_order.last === undefined);
		}

		public function test_last() : void {
			_test.fillCollection(TestItems.itemArray(4));

			assertStrictlyEquals(TestItems.object4, _order.last);
		}

		public function test_last2() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3]));
			assertStrictlyEquals(TestItems.object3, _order.last);
			
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4]));
			assertStrictlyEquals(TestItems.object4, _order.last);

			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 5]));
			assertStrictlyEquals(TestItems.object5, _order.last);
		}

		/*
		 * Test get first and last
		 */

		public function test_firstAndLast() : void {
			assertTrue(_order.first === undefined);
			assertTrue(_order.last === undefined);

			_test.fillCollection([TestItems.object1]);
			assertStrictlyEquals(TestItems.object1, _order.first);
			assertStrictlyEquals(TestItems.object1, _order.last);

			_test.fillCollection([TestItems.object1, TestItems.object2]);
			assertStrictlyEquals(TestItems.object1, _order.first);
			assertStrictlyEquals(TestItems.object2, _order.last);
		}

		/*
		 * Test remove first
		 */

		public function test_removeFirst_withEmptyCollection() : void {
			assertTrue(_order.removeFirst() === undefined);
		}

		public function test_removeFirst() : void {
			_test.fillCollection(TestItems.itemArray(3));

			assertEquals(3, _order.size);
			assertStrictlyEquals(TestItems.object1, _order.first);
			assertStrictlyEquals(TestItems.object1, _order.removeFirst());
			assertFalse(_test.collection.has(TestItems.object1));

			assertEquals(2, _order.size);
			assertStrictlyEquals(TestItems.object2, _order.first);
			assertStrictlyEquals(TestItems.object2, _order.removeFirst());
			assertFalse(_test.collection.has(TestItems.object2));

			assertEquals(1, _order.size);
			assertStrictlyEquals(TestItems.object3, _order.first);
			assertStrictlyEquals(TestItems.object3, _order.removeFirst());
			assertFalse(_test.collection.has(TestItems.object3));

			assertEquals(0, _order.size);
			assertTrue(_order.first === undefined);
			assertTrue(_order.removeFirst() === undefined);
		}

		/*
		 * Test remove last
		 */

		public function test_removeLast_withEmptyCollection() : void {
			assertTrue(_order.removeLast() === undefined);
		}

		public function test_removeLast() : void {
			_test.fillCollection(TestItems.itemArray(3));

			assertEquals(3, _order.size);
			assertStrictlyEquals(TestItems.object3, _order.last);
			assertStrictlyEquals(TestItems.object3, _order.removeLast());
			assertFalse(_test.collection.has(TestItems.object3));

			assertEquals(2, _order.size);
			assertStrictlyEquals(TestItems.object2, _order.last);
			assertStrictlyEquals(TestItems.object2, _order.removeLast());
			assertFalse(_test.collection.has(TestItems.object2));

			assertEquals(1, _order.size);
			assertStrictlyEquals(TestItems.object1, _order.last);
			assertStrictlyEquals(TestItems.object1, _order.removeLast());
			assertFalse(_test.collection.has(TestItems.object1));

			assertEquals(0, _order.size);
			assertTrue(_order.last === undefined);
			assertTrue(_order.removeLast() === undefined);
		}

		/*
		 * Test remove first and last
		 */

		public function test_removeFirstAndLast() : void {
			_test.fillCollection(TestItems.itemArray(3));

			assertEquals(3, _order.size);
			assertStrictlyEquals(TestItems.object1, _order.first);
			assertStrictlyEquals(TestItems.object3, _order.last);

			assertStrictlyEquals(TestItems.object1, _order.removeFirst());
			assertStrictlyEquals(TestItems.object3, _order.removeLast());
			assertFalse(_test.collection.has(TestItems.object1));
			assertFalse(_test.collection.has(TestItems.object3));

			assertEquals(1, _order.size);
			assertStrictlyEquals(TestItems.object2, _order.first);
			assertStrictlyEquals(TestItems.object2, _order.last);

			assertStrictlyEquals(TestItems.object2, _order.removeFirst());
			assertFalse(_test.collection.has(TestItems.object2));

			assertEquals(0, _order.size);
			assertTrue(_order.first === undefined);
			assertTrue(_order.last === undefined);
			
			_test.fillCollection([TestItems.object2]);
			
			assertEquals(1, _order.size);
			assertStrictlyEquals(TestItems.object2, _order.first);
			assertStrictlyEquals(TestItems.object2, _order.last);

			assertStrictlyEquals(TestItems.object2, _order.removeLast());

			assertEquals(0, _order.size);
			assertTrue(_order.first === undefined);
			assertTrue(_order.last === undefined);
		}

	}
}
