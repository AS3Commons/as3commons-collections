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
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 25.03.2010
	 */
	public class IMapIteratorTests extends ICollectionIteratorTests {

		public function IMapIteratorTests(test : AbstractIteratorTestCase) {
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
		 * IMapIterator
		 */

		/*
		 * Initial state
		 */

		public function test_init_listIterator() : void {
			assertTrue(_test.getIterator() is IMapIterator);
		}

		/*
		 * Test key
		 */

		public function test_key() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : IMapIterator = _test.getIterator() as IMapIterator;
			var items : Array = _test.allItems(iterator);
			var keys : Array = _test.allKeys(iterator);

			assertTrue(undefined === iterator.key);

			assertStrictlyEquals(items[0], iterator.next());
			assertEquals(keys[0], iterator.key);

			assertStrictlyEquals(items[1], iterator.next());
			assertEquals(keys[1], iterator.key);

			assertStrictlyEquals(items[2], iterator.next());
			assertEquals(keys[2], iterator.key);

			assertTrue(undefined === iterator.next());
			assertTrue(undefined === iterator.key);

			assertStrictlyEquals(items[2], iterator.previous());
			assertEquals(keys[2], iterator.key);

			assertStrictlyEquals(items[1], iterator.previous());
			assertEquals(keys[1], iterator.key);

			assertStrictlyEquals(items[0], iterator.previous());
			assertEquals(keys[0], iterator.key);

			assertTrue(undefined === iterator.previous());
			assertTrue(undefined === iterator.key);
		}

		public function test_key2() : void {
			IMap(_test.collection).add(1, "one");
			
			var iterator : IMapIterator = _test.getIterator() as IMapIterator;

			assertTrue(undefined === iterator.key);
			assertStrictlyEquals("one", iterator.next());
			assertEquals(1, iterator.key);
		}

		public function test_key_resetAfterRemoveStartEnd() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : IMapIterator = _test.getIterator() as IMapIterator;
			
			var items : Array = _test.allItems(iterator);
			var keys : Array = _test.allKeys(iterator);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[1], iterator.next());
			assertEquals(keys[1], iterator.key);
			
			iterator.start();
			assertTrue(undefined === iterator.key);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[1], iterator.next());
			assertEquals(keys[1], iterator.key);

			iterator.end();
			assertTrue(undefined === iterator.key);

			assertStrictlyEquals(items[2], iterator.previous());
			assertStrictlyEquals(items[1], iterator.previous());
			assertEquals(keys[1], iterator.key);
			
			iterator.remove();
			assertTrue(undefined === iterator.key);
			
			assertStrictlyEquals(items[0], iterator.previous());
			assertEquals(keys[0], iterator.key);

		}

	}
}
