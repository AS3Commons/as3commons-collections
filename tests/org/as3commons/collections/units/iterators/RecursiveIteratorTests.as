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
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.framework.IRecursiveIterator;
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorTestCase;
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorUnitTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class RecursiveIteratorTests extends AbstractSpecialIteratorUnitTestCase {

		public function RecursiveIteratorTests(test : AbstractSpecialIteratorTestCase) {
			super(test);
		}

		/*
		 * Private
		 */

		private var list1 : IList;
		private var list2 : IList;
		private var list3 : IList;
		private var list4 : IList;

		private function fillList() : void {
			list1 = new ArrayList();
			list1.add(TestItems.object1);
			list1.add(TestItems.object2);
			list1.add(TestItems.object3);
	
			list2 = new ArrayList();
			list2.add(TestItems.object4);
			list2.add(TestItems.object5);
			list2.add(TestItems.object6);
	
			_specialIteratorTest.add(list1);
			_specialIteratorTest.add(list2);
		}
	
		private function fillComplexList() : void {
			fillList();
	
			list3 = new ArrayList();
			list3.add(TestItems.object4);
	
			list4 = new ArrayList();
			list4.add(TestItems.object2);
			list4.add(TestItems.object6);
			list4.add(TestItems.object1);
	
			list3.add(list4);
			list3.add(TestItems.object5);
			list3.add(TestItems.object6);
	
			list1.add(list3);
		}
	
		private function fillRecursiveList() : void {
			list1 = new ArrayList();
			_specialIteratorTest.add(list1);
			list1.add(_specialIteratorTest);
		}
	
		private function fillRecursiveListMoreComplex() : void {
			list1 = new ArrayList();
			list1.add(TestItems.object1);
			list1.add(TestItems.object2);
	
			list2 = new ArrayList();
			list2.add(TestItems.object4);
			list2.add(list1);
			list2.add(TestItems.object5);
			list2.add(_specialIteratorTest);
	
			_specialIteratorTest.add(TestItems.object1);
			_specialIteratorTest.add(list1);
			_specialIteratorTest.add(TestItems.object2);
			_specialIteratorTest.add(list2);
		}
	
		/*
		 * Initial state
		 */

		public function test_init(): void {
			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();
			assertTrue(iterator is IRecursiveIterator);
		}
	
		public function test_init_withEmptyCollection(): void {
			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.next());
		}
	
		/**
		 * test iterator
		 */

		public function test_avoidRecursions(): void {
			fillRecursiveList();
			
			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			var result : Array = new Array();
			while (iterator.hasNext()) {
				var next : * = iterator.next();
				result.push(next);
			}
			
			assertEquals(2, result.length);
	
			assertTrue(_test.validateItems([list1, _specialIteratorTest], result));
		}
	
		public function test_avoidRecursionsMoreComplex(): void {
			fillRecursiveListMoreComplex();
			
			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			var result : Array = new Array();
			while (iterator.hasNext()) {
				var next : * = iterator.next();
				result.push(next);
			}
			
			assertEquals(12, result.length);
	
			assertTrue(
				_test.validateItems(
					[TestItems.object1,
					list1,
						TestItems.object1, TestItems.object2,
					TestItems.object2,
					list2,
						TestItems.object4,
						list1,
							TestItems.object1, TestItems.object2,
						TestItems.object5,
						_specialIteratorTest
					],
					result
				)
			);
		}

		public function test_returnsAllItemsAdded(): void {
			fillList();

			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			var result : Array = new Array();
			while (iterator.hasNext()) {
				var next : * = iterator.next();
				result.push(next);
			}

			assertEquals(8, result.length);
	
			assertTrue(
				_test.validateItems(
					[list1,
						TestItems.object1, TestItems.object2, TestItems.object3,
					list2,
						TestItems.object4, TestItems.object5, TestItems.object6],
					result
				)
			);
		}
	
		public function test_null(): void {
			fillList();

			list1.add(null);
			list1.add(null);
			list2.add(null);
			list2.add(null);

			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			var result : Array = new Array();
			while (iterator.hasNext()) {
				var next : * = iterator.next();
				result.push(next);
			}

			assertEquals(12, result.length);
	
			assertTrue(
				_test.validateItems(
					[list1,
						TestItems.object1, TestItems.object2, TestItems.object3, null, null,
					list2,
						TestItems.object4, TestItems.object5, TestItems.object6, null, null],
					result
				)
			);
		}
	
		public function test_returnsAllItemsAdded_complex(): void {
			fillComplexList();

			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			var result : Array = new Array();
			while (iterator.hasNext()) {
				var next : * = iterator.next();
				result.push(next);
			}
			
			assertEquals(16, result.length);
	
			assertTrue(
				_test.validateItems(
					[list1,
						TestItems.object1, TestItems.object2, TestItems.object3,
						list3,
							TestItems.object4,
							list4,
								TestItems.object2, TestItems.object6, TestItems.object1,
							TestItems.object5,
							TestItems.object6,
					list2,
						TestItems.object4, TestItems.object5, TestItems.object6],
					result
				)
			);
		}
	
		public function test_next(): void {
			fillList();
			
			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(list1, iterator.next());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object1, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object3, iterator.next());
	
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(list2, iterator.next());
	
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object5, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.next());
	
			// without has next

			iterator = _specialIteratorTest.getRecursiveIterator();

			assertStrictlyEquals(list1, iterator.next());

			assertStrictlyEquals(TestItems.object1, iterator.next());
			
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertStrictlyEquals(TestItems.object3, iterator.next());
	
			assertStrictlyEquals(list2, iterator.next());
	
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertStrictlyEquals(TestItems.object5, iterator.next());
			
			assertStrictlyEquals(TestItems.object6, iterator.next());
		}
		
		public function test_next2() : void {

			list1 = new ArrayList();
			list1.add(TestItems.object1);
			list1.add(TestItems.object2);
	
			list2 = new ArrayList();
			list2.add(TestItems.object3);
			list2.add(TestItems.object4);

			list3 = new ArrayList();
			list3.add(TestItems.object5);
			list3.add(TestItems.object6);
	
			_specialIteratorTest.add(list1);
			_specialIteratorTest.add(list2);
			_specialIteratorTest.add(list3);

			var iterator : IRecursiveIterator = _specialIteratorTest.getRecursiveIterator();

			var result : Array = new Array();
			while (iterator.hasNext()) {
				var next : * = iterator.next();
				result.push(next);
			}
			
			assertEquals(9, result.length);
	
			assertTrue(
				_test.validateItems(
					[list1,
						TestItems.object1, TestItems.object2,
					list2,
						TestItems.object3, TestItems.object4,
					list3,
						TestItems.object5, TestItems.object6],
					result
				)
			);

			iterator = _specialIteratorTest.getRecursiveIterator();

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(list1, iterator.next());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object1, iterator.next());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(list2, iterator.next());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object3, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(list3, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object5, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.next());
			
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.next());

			// without has next

			iterator = _specialIteratorTest.getRecursiveIterator();

			assertStrictlyEquals(list1, iterator.next());

			assertStrictlyEquals(TestItems.object1, iterator.next());

			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertStrictlyEquals(list2, iterator.next());

			assertStrictlyEquals(TestItems.object3, iterator.next());
			
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertStrictlyEquals(list3, iterator.next());
			
			assertStrictlyEquals(TestItems.object5, iterator.next());
			
			assertStrictlyEquals(TestItems.object6, iterator.next());
			
			assertTrue(undefined === iterator.next());
		}

	}
}
