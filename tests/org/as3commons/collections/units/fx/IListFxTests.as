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
package org.as3commons.collections.units.fx {
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.CollectionEventListener;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ITestInsertionOrder;
	import org.as3commons.collections.units.ITestSortOrder;

	/**
	 * @author Jens Struwe 22.03.2010
	 */
	public class IListFxTests extends ICollectionFxTests {

		public function IListFxTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		private function get _listFx() : IList {
			return _test.collection as IList;
		}

		/*
		 * Units
		 */

		/*
		 * Duplicates tests
		 */

		public function test_duplicates() : void {
			new IDuplicatesFxTests(_test).runAllTests();
		}

		/*
		 * Order tests
		 */

		public function test_order() : void {
			if (_test.collection is ITestInsertionOrder) { // array list fx
				new IInsertionOrderFxTests(_test).runAllTests();
			} else { // sorted list
				new ISortOrderFxTests(_test).runAllTests();
			}
		}

		/*
		 * ListFx
		 */

		/*
		 * Initial state
		 */

		public function test_init_list() : void {
			assertTrue(_test.collection is IList);
			assertTrue(_test.collection is ICollectionFx);
		}
		
		/*
		 * Test set array
		 */
		
		public function test_setArray() : void {
			_test.fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			assertFalse(_listener.eventReceived);
			_listFx.array = TestItems.itemArrayByIndices([4, 5, 6]);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			var event : ListEvent = _listener.event;
			assertEquals(CollectionEvent.RESET, event.kind);
			assertEquals(-1, event.index);
			assertTrue(event.item === undefined);
			assertEquals(-1, event.numItems);

		}

		/*
		 * Test remove at
		 */

		public function test_removeAt() : void {
			_test.fillCollection(TestItems.itemArray(3));

			var listener : CollectionEventListener = new CollectionEventListener(_listFx);
			
			// remove at wrong index

			assertFalse(listener.eventReceived);
			_listFx.removeAt(3);
			assertFalse(listener.eventReceived);

			// remove at

			assertFalse(listener.eventReceived);
			_listFx.removeAt(2);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			var event : ListEvent = listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(2, event.index);
			assertStrictlyEquals(TestItems.object3, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is IListIterator);
			assertStrictlyEquals(undefined, event.iterator().next());
			assertTrue(listener.validateSize(2));

			// remove at

			assertFalse(listener.eventReceived);
			_listFx.removeAt(0);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(0, event.index);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is IListIterator);
			assertStrictlyEquals(TestItems.object2, event.iterator().next());
			assertTrue(listener.validateSize(1));

			// remove at

			assertFalse(listener.eventReceived);
			_listFx.removeAt(0);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(0, event.index);
			assertStrictlyEquals(TestItems.object2, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is IListIterator);
			assertStrictlyEquals(undefined, event.iterator().next());
			assertTrue(listener.validateSize(0));

		}

		/*
		 * Remove all at
		 */
		
		public function test_removeAllAt() : void {
			_test.fillCollection(TestItems.itemArray(5));

			var listener : CollectionEventListener = new CollectionEventListener(_listFx);

			// remove at wrong index

			assertFalse(listener.eventReceived);
			_listFx.removeAllAt(5, 2);
			assertFalse(listener.eventReceived);
			assertTrue(_test.validateTestItems([1, 2, 3, 4, 5]));

			// remove all at

			assertFalse(listener.eventReceived);
			_listFx.removeAllAt(1, 2);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			var event : ListEvent = listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(1, event.index);
			assertTrue(_test.validateTestItems([2, 3], event.items));
			assertEquals(2, event.numItems);
			assertTrue(_test.validateTestItems([1, 4, 5]));
			assertTrue(event.iterator() is IListIterator);
			assertStrictlyEquals(TestItems.object4, event.iterator().next());
			assertTrue(listener.validateSize(3));

			// remove all at (with index exceeding number of items)

			assertFalse(listener.eventReceived);
			_listFx.removeAllAt(2, 2);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(2, event.index);
			assertTrue(_test.validateTestItems([5], event.items));
			assertEquals(1, event.numItems);
			assertTrue(_test.validateTestItems([1, 4]));
			assertTrue(event.iterator() is IListIterator);
			assertStrictlyEquals(undefined, event.iterator().next());
			assertTrue(listener.validateSize(2));

			// remove all at (with index exceeding number of items)

			assertFalse(listener.eventReceived);
			_listFx.removeAllAt(0, 4);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(0, event.index);
			assertTrue(_test.validateTestItems([1, 4], event.items));
			assertEquals(2, event.numItems);
			assertTrue(_test.validateTestItems([]));
			assertTrue(event.iterator() is IListIterator);
			assertStrictlyEquals(undefined, event.iterator().next());
			assertTrue(listener.validateSize(0));

		}

		public function test_removeAllAt_withZeroItems(): void {
			_test.fillCollection(TestItems.itemArray(5));

			var listener : CollectionEventListener = new CollectionEventListener(_listFx);
			assertFalse(listener.eventReceived);
			_listFx.removeAllAt(1, 0);
			assertFalse(listener.eventReceived);
		}

		/*
		 * Specialised unit tests
		 */

		/*
		 * Test add
		 */
		
		public function test_add_eventIndex() : void {
			var index : uint = _listFx.add(TestItems.object2);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object7);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object4);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object1);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object3);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object6);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object5);
			assertTrue(_listener.validateIndex(index));
		}

		public function test_add_duplicates_eventIndex() : void {
			var index : uint = _listFx.add(TestItems.object2);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object4);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object2);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object1);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object3);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object1);
			assertTrue(_listener.validateIndex(index));

			index = _listFx.add(TestItems.object1);
			assertTrue(_listener.validateIndex(index));
		}

		/*
		 * Test remove
		 */
		
		public function test_remove_eventIndex() : void {
			_test.fillCollection(TestItems.itemArray(4));

			setUpListener();
			
			_listFx.remove(TestItems.object1);
			assertTrue(_listener.validateIndex(0));

			_listFx.remove(TestItems.object4);
			assertTrue(_listener.validateIndex(2));
		}

		/*
		 * Test remove all
		 */

		public function test_removeAll_eventIndex() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 2, 2]));

			setUpListener();
			
			_listFx.removeAll(TestItems.object2);
			assertTrue(_listener.validateIndices([1, 1, 1]));
		}

		public function test_removeAll2_eventIndex() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 4, 2, 5, 2, 3, 2]));

			setUpListener();

			_listFx.removeAll(TestItems.object2);

			var indices : Array = _test.collection is ITestSortOrder ? [1, 1, 1, 1] : [1, 4, 5, 6];
			assertTrue(_listener.validateIndices(indices));
		}

		/*
		 * Test remove first, last
		 */

		public function test_removeFirst_eventIndex() : void {
			_test.fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			// remove first
			
			_listFx.removeFirst();
			assertTrue(_listener.validateIndex(0));

			// remove first
			
			_listFx.removeFirst();
			assertTrue(_listener.validateIndex(0));

			// remove first
			
			_listFx.removeFirst();
			assertTrue(_listener.validateIndex(0));
		}

		public function test_removeLast_eventIndex() : void {
			_test.fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			// remove last
			
			_listFx.removeLast();
			assertTrue(_listener.validateIndex(2));

			// remove last
			
			_listFx.removeLast();
			assertTrue(_listener.validateIndex(1));
			
			// remove last
			
			_listFx.removeLast();
			assertTrue(_listener.validateIndex(0));
		}

		/*
		 * Test clear
		 */
		
		public function test_clear_eventIndex() : void {
			_test.fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			_listFx.clear();
			assertTrue(_listener.validateIndex(-1));
		}
		
		/*
		 * Test iterator remove
		 */

		public function test_iterator_remove_eventIndex() : void {
			_test.fillCollection(TestItems.itemArray(5));

			setUpListener();
			
			var iterator : ICollectionIterator = _listFx.iterator() as ICollectionIterator;
			
			// remove at start
			
			iterator.next();
			iterator.remove();
			assertTrue(_listener.validateIndex(0));
			
			// remove in between
			
			iterator.next();
			iterator.next();
			iterator.remove();
			assertTrue(_listener.validateIndex(1));

			// remove at end
			
			iterator.next();
			iterator.next();
			iterator.remove();
			assertTrue(_listener.validateIndex(2));

			// remove at end
			
			iterator.previous();
			iterator.remove();
			assertTrue(_listener.validateIndex(1));

			// remove sole item
			
			iterator.previous();
			iterator.remove();
			assertTrue(_listener.validateIndex(0));

		}

	}

}
