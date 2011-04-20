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
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ICollectionTests;

	/**
	 * @author Jens Struwe 26.03.2010
	 */
	public class ISetTests extends ICollectionTests {

		public function ISetTests(test : AbstractCollectionTestCase) {
			super(test);
		}

		private function get _set() : ISet {
			return _test.collection as ISet;
		}

		/*
		 * ISet
		 */

		/*
		 * Initial state
		 */

		public function test_init_set() : void {
			assertTrue(_test.collection is ISet);
		}

		/*
		 * Test add
		 */

		public function test_add_set() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertTrue(_test.validateItems([TestItems.object1Key, TestItems.object2Key, TestItems.object3Key]));
			assertEquals(3, _set.size);
		}

		public function test_add_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertTrue(_test.validateTestItems([1, 2, 3]));
			assertEquals(3, _set.size);
		}

		public function test_add_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertTrue(_test.validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertEquals(8, _set.size);
		}

		public function test_add_itemTwice() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));

			assertFalse(_set.add(TestItems.object1Key));
			assertFalse(_set.add(TestItems.object2Key));
			assertFalse(_set.add(TestItems.object3Key));
			
			assertTrue(_test.validateItems([TestItems.object1Key, TestItems.object2Key, TestItems.object3Key]));
			assertEquals(3, _set.size);
		}

		public function test_add_itemTwice_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertFalse(_set.add(TestItems.object1));
			assertFalse(_set.add(TestItems.object2));
			assertFalse(_set.add(TestItems.object3));

			assertTrue(_test.validateItems([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertEquals(3, _set.size);
		}

		public function test_add_itemTwice_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertFalse(_set.add(null));
			assertFalse(_set.add(-1));
			assertFalse(_set.add(1));
			assertFalse(_set.add("-1"));
			assertFalse(_set.add("1"));
			assertFalse(_set.add("true"));
			assertFalse(_set.add(true));
			assertFalse(_set.add(TestItems.object8));

			assertTrue(_test.validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertEquals(8, _set.size);
		}

		/*
		 * Test has
		 */

		public function test_has_set() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertTrue(_set.has(TestItems.object1Key));
			assertTrue(_set.has(TestItems.object2Key));
		}

		public function test_has_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertTrue(_set.has(TestItems.object1));
			assertTrue(_set.has(TestItems.object2));
		}

		public function test_has_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertTrue(_set.has(null));
			assertTrue(_set.has(-1));
			assertTrue(_set.has(1));
			assertTrue(_set.has("-1"));
			assertTrue(_set.has("1"));
			assertTrue(_set.has("true"));
			assertTrue(_set.has(true));
			assertTrue(_set.has(TestItems.object8));
		}

		public function test_has_wrongKey() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertFalse(_set.has(TestItems.object4Key));
			assertFalse(_set.has(null));
		}

		public function test_has_wrongKey_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertFalse(_set.has(TestItems.object4));
			assertFalse(_set.has(null));
		}

		public function test_has_wrongKey_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertFalse(_set.has("null"));
			assertFalse(_set.has(2));
			assertFalse(_set.has(-2));
			assertFalse(_set.has("-2"));
			assertFalse(_set.has("false"));
			assertFalse(_set.has(false));
			assertFalse(_set.has(TestItems.object9));
		}

		/*
		 * Test toArray
		 */

		public function test_toArray_set(): void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertTrue(_test.validateItems([TestItems.object1Key, TestItems.object2Key, TestItems.object3Key]));
		}

		public function test_toArray_objectItems(): void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertTrue(_test.validateTestItems([1, 2, 3]));
		}

		public function test_toArray_mixedItems(): void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertTrue(_test.validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
		}

		/*
		 * Test remove
		 */

		public function test_remove_set() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertTrue(_set.has(TestItems.object1Key));
			assertTrue(_set.has(TestItems.object2Key));

			assertTrue(_set.remove(TestItems.object1Key));
			assertTrue(_set.remove(TestItems.object2Key));

			assertFalse(_set.has(TestItems.object1Key));
			assertFalse(_set.has(TestItems.object2Key));

			assertTrue(_test.validateItems([TestItems.object3Key]));
			assertEquals(1, _set.size);
		}

		public function test_remove_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertTrue(_set.has(TestItems.object1));
			assertTrue(_set.has(TestItems.object2));

			assertTrue(_set.remove(TestItems.object1));
			assertTrue(_set.remove(TestItems.object2));

			assertFalse(_set.has(TestItems.object1));
			assertFalse(_set.has(TestItems.object2));

			assertTrue(_test.validateItems([TestItems.object3]));
			assertEquals(1, _set.size);
		}

		public function test_remove_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertTrue(_set.has(null));
			assertTrue(_set.has(-1));
			assertTrue(_set.has(1));
			assertTrue(_set.has("-1"));
			assertTrue(_set.has("1"));
			assertTrue(_set.has("true"));
			assertTrue(_set.has(true));
			assertTrue(_set.has(TestItems.object8));

			assertTrue(_test.validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));

			assertTrue(_set.remove(null));

			assertTrue(_test.validateItems([-1, 1, "-1", "1", "true", true, TestItems.object8]));

			assertTrue(_set.remove(-1));

			assertTrue(_test.validateItems([1, "-1", "1", "true", true, TestItems.object8]));

			assertTrue(_set.remove(1));

			assertTrue(_test.validateItems(["-1", "1", "true", true, TestItems.object8]));

			assertTrue(_set.remove("-1"));

			assertTrue(_test.validateItems(["1", "true", true, TestItems.object8]));

			assertTrue(_set.remove("1"));

			assertTrue(_test.validateItems(["true", true, TestItems.object8]));

			assertTrue(_set.remove("true"));

			assertTrue(_test.validateItems([true, TestItems.object8]));

			assertTrue(_set.remove(true));

			assertTrue(_test.validateItems([TestItems.object8]));

			assertTrue(_set.remove(TestItems.object8));

			assertFalse(_set.has(null));
			assertFalse(_set.has(-1));
			assertFalse(_set.has(1));
			assertFalse(_set.has("-1"));
			assertFalse(_set.has("1"));
			assertFalse(_set.has("true"));
			assertFalse(_set.has(true));
			assertFalse(_set.has(TestItems.object8));

			assertTrue(_test.validateItems([]));
			assertEquals(0, _set.size);
		}

		public function test_remove_wrongItem() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertFalse(_set.remove(TestItems.object4Key));
			assertFalse(_set.remove(null));

			assertTrue(_test.validateItems([TestItems.object1Key, TestItems.object2Key, TestItems.object3Key]));
			assertEquals(3, _set.size);
		}

		public function test_remove_wrongItem_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertFalse(_set.remove(TestItems.object4));
			assertFalse(_set.remove(null));

			assertTrue(_test.validateItems([TestItems.object1, TestItems.object2, TestItems.object3]));
			assertEquals(3, _set.size);
		}

		public function test_remove_wrongItem_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertFalse(_set.remove("null"));
			assertFalse(_set.remove(2));
			assertFalse(_set.remove(-2));
			assertFalse(_set.remove("-2"));
			assertFalse(_set.remove("false"));
			assertFalse(_set.remove(false));
			assertFalse(_set.remove(TestItems.object9));

			assertTrue(_test.validateItems([null, -1, 1, "-1", "1", "true", true, TestItems.object8]));
			assertEquals(8, _set.size);
		}

		/*
		 * Test clear
		 */

		public function test_clear_set() : void {
			assertTrue(_set.add(TestItems.object1Key));
			assertTrue(_set.add(TestItems.object2Key));
			assertTrue(_set.add(TestItems.object3Key));
			
			assertTrue(_set.has(TestItems.object1Key));
			assertTrue(_set.has(TestItems.object2Key));
			assertTrue(_set.has(TestItems.object3Key));

			assertTrue(_set.clear());

			assertFalse(_set.has(TestItems.object1Key));
			assertFalse(_set.has(TestItems.object2Key));
			assertFalse(_set.has(TestItems.object3Key));

			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _set.size);
		}

		public function test_clear_objectItems() : void {
			assertTrue(_set.add(TestItems.object1));
			assertTrue(_set.add(TestItems.object2));
			assertTrue(_set.add(TestItems.object3));
			
			assertTrue(_set.has(TestItems.object1));
			assertTrue(_set.has(TestItems.object2));
			assertTrue(_set.has(TestItems.object3));

			assertTrue(_set.clear());

			assertFalse(_set.has(TestItems.object1));
			assertFalse(_set.has(TestItems.object2));
			assertFalse(_set.has(TestItems.object3));

			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _set.size);
		}

		public function test_clear_mixedItems() : void {
			assertTrue(_set.add(null));
			assertTrue(_set.add(-1));
			assertTrue(_set.add(1));
			assertTrue(_set.add("-1"));
			assertTrue(_set.add("1"));
			assertTrue(_set.add("true"));
			assertTrue(_set.add(true));
			assertTrue(_set.add(TestItems.object8));
			
			assertTrue(_set.has(null));
			assertTrue(_set.has(-1));
			assertTrue(_set.has(1));
			assertTrue(_set.has("-1"));
			assertTrue(_set.has("1"));
			assertTrue(_set.has("true"));
			assertTrue(_set.has(true));
			assertTrue(_set.has(TestItems.object8));

			assertTrue(_set.clear());

			assertFalse(_set.has(null));
			assertFalse(_set.has(-1));
			assertFalse(_set.has(1));
			assertFalse(_set.has("-1"));
			assertFalse(_set.has("1"));
			assertFalse(_set.has("true"));
			assertFalse(_set.has(true));
			assertFalse(_set.has(TestItems.object8));

			assertTrue(_test.validateTestItems([]));
			assertEquals(0, _set.size);
		}
		
	}
}
