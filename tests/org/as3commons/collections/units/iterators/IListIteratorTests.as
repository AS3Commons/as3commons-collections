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
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class IListIteratorTests extends ICollectionIteratorTests {

		public function IListIteratorTests(test : AbstractIteratorTestCase) {
			super(test);
		}

		/*
		 * Units
		 */

		/*
		 * NextPreviousLookup tests
		 */

		public function test_nextPreviousLookup() : void {
			new IIteratorNextPreviousLookupTests(_test).runAllTests();
		}

		/*
		 * StartIndexTests tests
		 */

		public function test_collectionIteratorStartIndex() : void {
			new ICollectionIteratorStartIndexTests(_test).runAllTests();
		}

		/*
		 * Initial state
		 */

		public function test_init_listIterator() : void {
			assertTrue(_test.getIterator() is IListIterator);
		}

		/*
		 * Test index
		 */

		public function test_index() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : IListIterator = _test.getIterator() as IListIterator;

			assertEquals(-1, iterator.index);

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertEquals(0, iterator.index);

			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertEquals(1, iterator.index);

			assertStrictlyEquals(TestItems.object3, iterator.next());
			assertEquals(2, iterator.index);

			assertTrue(undefined === iterator.next());
			assertEquals(-1, iterator.index);

			assertStrictlyEquals(TestItems.object3, iterator.previous());
			assertEquals(2, iterator.index);

			assertStrictlyEquals(TestItems.object2, iterator.previous());
			assertEquals(1, iterator.index);

			assertStrictlyEquals(TestItems.object1, iterator.previous());
			assertEquals(0, iterator.index);

			assertTrue(undefined === iterator.previous());
			assertEquals(-1, iterator.index);
		}

		public function test_index_resetAfterRemoveStartEnd() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : IListIterator = _test.getIterator() as IListIterator;

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertEquals(1, iterator.index);
			
			iterator.start();
			assertEquals(-1, iterator.index);

			assertStrictlyEquals(TestItems.object1, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertEquals(1, iterator.index);

			iterator.end();
			assertEquals(-1, iterator.index);

			assertStrictlyEquals(TestItems.object3, iterator.previous());
			assertStrictlyEquals(TestItems.object2, iterator.previous());
			assertEquals(1, iterator.index);
			
			iterator.remove();
			assertEquals(-1, iterator.index);

			assertStrictlyEquals(TestItems.object1, iterator.previous());
			assertEquals(0, iterator.index);

		}

	}
}
