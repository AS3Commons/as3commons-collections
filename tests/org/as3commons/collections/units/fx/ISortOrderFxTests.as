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
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.CollectionEventListener;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ITestSortOrder;

	/**
	 * @author Jens Struwe 22.03.2010
	 */
	public class ISortOrderFxTests extends IOrderBaseFxTests {

		public function ISortOrderFxTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		private function get _sortOrder() : ITestSortOrder {
			return _test.collection as ITestSortOrder;
		}

		/*
		 * Initial state
		 */

		public function test_init_sortOrder() : void {
			assertTrue(_test.collection is ITestSortOrder);
			assertTrue(_test.collection is ICollectionFx);
		}

		/*
		 * Test add
		 */
		
		public function test_add() : void {
			var listener : CollectionEventListener = new CollectionEventListener(_sortOrder);
			
			assertFalse(listener.eventReceived);
			_sortOrder.addMock(TestItems.object2);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			event = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object2, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is ICollectionIterator);
			assertStrictlyEquals(TestItems.object2, event.iterator().next());
			assertTrue(listener.validateSize(1));

			assertFalse(listener.eventReceived);
			_sortOrder.addMock(TestItems.object1);
			assertTrue(listener.eventReceived);
			assertEquals(1, listener.numEvents);
			var event : CollectionEvent = listener.event;
			assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);
			assertTrue(event.iterator() is ICollectionIterator);
			assertStrictlyEquals(TestItems.object1, event.iterator().next());
			assertTrue(listener.validateSize(2));

		}

	}
}
