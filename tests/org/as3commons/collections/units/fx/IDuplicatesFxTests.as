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
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.AbstractCollectionUnitTestCase;
	import org.as3commons.collections.testhelpers.CollectionEventListener;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ITestDuplicates;

	/**
	 * @author Jens Struwe 22.03.2010
	 */
	public class IDuplicatesFxTests extends AbstractCollectionUnitTestCase {

		public function IDuplicatesFxTests(test : AbstractCollectionTestCase) {
			super(test);
		}

		private function get _duplicates() : ITestDuplicates {
			return _test.collection as ITestDuplicates;
		}
		
		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(_test.collection is ITestDuplicates);
			assertTrue(_test.collection is ICollectionFx);
		}

		/*
		 * Test add
		 */
		
		public function test_add() : void {
			var listener : CollectionEventListener = new CollectionEventListener(_duplicates);

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object2);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			var event : CollectionEvent = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object2, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(1));

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object4);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object4, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(2));

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object2);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object2, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(3));

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object1);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(4));

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object3);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object3, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(5));

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object1);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(6));

			assertFalse(listener.eventReceived);
			_duplicates.addMock(TestItems.object1);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);
			assertTrue(listener.validateSize(7));

		}

		/*
		 * Test remove all
		 */

		public function test_removeAll() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 2, 2]));

			var listener : CollectionEventListener = new CollectionEventListener(_duplicates);
			
			assertFalse(listener.eventReceived);
			_duplicates.removeAll(TestItems.object2);
			assertTrue(listener.eventReceived);
			var events : Array = listener.events;
			assertEquals(3, events.length);
			var event : CollectionEvent;
			for (var i : uint = 0; i < events.length; i++) {
				event = events[i];
				assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
				assertStrictlyEquals(TestItems.object2, event.item);
				assertEquals(1, event.numItems);
			}
			assertTrue(listener.validateSizes([3, 2, 1]));
		}

		public function test_removeAll2() : void {
			_test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 4, 2, 5, 2, 3, 2]));

			var listener : CollectionEventListener = new CollectionEventListener(_duplicates);

			assertFalse(listener.eventReceived);
			_duplicates.removeAll(TestItems.object2);
			assertTrue(listener.eventReceived);
			var events : Array = listener.events;
			assertEquals(4, events.length);
			var event : CollectionEvent;
			for (var i : uint = 0; i < events.length; i++) {
				event = events[i];
				assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
				assertStrictlyEquals(TestItems.object2, event.item);
				assertEquals(1, event.numItems);
			}
			assertTrue(listener.validateSizes([9, 8, 7, 6]));

		}
	}
}
