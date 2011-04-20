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
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class ICollectionIteratorTests extends IIteratorTests {

		public function ICollectionIteratorTests(test : AbstractIteratorTestCase) {
			super(test);
		}

		/*
		 * Test initial state
		 */

		public function test_init_collectionIterator() : void {
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			assertTrue(iterator is ICollectionIterator);
		}

		public function test_init_withEmptyCollection_collectionIterator() : void {
			
			// next and previous

			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;

			assertFalse(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);

			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);

			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);

		}
	
		public function test_init_withEmptyCollection2() : void {

			// previous and next

			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;

			assertFalse(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);

			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);

			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);

		}
	
		/*
		 * Test next and previous
		 */

		public function test_nextAndPrevious() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			// hasNext, next

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[0], iterator.current);
	
			iterator.next();
	
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[2], iterator.next());
			assertStrictlyEquals(items[2], iterator.current);
			
			assertFalse(iterator.hasNext());
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.current === undefined);

			// hasPrevious, previous

			assertTrue(iterator.hasPrevious());
			assertStrictlyEquals(items[2], iterator.previous());
			assertStrictlyEquals(items[2], iterator.current);

			iterator.previous();

			assertTrue(iterator.hasPrevious());
			assertStrictlyEquals(items[0], iterator.previous());
			assertStrictlyEquals(items[0], iterator.current);

			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);

			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.current === undefined);

			// hasNext, next

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[0], iterator.next());

		}

		public function test_nextAndPrevious2() : void {

			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[0], iterator.current);

			assertStrictlyEquals(items[0], iterator.previous());
			assertStrictlyEquals(items[0], iterator.current);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[0], iterator.current);
			
			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[1], iterator.current);

			assertStrictlyEquals(items[1], iterator.previous());
			assertStrictlyEquals(items[1], iterator.current);

			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[1], iterator.current);

			assertStrictlyEquals(items[2], iterator.next());
			assertStrictlyEquals(items[2], iterator.current);

			assertStrictlyEquals(items[2], iterator.previous());
			assertStrictlyEquals(items[2], iterator.current);

		}

		/*
		 * Test start
		 */

		public function test_start() : void {
			
			_test.fillCollection(TestItems.itemArray(5));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			
			// at start

			iterator.start();
			
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[0], iterator.next());

			iterator.next();
			
			assertStrictlyEquals(items[2], iterator.next());

			// in between

			iterator.start();
			
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[0], iterator.next());

			iterator.next();
			iterator.next();
			iterator.next();

			assertStrictlyEquals(items[4], iterator.next());

			assertTrue(iterator.next() === undefined);

			// at end

			iterator.start();
			
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.previous() === undefined);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[0], iterator.next());
		}

		/*
		 * Test end
		 */

		public function test_end() : void {
			
			_test.fillCollection(TestItems.itemArray(5));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			
			// at end

			iterator.end();
			
			assertFalse(iterator.hasNext());
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[4], iterator.previous());

			iterator.previous();
			
			assertStrictlyEquals(items[2], iterator.previous());

			// in between

			iterator.end();
			
			assertFalse(iterator.hasNext());
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[4], iterator.previous());

			iterator.previous();
			iterator.previous();
			iterator.previous();

			assertStrictlyEquals(items[0], iterator.previous());

			assertTrue(iterator.previous() === undefined);

			// at start

			iterator.end();
			
			assertFalse(iterator.hasNext());
			assertTrue(iterator.next() === undefined);
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[4], iterator.previous());
		}

		/*
		 * Test null valued items
		 */

		public function test_null_collectionIterator() : void {
			
			_test.fillCollection([null, TestItems.object1, TestItems.object2]);
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			
			assertTrue(_test.validateItems([null, TestItems.object1, TestItems.object2], items));
			
			assertTrue(iterator.hasNext());
			assertTrue(iterator.next() === items[0]);
			assertTrue(iterator.current === items[0]);

			assertTrue(iterator.hasNext());
			assertTrue(iterator.next() === items[1]);
			assertTrue(iterator.current === items[1]);

			assertTrue(iterator.hasNext());
			assertTrue(iterator.next() === items[2]);
			assertTrue(iterator.current === items[2]);

		}

		/*
		 * Test remove
		 */

		public function test_remove() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);

			assertFalse(iterator.remove());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[0], iterator.next());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			
			assertTrue(iterator.remove());

			assertTrue(_test.validateItems([items[1], items[2]]));
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[1], iterator.next());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());

			assertTrue(_test.validateItems([items[2]]));
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[2], iterator.next());
			assertFalse(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());

			assertTrue(_test.validateItems([]));
			assertFalse(iterator.hasNext());
			assertTrue(iterator.next() === undefined);
			assertFalse(iterator.remove());
		}

		public function test_remove2() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);

			assertFalse(iterator.remove());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[0], iterator.current);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			
			assertTrue(iterator.remove());
			assertTrue(iterator.current === undefined);

			assertTrue(_test.validateItems([items[1], items[2]]));
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[1], iterator.current);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());
			assertTrue(iterator.current === undefined);

			assertTrue(_test.validateItems([items[2]]));
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[2], iterator.next());
			assertStrictlyEquals(items[2], iterator.current);
			assertFalse(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());
			assertTrue(iterator.current === undefined);

			assertTrue(_test.validateItems([]));
			assertFalse(iterator.hasNext());
			assertTrue(iterator.next() === undefined);

			assertFalse(iterator.remove());
			assertTrue(iterator.current === undefined);

		}

		public function test_remove_twice() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[1], iterator.next());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[2]], _test.toArray()));
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertFalse(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[2]], _test.toArray()));
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertStrictlyEquals(items[2], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0]], _test.toArray()));
			assertFalse(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertFalse(iterator.remove());
			assertTrue(_test.validateItems([items[0]], _test.toArray()));
			assertFalse(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
		}

		public function test_remove_atStart() : void {
			
			_test.fillCollection(TestItems.itemArray(5));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);
			
			// remove item before retrieving

			assertFalse(iterator.remove());
			assertTrue(_test.validateItems(items, _test.toArray()));

			// remove first item after next()

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[0], iterator.current);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[1], items[2], items[3], items[4]], _test.toArray()));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			// remove first item after previous()

			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[2], iterator.next());
			iterator.previous();
			assertStrictlyEquals(items[1], iterator.previous());
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(items[1], iterator.current);
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[2], items[3], items[4]], _test.toArray()));
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.current === undefined);

		}

		public function test_remove_atEnd() : void {
			
			_test.fillCollection(TestItems.itemArray(5));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			iterator.end();

			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(iterator.current === undefined);
			
			// remove item before retrieving

			assertFalse(iterator.remove());
			assertTrue(_test.validateItems(items, _test.toArray()));

			// remove last item after previous()

			assertStrictlyEquals(items[4], iterator.previous());
			assertStrictlyEquals(items[4], iterator.current);
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());
			
			assertTrue(_test.validateItems([items[0], items[1], items[2], items[3]], _test.toArray()));
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(iterator.current === undefined);

			// remove last item after next()

			assertStrictlyEquals(items[3], iterator.previous());
			assertStrictlyEquals(items[2], iterator.previous());
			iterator.next();
			assertStrictlyEquals(items[3], iterator.next());
			assertTrue(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertStrictlyEquals(items[3], iterator.current);

			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[1], items[2]], _test.toArray()));
			assertFalse(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.current === undefined);

		}

		public function test_remove_nextAfterwards() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			
			assertStrictlyEquals(items[0], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[1], items[2]], _test.toArray()));
			
			assertStrictlyEquals(items[1], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[2]], _test.toArray()));

			assertStrictlyEquals(items[2], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([], _test.toArray()));

			_test.fillCollection(TestItems.itemArray(3));
			
			iterator = _test.getIterator() as ICollectionIterator;
			items = _test.allItems(iterator);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[1], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[2]], _test.toArray()));

			assertStrictlyEquals(items[2], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0]], _test.toArray()));

			_test.fillCollection(TestItems.itemArray(3));
			
			iterator = _test.getIterator() as ICollectionIterator;
			items = _test.allItems(iterator);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[2], iterator.next());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[1]], _test.toArray()));

			assertTrue(iterator.next() === undefined);
			assertFalse(iterator.remove());

		}

		public function test_previous_nextAfterwards() : void {
			_test.fillCollection(TestItems.itemArray(3));
			
			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);
			iterator.end();
			
			assertStrictlyEquals(items[2], iterator.previous());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[1]], _test.toArray()));
			
			assertStrictlyEquals(items[1], iterator.previous());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0]], _test.toArray()));

			assertStrictlyEquals(items[0], iterator.previous());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([], _test.toArray()));

			_test.fillCollection(TestItems.itemArray(3));
			
			iterator = _test.getIterator() as ICollectionIterator;
			items = _test.allItems(iterator);
			iterator.end();

			assertStrictlyEquals(items[2], iterator.previous());
			assertStrictlyEquals(items[1], iterator.previous());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[0], items[2]], _test.toArray()));

			assertStrictlyEquals(items[0], iterator.previous());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[2]], _test.toArray()));

			_test.fillCollection(TestItems.itemArray(3));
			
			iterator = _test.getIterator() as ICollectionIterator;
			items = _test.allItems(iterator);
			iterator.end();

			assertStrictlyEquals(items[2], iterator.previous());
			assertStrictlyEquals(items[1], iterator.previous());
			assertStrictlyEquals(items[0], iterator.previous());
			assertTrue(iterator.remove());
			assertTrue(_test.validateItems([items[1], items[2]], _test.toArray()));

			assertTrue(iterator.previous() === undefined);
			assertFalse(iterator.remove());

		}

		/*
		 * Test current after remove
		 */

		public function test_current_resetAfterRemoveStartEnd() : void {
			_test.fillCollection(TestItems.itemArray(5));

			var iterator : ICollectionIterator = _test.getIterator() as ICollectionIterator;
			var items : Array = _test.allItems(iterator);

			assertStrictlyEquals(items[0], iterator.next());
			assertStrictlyEquals(items[1], iterator.next());
			assertStrictlyEquals(items[2], iterator.next());
			assertStrictlyEquals(items[2], iterator.current);

			iterator.remove();
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[1], iterator.previous());
			assertStrictlyEquals(items[1], iterator.current);

			iterator.end();
			assertTrue(iterator.current === undefined);

			assertStrictlyEquals(items[4], iterator.previous());
			assertStrictlyEquals(items[3], iterator.previous());
			assertStrictlyEquals(items[3], iterator.current);

			iterator.start();
			assertTrue(iterator.current === undefined);

			assertTrue(_test.validateItems([items[0], items[1], items[3], items[4]], _test.toArray()));
		}

	}
}
