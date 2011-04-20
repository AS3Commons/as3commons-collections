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
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorTestCase;
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorUnitTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class FilterIteratorTests extends AbstractSpecialIteratorUnitTestCase {
		public function FilterIteratorTests(test : AbstractSpecialIteratorTestCase) {
			super(test);
		}

		/*
		 * Test next, has next
		 */

		public function test_next() : void {
			
			_specialIteratorTest.fillCollection(TestItems.itemArray(6));
			
			var iterator : IIterator = _specialIteratorTest.getFilterIterator();
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.next());
			
			assertFalse(iterator.hasNext());
		}

		public function test_next_withoutHasNext() : void {
			
			_specialIteratorTest.fillCollection(TestItems.itemArray(6));
			
			var iterator : IIterator = _specialIteratorTest.getFilterIterator();
			
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertStrictlyEquals(TestItems.object6, iterator.next());
			
			assertTrue(undefined === iterator.next());
		}

		public function test_next2() : void {
			
			_specialIteratorTest.fillCollection(TestItems.itemArray(7));
			
			var iterator : IIterator = _specialIteratorTest.getFilterIterator();
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.next());
			
			assertFalse(iterator.hasNext());
		}

		public function test_next2_withoutHasNext() : void {
			
			_specialIteratorTest.fillCollection(TestItems.itemArray(6));
			
			var iterator : IIterator = _specialIteratorTest.getFilterIterator();
			
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertStrictlyEquals(TestItems.object6, iterator.next());
			
			assertTrue(undefined === iterator.next());
		}

		public function test_next_withNoMatchingItems() : void {
			
			_specialIteratorTest.fillCollection(TestItems.itemArrayByIndices([1, 3, 5, 7, 9]));
			
			var iterator : IIterator = _specialIteratorTest.getFilterIterator();
			
			assertFalse(iterator.hasNext());
		}

	}
}
