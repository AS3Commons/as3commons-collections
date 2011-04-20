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
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ICollectionTests;

	/**
	 * @author Jens Struwe 25.03.2010
	 */
	public class IMapTests extends ICollectionTests {
		public function IMapTests(test : AbstractCollectionTestCase) {
			super(test);
		}

		private function get _map() : IMap {
			return _test.collection as IMap;
		}

		/*
		 * Units
		 */

		/*
		 * Duplicates tests
		 */

		public function test_duplicates() : void {
			new IDuplicatesTests(_test).runAllTests();
		}

		/*
		 * IMap
		 */

		/*
		 * Initial state
		 */

		public function test_init_map() : void {
			assertTrue(_test.collection is IMap);
		}

		/*
		 * Test iterator
		 */

		public function test_iterator_map() : void {
			assertTrue(_test.collection.iterator() is IMapIterator);
		}

		/*
		 * Test add
		 */

		public function test_add_map() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_add_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_add_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5, 6, 7, 8]));
			assertEquals(8, _map.size);
		}

		public function test_add_keyTwice() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));

			assertFalse(_map.add(TestItems.object1Key, TestItems.object4));
			assertFalse(_map.add(TestItems.object2Key, TestItems.object4));
			assertFalse(_map.add(TestItems.object3Key, TestItems.object4));
			
			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_add_keyTwice_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertFalse(_map.add(TestItems.object1, TestItems.object4));
			assertFalse(_map.add(TestItems.object2, TestItems.object4));
			assertFalse(_map.add(TestItems.object3, TestItems.object4));

			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_add_keyTwice_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertFalse(_map.add(null, TestItems.object9));
			assertFalse(_map.add(-1, TestItems.object9));
			assertFalse(_map.add(1, TestItems.object9));
			assertFalse(_map.add("-1", TestItems.object9));
			assertFalse(_map.add("1", TestItems.object9));
			assertFalse(_map.add("true", TestItems.object9));
			assertFalse(_map.add(true, TestItems.object9));
			assertFalse(_map.add(TestItems.object8, TestItems.object9));

			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5, 6, 7, 8]));
			assertEquals(8, _map.size);
		}

		public function test_add_itemTwice() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object1));
			
			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([1, 1, 1]));
		}

		public function test_add_itemTwice_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object1));
			assertTrue(_map.add(TestItems.object3, TestItems.object1));
			
			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([1, 1, 1]));
			assertEquals(3, _map.size);
		}

		public function test_add_itemTwice_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object1));
			assertTrue(_map.add(1, TestItems.object1));
			assertTrue(_map.add("-1", TestItems.object1));
			assertTrue(_map.add("1", TestItems.object1));
			assertTrue(_map.add("true", TestItems.object1));
			assertTrue(_map.add(true, TestItems.object1));
			assertTrue(_map.add(TestItems.object8, TestItems.object1));
			
			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([1, 1, 1, 1, 1, 1, 1, 1]));
			assertEquals(8, _map.size);
		}

		/*
		 * Test replaceKey
		 */

		public function test_replaceKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(_test.validateTestKeys([1, 2, 3]));

			assertTrue(_map.replaceFor(TestItems.object1Key, TestItems.object4));
			assertTrue(_map.replaceFor(TestItems.object2Key, TestItems.object5));
			
			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([4, 5, 3]));
			assertEquals(3, _map.size);
		}

		public function test_replaceKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(_map.replaceFor(TestItems.object1, TestItems.object4));
			assertTrue(_map.replaceFor(TestItems.object2, TestItems.object5));

			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([4, 5, 3]));
			assertEquals(3, _map.size);
		}

		public function test_replaceKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_map.replaceFor(null, null));
			assertTrue(_map.replaceFor(-1, -1));
			assertTrue(_map.replaceFor(1, 1));
			assertTrue(_map.replaceFor("-1", "-1"));
			assertTrue(_map.replaceFor("1", "1"));
			assertTrue(_map.replaceFor("true", "true"));
			assertTrue(_map.replaceFor(true, true));
			assertTrue(_map.replaceFor(TestItems.object8, TestItems.object9));

			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object9]));
			assertEquals(8, _map.size);
		}

		public function test_replaceKey_sameValue() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertFalse(_map.replaceFor(TestItems.object1Key, TestItems.object1));
			assertFalse(_map.replaceFor(TestItems.object2Key, TestItems.object2));

			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_replaceKey_sameValue_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertFalse(_map.replaceFor(TestItems.object1, TestItems.object1));
			assertFalse(_map.replaceFor(TestItems.object2, TestItems.object2));

			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_replaceKey_sameValue_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertFalse(_map.replaceFor(null, TestItems.object1));
			assertFalse(_map.replaceFor(-1, TestItems.object2));
			assertFalse(_map.replaceFor(1, TestItems.object3));
			assertFalse(_map.replaceFor("-1", TestItems.object4));
			assertFalse(_map.replaceFor("1", TestItems.object5));
			assertFalse(_map.replaceFor("true", TestItems.object6));
			assertFalse(_map.replaceFor(true, TestItems.object7));
			assertFalse(_map.replaceFor(TestItems.object8, TestItems.object8));

			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5, 6, 7, 8]));
			assertEquals(8, _map.size);
		}

		public function test_replaceKey_wrongKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertFalse(_map.replaceFor(TestItems.object4Key, TestItems.object4));
			assertFalse(_map.replaceFor(null, TestItems.object5));

			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_replaceKey_wrongKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertFalse(_map.replaceFor(TestItems.object4, TestItems.object4));
			assertFalse(_map.replaceFor(null, TestItems.object5));

			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_replaceKey_wrongKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertFalse(_map.replaceFor("null", TestItems.object9));
			assertFalse(_map.replaceFor(2, TestItems.object9));
			assertFalse(_map.replaceFor(-2, TestItems.object9));
			assertFalse(_map.replaceFor("-2", TestItems.object9));
			assertFalse(_map.replaceFor("false", TestItems.object9));
			assertFalse(_map.replaceFor(false, TestItems.object9));
			assertFalse(_map.replaceFor(TestItems.object9, TestItems.object9));

			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5, 6, 7, 8]));
			assertEquals(8, _map.size);
		}

		/*
		 * Test hasKey
		 */

		public function test_hasKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(_map.hasKey(TestItems.object1Key));
			assertTrue(_map.hasKey(TestItems.object2Key));
		}

		public function test_hasKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(_map.hasKey(TestItems.object1));
			assertTrue(_map.hasKey(TestItems.object2));
		}

		public function test_hasKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_map.hasKey(null));
			assertTrue(_map.hasKey(-1));
			assertTrue(_map.hasKey(1));
			assertTrue(_map.hasKey("-1"));
			assertTrue(_map.hasKey("1"));
			assertTrue(_map.hasKey("true"));
			assertTrue(_map.hasKey(true));
			assertTrue(_map.hasKey(TestItems.object8));
		}

		public function test_hasKey_wrongKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertFalse(_map.hasKey(TestItems.object4Key));
			assertFalse(_map.hasKey(null));
		}

		public function test_hasKey_wrongKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertFalse(_map.hasKey(TestItems.object4));
			assertFalse(_map.hasKey(null));
		}

		public function test_hasKey_wrongKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertFalse(_map.hasKey("null"));
			assertFalse(_map.hasKey(2));
			assertFalse(_map.hasKey(-2));
			assertFalse(_map.hasKey("-2"));
			assertFalse(_map.hasKey("false"));
			assertFalse(_map.hasKey(false));
			assertFalse(_map.hasKey(TestItems.object9));
		}

		/*
		 * Test item for
		 */

		public function test_itemFor() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(TestItems.object1 === _map.itemFor(TestItems.object1Key));
			assertTrue(TestItems.object2 === _map.itemFor(TestItems.object2Key));
		}

		public function test_itemFor_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(TestItems.object1 === _map.itemFor(TestItems.object1));
			assertTrue(TestItems.object2 === _map.itemFor(TestItems.object2));
		}

		public function test_itemFor_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(TestItems.object1 === _map.itemFor(null));
			assertTrue(TestItems.object2 === _map.itemFor(-1));
			assertTrue(TestItems.object3 === _map.itemFor(1));
			assertTrue(TestItems.object4 === _map.itemFor("-1"));
			assertTrue(TestItems.object5 === _map.itemFor("1"));
			assertTrue(TestItems.object6 === _map.itemFor("true"));
			assertTrue(TestItems.object7 === _map.itemFor(true));
			assertTrue(TestItems.object8 === _map.itemFor(TestItems.object8));
		}

		public function test_itemFor_wrongKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(undefined === _map.itemFor(TestItems.object4Key));
			assertTrue(undefined === _map.itemFor(null));
			assertTrue(undefined === _map.itemFor(-1));
		}

		public function test_itemFor_wrongKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(undefined === _map.itemFor(TestItems.object4));
			assertTrue(undefined === _map.itemFor(null));
		}

		public function test_itemFor_wrongKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(undefined === _map.itemFor("null"));
			assertTrue(undefined === _map.itemFor(2));
			assertTrue(undefined === _map.itemFor(-2));
			assertTrue(undefined === _map.itemFor("-2"));
			assertTrue(undefined === _map.itemFor("false"));
			assertTrue(undefined === _map.itemFor(false));
			assertTrue(undefined === _map.itemFor(TestItems.object9));
		}

		/*
		 * Test keysToArray
		 */

		public function test_keysToArray(): void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(_test.validateTestKeys([1, 2, 3], _map.keysToArray()));
		}

		public function test_keysToArray_objectKeys(): void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3], _map.keysToArray()));
		}

		public function test_keysToArray_mixedKeys(): void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8], _map.keysToArray()));
		}

		/*
		 * Test key iterator
		 */

		public function test_keyIterator(): void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(_test.validateTestKeys([1, 2, 3], _test.allKeys(_map.keyIterator())));
		}

		public function test_keyIterator_objectKeys(): void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3], _test.allKeys(_map.keyIterator())));
		}

		public function test_keyIterator_mixedKeys(): void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8], _test.allKeys(_map.keyIterator())));
		}

		/*
		 * Test removeKey
		 */

		public function test_removeKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertStrictlyEquals(TestItems.object1, _map.removeKey(TestItems.object1Key));
			assertStrictlyEquals(TestItems.object2, _map.removeKey(TestItems.object2Key));

			assertTrue(_test.validateTestKeys([3]));
			assertTrue(_test.validateTestItems([3]));
			assertEquals(1, _map.size);
		}

		public function test_removeKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertStrictlyEquals(TestItems.object1, _map.removeKey(TestItems.object1));
			assertStrictlyEquals(TestItems.object2, _map.removeKey(TestItems.object2));

			assertTrue(_test.validateKeys([TestItems.object3]));
			assertTrue(_test.validateTestItems([3]));
			assertEquals(1, _map.size);
		}

		public function test_removeKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertStrictlyEquals(TestItems.object1, _map.removeKey(null));

			assertTrue(_test.validateKeys([-1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([2, 3, 4, 5, 6, 7, 8]));

			assertStrictlyEquals(TestItems.object2, _map.removeKey(-1));

			assertTrue(_test.validateKeys([1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([3, 4, 5, 6, 7, 8]));

			assertStrictlyEquals(TestItems.object3, _map.removeKey(1));

			assertTrue(_test.validateKeys(["-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([4, 5, 6, 7, 8]));

			assertStrictlyEquals(TestItems.object4, _map.removeKey("-1"));

			assertTrue(_test.validateKeys(["1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([5, 6, 7, 8]));

			assertStrictlyEquals(TestItems.object5, _map.removeKey("1"));

			assertTrue(_test.validateKeys(["true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([6, 7, 8]));

			assertStrictlyEquals(TestItems.object6, _map.removeKey("true"));

			assertTrue(_test.validateKeys([true, TestItems.object8]));
			assertTrue(_test.validateTestItems([7, 8]));

			assertStrictlyEquals(TestItems.object7, _map.removeKey(true));

			assertTrue(_test.validateKeys([TestItems.object8]));
			assertTrue(_test.validateTestItems([8]));

			assertStrictlyEquals(TestItems.object8, _map.removeKey(TestItems.object8));

			assertTrue(_test.validateKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_removeKey_wrongKey() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(undefined === _map.removeKey(TestItems.object4Key));
			assertTrue(undefined === _map.removeKey(null));

			assertTrue(_test.validateTestKeys([1, 2, 3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_removeKey_wrongKey_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(undefined === _map.removeKey(TestItems.object4));
			assertTrue(undefined === _map.removeKey(null));

			assertTrue(_test.validateKeys([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _map.size);
		}

		public function test_removeKey_wrongKey_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(undefined === _map.removeKey("null"));
			assertTrue(undefined === _map.removeKey(2));
			assertTrue(undefined === _map.removeKey(-2));
			assertTrue(undefined === _map.removeKey("-2"));
			assertTrue(undefined === _map.removeKey("false"));
			assertTrue(undefined === _map.removeKey(false));
			assertTrue(undefined === _map.removeKey(TestItems.object9));

			assertTrue(_test.validateKeys([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5, 6, 7, 8]));
			assertEquals(8, _map.size);
		}

		/*
		 * Test remove
		 */

		public function test_remove_map() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			
			assertTrue(_map.hasKey(TestItems.object1Key));
			assertTrue(_map.hasKey(TestItems.object2Key));
			assertTrue(_map.hasKey(TestItems.object3Key));

			assertTrue(_map.remove(TestItems.object1));

			assertFalse(_map.hasKey(TestItems.object1Key));
			assertTrue(_map.hasKey(TestItems.object2Key));
			assertTrue(_map.hasKey(TestItems.object3Key));

			assertTrue(_test.validateTestKeys([2, 3]));
			assertTrue(_test.validateTestItems([2, 3]));
			assertEquals(2, _map.size);

			assertTrue(_map.remove(TestItems.object3));

			assertFalse(_map.hasKey(TestItems.object1Key));
			assertTrue(_map.hasKey(TestItems.object2Key));
			assertFalse(_map.hasKey(TestItems.object3Key));

			assertTrue(_test.validateTestKeys([2]));
			assertTrue(_test.validateTestItems([2]));
			assertEquals(1, _map.size);

			assertTrue(_map.remove(TestItems.object2));

			assertFalse(_map.hasKey(TestItems.object1Key));
			assertFalse(_map.hasKey(TestItems.object2Key));
			assertFalse(_map.hasKey(TestItems.object3Key));

			assertTrue(_test.validateTestKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_remove_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			
			assertTrue(_map.hasKey(TestItems.object1));
			assertTrue(_map.hasKey(TestItems.object2));
			assertTrue(_map.hasKey(TestItems.object3));

			assertTrue(_map.remove(TestItems.object1));

			assertFalse(_map.hasKey(TestItems.object1));
			assertTrue(_map.hasKey(TestItems.object2));
			assertTrue(_map.hasKey(TestItems.object3));

			assertTrue(_test.validateKeys([TestItems.object2, TestItems.object3]));
			assertTrue(_test.validateTestItems([2, 3]));
			assertEquals(2, _map.size);

			assertTrue(_map.remove(TestItems.object3));

			assertFalse(_map.hasKey(TestItems.object1));
			assertTrue(_map.hasKey(TestItems.object2));
			assertFalse(_map.hasKey(TestItems.object3));

			assertTrue(_test.validateKeys([TestItems.object2]));
			assertTrue(_test.validateTestItems([2]));
			assertEquals(1, _map.size);

			assertTrue(_map.remove(TestItems.object2));

			assertFalse(_map.hasKey(TestItems.object1));
			assertFalse(_map.hasKey(TestItems.object2));
			assertFalse(_map.hasKey(TestItems.object3));

			assertTrue(_test.validateKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_remove_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_map.hasKey(null));
			assertTrue(_map.hasKey(-1));
			assertTrue(_map.hasKey(1));
			assertTrue(_map.hasKey("-1"));
			assertTrue(_map.hasKey("1"));
			assertTrue(_map.hasKey("true"));
			assertTrue(_map.hasKey(true));
			assertTrue(_map.hasKey(TestItems.object8));

			assertTrue(_map.remove(TestItems.object1));
			assertTrue(_map.remove(TestItems.object3));
			assertTrue(_map.remove(TestItems.object5));
			assertTrue(_map.remove(TestItems.object7));

			assertFalse(_map.hasKey(null));
			assertTrue(_map.hasKey(-1));
			assertFalse(_map.hasKey(1));
			assertTrue(_map.hasKey("-1"));
			assertFalse(_map.hasKey("1"));
			assertTrue(_map.hasKey("true"));
			assertFalse(_map.hasKey(true));
			assertTrue(_map.hasKey(TestItems.object8));

			assertTrue(_test.validateKeys([-1, "-1", "true", TestItems.object8]));
			assertTrue(_test.validateTestItems([2, 4, 6, 8]));
			
			assertTrue(_map.remove(TestItems.object2));
			assertTrue(_map.remove(TestItems.object4));
			assertTrue(_map.remove(TestItems.object6));
			assertTrue(_map.remove(TestItems.object8));

			assertFalse(_map.hasKey(null));
			assertFalse(_map.hasKey(-1));
			assertFalse(_map.hasKey(1));
			assertFalse(_map.hasKey("-1"));
			assertFalse(_map.hasKey("1"));
			assertFalse(_map.hasKey("true"));
			assertFalse(_map.hasKey(true));
			assertFalse(_map.hasKey(TestItems.object8));

			assertTrue(_test.validateKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		/*
		 * Test removeAll
		 */

		public function test_removeAll_map() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			assertTrue(_map.add(TestItems.object4Key, TestItems.object3));
			
			assertTrue(_map.hasKey(TestItems.object1Key));
			assertTrue(_map.hasKey(TestItems.object2Key));
			assertTrue(_map.hasKey(TestItems.object3Key));
			assertTrue(_map.hasKey(TestItems.object4Key));

			assertTrue(_map.removeAll(TestItems.object1));

			assertFalse(_map.hasKey(TestItems.object1Key));
			assertFalse(_map.hasKey(TestItems.object2Key));
			assertTrue(_map.hasKey(TestItems.object3Key));
			assertTrue(_map.hasKey(TestItems.object4Key));

			assertTrue(_test.validateTestKeys([3, 4]));
			assertTrue(_test.validateTestItems([3, 3]));
			assertEquals(2, _map.size);

			assertTrue(_map.removeAll(TestItems.object3));

			assertFalse(_map.hasKey(TestItems.object1Key));
			assertFalse(_map.hasKey(TestItems.object2Key));
			assertFalse(_map.hasKey(TestItems.object3Key));
			assertFalse(_map.hasKey(TestItems.object4Key));

			assertTrue(_test.validateTestKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_removeAll_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object1));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			assertTrue(_map.add(TestItems.object4, TestItems.object3));
			
			assertTrue(_map.hasKey(TestItems.object1));
			assertTrue(_map.hasKey(TestItems.object2));
			assertTrue(_map.hasKey(TestItems.object3));
			assertTrue(_map.hasKey(TestItems.object4));

			assertTrue(_map.removeAll(TestItems.object1));

			assertFalse(_map.hasKey(TestItems.object1));
			assertFalse(_map.hasKey(TestItems.object2));
			assertTrue(_map.hasKey(TestItems.object3));
			assertTrue(_map.hasKey(TestItems.object4));

			assertTrue(_test.validateKeys([TestItems.object3, TestItems.object4]));
			assertTrue(_test.validateTestItems([3, 3]));
			assertEquals(2, _map.size);

			assertTrue(_map.removeAll(TestItems.object3));

			assertFalse(_map.hasKey(TestItems.object1));
			assertFalse(_map.hasKey(TestItems.object2));
			assertFalse(_map.hasKey(TestItems.object3));
			assertFalse(_map.hasKey(TestItems.object4));

			assertTrue(_test.validateKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_removeAll_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object1));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object3));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object5));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object7));
			
			assertTrue(_map.hasKey(null));
			assertTrue(_map.hasKey(-1));
			assertTrue(_map.hasKey(1));
			assertTrue(_map.hasKey("-1"));
			assertTrue(_map.hasKey("1"));
			assertTrue(_map.hasKey("true"));
			assertTrue(_map.hasKey(true));
			assertTrue(_map.hasKey(TestItems.object8));

			assertTrue(_map.removeAll(TestItems.object1));
			assertTrue(_map.removeAll(TestItems.object3));

			assertFalse(_map.hasKey(null));
			assertFalse(_map.hasKey(-1));
			assertFalse(_map.hasKey(1));
			assertFalse(_map.hasKey("-1"));
			assertTrue(_map.hasKey("1"));
			assertTrue(_map.hasKey("true"));
			assertTrue(_map.hasKey(true));
			assertTrue(_map.hasKey(TestItems.object8));

			assertTrue(_test.validateKeys(["1", "true", true, TestItems.object8]));
			assertTrue(_test.validateTestItems([5, 5, 7, 7]));

			assertTrue(_map.removeAll(TestItems.object5));
			assertTrue(_map.removeAll(TestItems.object7));

			assertFalse(_map.hasKey(null));
			assertFalse(_map.hasKey(-1));
			assertFalse(_map.hasKey(1));
			assertFalse(_map.hasKey("-1"));
			assertFalse(_map.hasKey("1"));
			assertFalse(_map.hasKey("true"));
			assertFalse(_map.hasKey(true));
			assertFalse(_map.hasKey(TestItems.object8));

			assertTrue(_test.validateKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		/*
		 * Test clear
		 */

		public function test_clear_map() : void {
			assertTrue(_map.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_map.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_map.add(TestItems.object3Key, TestItems.object3));
			assertTrue(_map.add(TestItems.object4Key, TestItems.object4));
			
			assertTrue(_map.hasKey(TestItems.object1Key));
			assertTrue(_map.hasKey(TestItems.object2Key));
			assertTrue(_map.hasKey(TestItems.object3Key));
			assertTrue(_map.hasKey(TestItems.object4Key));

			assertTrue(_map.clear());

			assertFalse(_map.hasKey(TestItems.object1Key));
			assertFalse(_map.hasKey(TestItems.object2Key));
			assertFalse(_map.hasKey(TestItems.object3Key));
			assertFalse(_map.hasKey(TestItems.object4Key));

			assertTrue(_test.validateTestKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_clear_objectKeys() : void {
			assertTrue(_map.add(TestItems.object1, TestItems.object1));
			assertTrue(_map.add(TestItems.object2, TestItems.object2));
			assertTrue(_map.add(TestItems.object3, TestItems.object3));
			assertTrue(_map.add(TestItems.object4, TestItems.object4));
			
			assertTrue(_map.hasKey(TestItems.object1));
			assertTrue(_map.hasKey(TestItems.object2));
			assertTrue(_map.hasKey(TestItems.object3));
			assertTrue(_map.hasKey(TestItems.object4));

			assertTrue(_map.clear());

			assertFalse(_map.hasKey(TestItems.object1));
			assertFalse(_map.hasKey(TestItems.object2));
			assertFalse(_map.hasKey(TestItems.object3));
			assertFalse(_map.hasKey(TestItems.object4));

			assertTrue(_test.validateTestKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}

		public function test_clear_mixedKeys() : void {
			assertTrue(_map.add(null, TestItems.object1));
			assertTrue(_map.add(-1, TestItems.object2));
			assertTrue(_map.add(1, TestItems.object3));
			assertTrue(_map.add("-1", TestItems.object4));
			assertTrue(_map.add("1", TestItems.object5));
			assertTrue(_map.add("true", TestItems.object6));
			assertTrue(_map.add(true, TestItems.object7));
			assertTrue(_map.add(TestItems.object8, TestItems.object8));
			
			assertTrue(_map.hasKey(null));
			assertTrue(_map.hasKey(-1));
			assertTrue(_map.hasKey(1));
			assertTrue(_map.hasKey("-1"));
			assertTrue(_map.hasKey("1"));
			assertTrue(_map.hasKey("true"));
			assertTrue(_map.hasKey(true));
			assertTrue(_map.hasKey(TestItems.object8));

			assertTrue(_map.clear());

			assertFalse(_map.hasKey(null));
			assertFalse(_map.hasKey(-1));
			assertFalse(_map.hasKey(1));
			assertFalse(_map.hasKey("-1"));
			assertFalse(_map.hasKey("1"));
			assertFalse(_map.hasKey("true"));
			assertFalse(_map.hasKey(true));
			assertFalse(_map.hasKey(TestItems.object8));

			assertTrue(_test.validateTestKeys([]));
			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _map.size);
		}
		
	}
}
