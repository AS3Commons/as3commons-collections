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
package org.as3commons.collections.iterators {
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.iterators.FilterIteratorTests;
	import org.as3commons.collections.units.iterators.ICollectionIteratorTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class CollectionFilterIteratorTest extends AbstractSpecialIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function getIterator(index : uint = 0) : IIterator {
			return new CollectionFilterIterator(collection, null);
		}

		override public function getFilterIterator() : IIterator {
			return new CollectionFilterIterator(collection, filter);
		}

		/*
		 * Units
		 */

		/*
		 * CollectionIterator tests
		 */

		public function test_collectionIterator() : void {
			new ICollectionIteratorTests(this).runAllTests();
		}

		/*
		 * FilterIteratorTest
		 */

		public function test_filterIterator() : void {
			new FilterIteratorTests(this).runAllTests();
		}

		/*
		 * CollectionFilterIterator
		 */

		/*
		 * Test next, previous
		 */

		public function test_previous_withoutHasPrevious() : void {
			
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.end();
			
			assertStrictlyEquals(TestItems.object6, iterator.previous());

			assertStrictlyEquals(TestItems.object4, iterator.previous());

			assertStrictlyEquals(TestItems.object2, iterator.previous());

			assertTrue(undefined === iterator.previous());
		}

		public function test_previous2_withoutHasPrevious() : void {
			
			fillCollection(TestItems.itemArray(7));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.end();
			
			assertStrictlyEquals(TestItems.object6, iterator.previous());

			assertStrictlyEquals(TestItems.object4, iterator.previous());

			assertStrictlyEquals(TestItems.object2, iterator.previous());

			assertTrue(undefined === iterator.previous());
		}

		public function test_nextAndPrevious_withoutHasNextAndHasPrevious() : void {
			
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;

			assertStrictlyEquals(TestItems.object2, iterator.next());

			assertStrictlyEquals(TestItems.object2, iterator.previous());

			assertStrictlyEquals(TestItems.object2, iterator.next());

			assertStrictlyEquals(TestItems.object4, iterator.next());

			assertStrictlyEquals(TestItems.object4, iterator.previous());

			assertStrictlyEquals(TestItems.object4, iterator.next());

			assertStrictlyEquals(TestItems.object6, iterator.next());

			assertStrictlyEquals(TestItems.object6, iterator.previous());

			assertStrictlyEquals(TestItems.object6, iterator.next());

			assertTrue(undefined === iterator.next());

			assertStrictlyEquals(TestItems.object6, iterator.previous());
		}

		public function test_nextAndPrevious2_withoutHasNextAndHasPrevious() : void {
			
			fillCollection(TestItems.itemArray(7));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.end();
			
			assertStrictlyEquals(TestItems.object6, iterator.previous());

			assertStrictlyEquals(TestItems.object6, iterator.next());

			assertStrictlyEquals(TestItems.object6, iterator.previous());

			assertStrictlyEquals(TestItems.object4, iterator.previous());

			assertStrictlyEquals(TestItems.object4, iterator.next());

			assertStrictlyEquals(TestItems.object4, iterator.previous());

			assertStrictlyEquals(TestItems.object2, iterator.previous());

			assertStrictlyEquals(TestItems.object2, iterator.next());

			assertStrictlyEquals(TestItems.object2, iterator.previous());

			assertTrue(undefined === iterator.previous());

			assertStrictlyEquals(TestItems.object2, iterator.next());
		}

		public function test_nextAndPrevious() : void {
			
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());
			
			assertTrue(iterator.hasPrevious());
			assertStrictlyEquals(TestItems.object4, iterator.previous());

			assertTrue(iterator.hasPrevious());
			assertStrictlyEquals(TestItems.object2, iterator.previous());
		}

		public function test_nextAndPrevious_alternating() : void {
			
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertTrue(iterator.hasPrevious());
			assertStrictlyEquals(TestItems.object2, iterator.previous());

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());

			assertTrue(iterator.hasPrevious());
			assertStrictlyEquals(TestItems.object2, iterator.previous());
		}

		public function test_next_afterHasPrevious() : void {
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;

			iterator.hasPrevious();
			iterator.hasPrevious();

			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.current);

			iterator.hasPrevious();
			iterator.hasPrevious();

			assertStrictlyEquals(TestItems.object2, iterator.current);
			assertStrictlyEquals(TestItems.object4, iterator.next());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			iterator.hasPrevious();
			iterator.hasPrevious();

			assertStrictlyEquals(TestItems.object4, iterator.current);
		}

		public function test_previous_afterHasNext() : void {
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.end();

			iterator.hasNext();
			iterator.hasNext();
			
			assertStrictlyEquals(TestItems.object6, iterator.previous());
			assertStrictlyEquals(TestItems.object6, iterator.current);

			iterator.hasNext();
			iterator.hasNext();

			assertStrictlyEquals(TestItems.object6, iterator.current);
			assertStrictlyEquals(TestItems.object4, iterator.previous());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			iterator.hasNext();
			iterator.hasNext();

			assertStrictlyEquals(TestItems.object4, iterator.current);
		}

		public function test_nextAndPrevious_afterAlternatingHasNextHasPrevious() : void {
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;

			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertStrictlyEquals(TestItems.object2, iterator.current);
						
			iterator.hasNext();
			iterator.hasPrevious();
			
			assertStrictlyEquals(TestItems.object2, iterator.current);
			assertStrictlyEquals(TestItems.object4, iterator.next());
			assertStrictlyEquals(TestItems.object4, iterator.current);

			iterator.hasPrevious();
			iterator.hasNext();

			assertStrictlyEquals(TestItems.object4, iterator.current);
			assertStrictlyEquals(TestItems.object4, iterator.previous());
			assertStrictlyEquals(TestItems.object4, iterator.current);
		}

		public function test_previous_atEnd() : void {
			fillCollection(TestItems.itemArray(6));

			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.end();
			
			assertStrictlyEquals(TestItems.object6, iterator.previous());
		}

		public function test_previous_atEnd2() : void {
			fillCollection(TestItems.itemArray(7));

			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.end();
			
			assertStrictlyEquals(TestItems.object6, iterator.previous());
		}

		public function test_next_atStart() : void {
			fillCollection(TestItems.itemArray(6));

			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.start();
			
			assertStrictlyEquals(TestItems.object2, iterator.next());
		}

		public function test_next_atStart2() : void {
			fillCollection(TestItems.itemArrayByIndices([2, 3, 4, 5, 6]));

			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			iterator.start();
			
			assertStrictlyEquals(TestItems.object2, iterator.next());
		}
		
		/*
		 * Test remove
		 */

		public function test_remove() : void {
			
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			
			assertTrue(iterator.remove());
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());

			assertTrue(iterator.remove());
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.next());

			assertTrue(iterator.remove());
			assertFalse(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);
		}

		public function test_remove_afterHasNextHasPrevious() : void {
			
			fillCollection(TestItems.itemArray(6));
			
			var iterator : ICollectionIterator = getFilterIterator() as ICollectionIterator;
			
			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object2, iterator.next());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasPrevious());
			
			assertTrue(iterator.remove());
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
			assertTrue(validateTestItems([1, 3, 4, 5, 6], toArray()));

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object4, iterator.next());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());
			assertFalse(iterator.hasPrevious());
			assertTrue(iterator.hasNext());
			assertTrue(undefined === iterator.current);
			assertTrue(validateTestItems([1, 3, 5, 6], toArray()));

			assertTrue(iterator.hasNext());
			assertStrictlyEquals(TestItems.object6, iterator.next());
			assertFalse(iterator.hasNext());
			assertFalse(iterator.hasNext());
			assertTrue(iterator.hasPrevious());
			assertTrue(iterator.hasPrevious());

			assertTrue(iterator.remove());
			assertFalse(iterator.hasPrevious());
			assertFalse(iterator.hasNext());
			assertTrue(undefined === iterator.current);
			assertTrue(validateTestItems([1, 3, 5], toArray()));
		}

	}

}
