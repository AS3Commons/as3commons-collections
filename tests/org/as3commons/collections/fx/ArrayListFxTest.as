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
package org.as3commons.collections.fx {
	import org.as3commons.collections.ArrayListTest;
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;
	import org.as3commons.collections.mocks.ArrayListFxMock;
	import org.as3commons.collections.testhelpers.CollectionEventListener;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.fx.IListFxTests;
	import org.as3commons.collections.utils.StringComparator;

	/**
	 * @author Jens Struwe 18.03.2010
	 */
	public class ArrayListFxTest extends ArrayListTest {
		
		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new ArrayListFxMock();
		}

		/*
		 * Test neutralisation
		 */

		protected var _listener : CollectionEventListener;
		
		override public function setUp() : void {
			super.setUp();
			setUpListener();
		}

		override public function tearDown() : void {
			super.tearDown();
			_listener = null;
		}
		
		protected function setUpListener() : void {
			_listener = new CollectionEventListener(collection);
		}

		/*
		 * Units
		 */

		/*
		 * ListFx
		 */

		public function test_list_fx() : void {
			new IListFxTests(this).runAllTests();
		}

		/*
		 * Test add at
		 */

		public function test_addAt_fx() : void {

			assertFalse(_listener.eventReceived);
			
			// add at wrong index

			_arrayList.addAt(1, TestItems.object2);

			// add to empty list
			
			assertFalse(_listener.eventReceived);
			_arrayList.addAt(0, TestItems.object2);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			var event : ListEvent = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(0, event.index);
			assertStrictlyEquals(TestItems.object2, event.item);
			assertEquals(1, event.numItems);

			// add at 1

			assertFalse(_listener.eventReceived);
			_arrayList.addAt(1, TestItems.object1);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(1, event.index);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);

			// add at 1

			assertFalse(_listener.eventReceived);
			_arrayList.addAt(1, TestItems.object3);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(1, event.index);
			assertStrictlyEquals(TestItems.object3, event.item);
			assertEquals(1, event.numItems);

			// add at 2

			assertFalse(_listener.eventReceived);
			_arrayList.addAt(2, TestItems.object4);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(2, event.index);
			assertStrictlyEquals(TestItems.object4, event.item);
			assertEquals(1, event.numItems);

			// add at 4

			assertFalse(_listener.eventReceived);
			_arrayList.addAt(4, TestItems.object5);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(4, event.index);
			assertStrictlyEquals(TestItems.object5, event.item);
			assertEquals(1, event.numItems);

			// add at 6

			assertFalse(_listener.eventReceived);
			_arrayList.addAt(6, TestItems.object6);
			assertFalse(_listener.eventReceived);

		}

		/*
		 * Test add all at
		 */

		public function test_addAllAt_fx() : void {

			// add all at wrong index

			assertFalse(_listener.eventReceived);
			_arrayList.addAt(1, TestItems.object2);
			assertFalse(_listener.eventReceived);

			// add to empty list
			
			assertFalse(_listener.eventReceived);
			_arrayList.addAllAt(0, [TestItems.object2, TestItems.object3]);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			var event : ListEvent = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(0, event.index);
			assertTrue(validateTestItems([2, 3], event.items));
			assertEquals(2, event.numItems);

			// add all at 1
			
			assertFalse(_listener.eventReceived);
			_arrayList.addAllAt(1, [TestItems.object4, TestItems.object5]);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(1, event.index);
			assertTrue(validateTestItems([4, 5], event.items));
			assertEquals(2, event.numItems);

			// add all at 4

			assertFalse(_listener.eventReceived);
			_arrayList.addAllAt(4, [TestItems.object6]);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertEquals(4, event.index);
			assertTrue(validateTestItems([6], event.items));
			assertEquals(1, event.numItems);

			// add all at 6

			assertFalse(_listener.eventReceived);
			_arrayList.addAllAt(6, [TestItems.object8, TestItems.object9]);
			assertFalse(_listener.eventReceived);

		}

		/*
		 * Test replace at
		 */
		
		public function test_replaceAt_fx() : void {
			fillCollection(TestItems.itemArray(4));

			setUpListener();

			// replace at
			
			assertFalse(_listener.eventReceived);
			_arrayList.replaceAt(0, TestItems.object5);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			var event : ListEvent = _listener.event;
			assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
			assertEquals(0, event.index);
			assertStrictlyEquals(TestItems.object5, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is IOrderedListIterator);
			assertStrictlyEquals(TestItems.object5, event.iterator().next());

			// replace at

			assertFalse(_listener.eventReceived);
			_arrayList.replaceAt(3, TestItems.object6);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
			assertEquals(3, event.index);
			assertStrictlyEquals(TestItems.object6, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is IOrderedListIterator);
			assertStrictlyEquals(TestItems.object6, event.iterator().next());

			// replace at

			assertFalse(_listener.eventReceived);
			_arrayList.replaceAt(2, TestItems.object7);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
			assertEquals(2, event.index);
			assertStrictlyEquals(TestItems.object7, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is IOrderedListIterator);
			assertStrictlyEquals(TestItems.object7, event.iterator().next());

		}

		public function test_replaceAt_wrongIndex() : void {
			_arrayList.add(TestItems.object1);

			setUpListener();
			
			assertFalse(_listener.eventReceived);
			_arrayList.replaceAt(10, TestItems.object2);
			assertFalse(_listener.eventReceived);

		}

		public function test_replaceAt_withSameItem_fx() : void {
			_arrayList.add(TestItems.object1);

			setUpListener();

			assertFalse(_listener.eventReceived);
			_arrayList.replaceAt(0, TestItems.object1);
			assertFalse(_listener.eventReceived);

		}

		/*
		 * Specialised unit tests
		 */
	
		/*
		 * Test add first, last
		 */

		public function test_addFirst_eventIndex() : void {

			// add to empty list
			
			_arrayList.addFirst(TestItems.object2);
			_listener.validateIndex(0);

			// add at start

			_arrayList.addFirst(TestItems.object1);
			_listener.validateIndex(0);

			// add at start

			_arrayList.addFirst(TestItems.object3);
			_listener.validateIndex(0);

		}

		public function test_addLast_eventIndex() : void {

			// add to empty list
			
			_arrayList.addLast(TestItems.object2);
			_listener.validateIndex(0);

			// add at end

			_arrayList.addLast(TestItems.object1);
			_listener.validateIndex(1);

			// add at end

			_arrayList.addLast(TestItems.object3);
			_listener.validateIndex(2);

		}

		/*
		 * Test sort
		 */
		
		public function test_sort_eventIndex() : void {
			_arrayList.add("dog");
			_arrayList.add("mouse");
			_arrayList.add("cat");
			_arrayList.add("Wolf");
			_arrayList.add("Anaconda");

			setUpListener();

			_arrayList.sort(new StringComparator());
			_listener.validateIndex(-1);
			
		}

		/*
		 * Test reverse
		 */

		public function test_reverse_eventIndex() : void {
			_arrayList.add("dog");
			_arrayList.add("mouse");
			_arrayList.add("cat");
			_arrayList.add("Wolf");
			_arrayList.add("Anaconda");

			setUpListener();

			_arrayList.reverse();
			_listener.validateIndex(-1);
		}

		/*
		 * Test iterator add before
		 */

		public function test_iterator_addBefore_eventIndex() : void {
			fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			var iterator : IOrderedListIterator = _arrayList.iterator() as IOrderedListIterator;
			
			// add before at start
			
			iterator.addBefore(TestItems.object4);
			_listener.validateIndex(0);

			// add before after first
			
			iterator.addBefore(TestItems.object4);
			_listener.validateIndex(1);

			// add before in between
			
			iterator.next();
			iterator.next();
			iterator.addBefore(TestItems.object4);
			_listener.validateIndex(4);

			// add before at end
			
			iterator.next();
			assertTrue(undefined === iterator.next());
			iterator.addBefore(TestItems.object4);
			_listener.validateIndex(6);

		}
			
		/*
		 * Test iterator add after
		 */

		public function test_iterator_addAfter() : void {
			fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			var iterator : IOrderedListIterator = _arrayList.iterator() as IOrderedListIterator;
			
			// add before at start
			
			iterator.addAfter(TestItems.object4);
			_listener.validateIndex(0);

			// add before after first
			
			iterator.addAfter(TestItems.object4);
			_listener.validateIndex(0);

			// add before in between
			
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.addAfter(TestItems.object4);
			_listener.validateIndex(4);

			// add before at end
			
			iterator.next();
			iterator.next();
			iterator.addAfter(TestItems.object4);
			_listener.validateIndex(6);

		}
			
		/*
		 * Test iterator replace
		 */
		
		public function test_iterator_replace() : void {
			fillCollection(TestItems.itemArray(4));

			setUpListener();

			var iterator : IOrderedListIterator = _arrayList.iterator() as IOrderedListIterator;

			// replace at start

			iterator.next();
			iterator.replace(TestItems.object5);
			_listener.validateIndex(0);

			// replace in between

			iterator.next();
			iterator.next();
			iterator.replace(TestItems.object5);
			_listener.validateIndex(2);

			// replace at end

			iterator.next();
			iterator.replace(TestItems.object6);
			_listener.validateIndex(3);
		}

	}
}
