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
	 * @author Jens Struwe 01.04.2010
	 */
	public class IIteratorNextPreviousLookupTests extends AbstractIteratorUnitTestCase {

		public function IIteratorNextPreviousLookupTests(test : AbstractIteratorTestCase) {
			super(test);
		}

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_test.getIterator() is ITestIteratorNextPreviousLookup);
		}

		/*
		 * Test nextKey
		 */

		public function test_nextItem_previousItem() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ITestIteratorNextPreviousLookup = _test.getIterator() as ITestIteratorNextPreviousLookup;
			var items : Array = _test.allItems(iterator);

			assertTrue(undefined === iterator.current);

			assertTrue(undefined === iterator.previousMock);
			assertStrictlyEquals(items[0], iterator.nextMock);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[0], iterator.current);

			assertStrictlyEquals(items[0], iterator.previousMock);
			assertStrictlyEquals(items[1], iterator.nextMock);

			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[1], iterator.current);

			assertStrictlyEquals(items[1], iterator.previousMock);
			assertStrictlyEquals(items[2], iterator.nextMock);

			assertStrictlyEquals(items[2], iterator.next());
			assertStrictlyEquals(items[2], iterator.current);

			assertStrictlyEquals(items[2], iterator.previousMock);
			assertTrue(undefined === iterator.nextMock);

			assertTrue(undefined === iterator.next());
			assertTrue(undefined === iterator.current);

			assertStrictlyEquals(items[2], iterator.previousMock);
			assertTrue(undefined === iterator.nextMock);

			assertStrictlyEquals(items[2], iterator.previous());
			assertStrictlyEquals(items[2], iterator.current);

			assertStrictlyEquals(items[1], iterator.previousMock);
			assertStrictlyEquals(items[2], iterator.nextMock);

			assertStrictlyEquals(items[1], iterator.previous());
			assertStrictlyEquals(items[1], iterator.current);

			assertStrictlyEquals(items[0], iterator.previousMock);
			assertStrictlyEquals(items[1], iterator.nextMock);

			assertStrictlyEquals(items[0], iterator.previous());
			assertStrictlyEquals(items[0], iterator.current);

			assertTrue(undefined === iterator.previousMock);
			assertStrictlyEquals(items[0], iterator.nextMock);

			assertTrue(undefined === iterator.previous());
			assertTrue(undefined === iterator.current);

			assertTrue(undefined === iterator.previousMock);
			assertStrictlyEquals(items[0], iterator.nextMock);
		}

	}
}
