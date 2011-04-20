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
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.MapEvent;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.ITestOrder;
	import org.as3commons.collections.units.ITestSortOrder;
	import org.as3commons.collections.units.fx.ICollectionFxTests;
	import org.as3commons.collections.utils.ArrayUtils;

	/**
	 * @author Jens Struwe 29.03.2010
	 */
	public class IMapFxTests extends ICollectionFxTests {

		public function IMapFxTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		private function get _mapFx() : IMap {
			return _test.collection as IMap;
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
		 * MapFx
		 */

		/*
		 * Initial state
		 */

		public function test_init_list() : void {
			assertTrue(_test.collection is IMap);
			assertTrue(_test.collection is ICollectionFx);
		}
		
		/*
		 * Test remove at
		 */

		public function test_removeKey() : void {
			assertTrue(_mapFx.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_mapFx.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object3Key, TestItems.object3));

			setUpListener();
			
			// remove wrong key

			assertFalse(_listener.eventReceived);
			_mapFx.removeKey(TestItems.object4Key);
			assertFalse(_listener.eventReceived);

			// remove key

			assertFalse(_listener.eventReceived);
			assertStrictlyEquals(TestItems.object3, _mapFx.removeKey(TestItems.object3Key));
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			var event : MapEvent = _listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(TestItems.object3Key, event.key);
			assertStrictlyEquals(TestItems.object3, event.item);
			assertEquals(1, event.numItems);
			if (_mapFx is ITestOrder) {
				assertTrue(event.iterator() is IMapIterator);
				assertTrue(undefined === event.iterator().next());
			} else {
				assertNull(event.iterator());
			}
			assertTrue(_listener.validateSize(2));

			// remove key

			assertFalse(_listener.eventReceived);
			assertStrictlyEquals(TestItems.object1, _mapFx.removeKey(TestItems.object1Key));
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(TestItems.object1Key, event.key);
			assertStrictlyEquals(TestItems.object1, event.item);
			assertEquals(1, event.numItems);
			if (_mapFx is ITestOrder) {
				assertTrue(event.iterator() is IMapIterator);
				assertStrictlyEquals(TestItems.object2, event.iterator().next());
			} else {
				assertNull(event.iterator());
			}
			assertTrue(_listener.validateSize(1));

			// remove key

			assertFalse(_listener.eventReceived);
			assertStrictlyEquals(TestItems.object2, _mapFx.removeKey(TestItems.object2Key));
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
			assertEquals(TestItems.object2Key, event.key);
			assertStrictlyEquals(TestItems.object2, event.item);
			assertEquals(1, event.numItems);
			if (_mapFx is ITestOrder) {
				assertTrue(event.iterator() is IMapIterator);
				assertTrue(undefined === event.iterator().next());
			} else {
				assertNull(event.iterator());
			}
			assertTrue(_listener.validateSize(0));

		}

		/*
		 * Test replace
		 */
		
		public function test_replaceFor() : void {
			if (_test.collection is ITestSortOrder) return;
			
			assertTrue(_mapFx.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_mapFx.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object3Key, TestItems.object3));
			assertTrue(_mapFx.add(TestItems.object4Key, TestItems.object4));

			setUpListener();

			// replace for
			
			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object1Key, TestItems.object5);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			var event : MapEvent = _listener.event;
			assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
			assertEquals(TestItems.object1Key, event.key);
			assertStrictlyEquals(TestItems.object5, event.item);
			assertEquals(1, event.numItems);
			if (_mapFx is ITestOrder) {
				assertTrue(event.iterator() is IMapIterator);
				assertStrictlyEquals(TestItems.object5, event.iterator().next());
			} else {
				assertNull(event.iterator());
			}
			assertTrue(_listener.validateSize(4));

			// replace for

			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object4Key, TestItems.object6);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
			assertEquals(TestItems.object4Key, event.key);
			assertStrictlyEquals(TestItems.object6, event.item);
			assertEquals(1, event.numItems);
			if (_mapFx is ITestOrder) {
				assertTrue(event.iterator() is IMapIterator);
				assertStrictlyEquals(TestItems.object6, event.iterator().next());
			} else {
				assertNull(event.iterator());
			}
			assertTrue(_listener.validateSize(4));

			// replace for

			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object3Key, TestItems.object7);
			assertTrue(_listener.eventReceived);
			assertEquals(1, _listener.numEvents);
			event = _listener.event;
			assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
			assertEquals(TestItems.object3Key, event.key);
			assertStrictlyEquals(TestItems.object7, event.item);
			assertEquals(1, event.numItems);
			if (_mapFx is ITestOrder) {
				assertTrue(event.iterator() is IMapIterator);
				assertStrictlyEquals(TestItems.object7, event.iterator().next());
			} else {
				assertNull(event.iterator());
			}
			assertTrue(_listener.validateSize(4));
		}

		public function test_replaceFor_sortOrder() : void {
			if (!(_test.collection is ITestSortOrder)) return;

			assertTrue(_mapFx.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_mapFx.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object3Key, TestItems.object3));
			assertTrue(_mapFx.add(TestItems.object4Key, TestItems.object4));

			setUpListener();

			// replace for
			
			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object1Key, TestItems.object5);
			assertTrue(_listener.eventReceived);
			var events : Array = _listener.events;
			assertEquals(2, events.length);
			var event : MapEvent;
			for (var i : uint = 0; i < events.length; i++) {
				event = events[i];

				if (i == 0) {
					assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
					assertEquals(TestItems.object1Key, event.key);
					assertStrictlyEquals(TestItems.object1, event.item);
					assertEquals(1, event.numItems);
					assertTrue(event.iterator() is IMapIterator);
					assertStrictlyEquals(TestItems.object2, event.iterator().next());
				} else {
					assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
					assertEquals(TestItems.object1Key, event.key);
					assertStrictlyEquals(TestItems.object5, event.item);
					assertEquals(1, event.numItems);
					assertTrue(event.iterator() is IMapIterator);
					assertStrictlyEquals(TestItems.object5, event.iterator().next());
				}

			}
			assertTrue(_listener.validateSizes([3, 4]));

			// key2			key3		key4		key1
			// object2		object3		object4		object5

			// replace for

			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object4Key, TestItems.object6);
			assertTrue(_listener.eventReceived);
			events = _listener.events;
			assertEquals(2, events.length);
			for (i = 0; i < events.length; i++) {
				event = events[i];

				if (i == 0) {
					assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
					assertEquals(TestItems.object4Key, event.key);
					assertStrictlyEquals(TestItems.object4, event.item);
					assertEquals(1, event.numItems);
					assertTrue(event.iterator() is IMapIterator);
					assertStrictlyEquals(TestItems.object5, event.iterator().next());
				} else {
					assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
					assertEquals(TestItems.object4Key, event.key);
					assertStrictlyEquals(TestItems.object6, event.item);
					assertEquals(1, event.numItems);
					assertTrue(event.iterator() is IMapIterator);
					assertStrictlyEquals(TestItems.object6, event.iterator().next());
				}

			}
			assertTrue(_listener.validateSizes([3, 4]));

			// key2			key3		key1		key4
			// object2		object3		object5		object6

			// replace for

			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object3Key, TestItems.object7);
			assertTrue(_listener.eventReceived);
			events = _listener.events;
			assertEquals(2, events.length);
			for (i = 0; i < events.length; i++) {
				event = events[i];

				if (i == 0) {
					assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
					assertEquals(TestItems.object3Key, event.key);
					assertStrictlyEquals(TestItems.object3, event.item);
					assertEquals(1, event.numItems);
					assertTrue(event.iterator() is IMapIterator);
					assertStrictlyEquals(TestItems.object5, event.iterator().next());
				} else {
					assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
					assertEquals(TestItems.object3Key, event.key);
					assertStrictlyEquals(TestItems.object7, event.item);
					assertEquals(1, event.numItems);
					assertTrue(event.iterator() is IMapIterator);
					assertStrictlyEquals(TestItems.object7, event.iterator().next());
				}

			}
			assertTrue(_listener.validateSizes([3, 4]));

			// key2			key1		key4		key3
			// object2		object5		object6		object7

		}

		public function test_replaceFor_withSameItem() : void {
			_mapFx.add(TestItems.object1Key, TestItems.object1);

			setUpListener();

			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object1Key, TestItems.object1);
			assertFalse(_listener.eventReceived);

		}

		public function test_replaceFor_wrongKey() : void {
			_mapFx.add(TestItems.object1Key, TestItems.object1);

			setUpListener();
			
			assertFalse(_listener.eventReceived);
			_mapFx.replaceFor(TestItems.object2Key, TestItems.object2);
			assertFalse(_listener.eventReceived);

		}

		/*
		 * Specialised unit tests
		 */

		/*
		 * Test add
		 */
		
		public function test_add_eventKey() : void {
			_mapFx.add(TestItems.object2Key, TestItems.object2);
			assertTrue(_listener.validateKey(TestItems.object2Key));

			_mapFx.add(TestItems.object7Key, TestItems.object7);
			assertTrue(_listener.validateKey(TestItems.object7Key));

			_mapFx.add(TestItems.object4Key, TestItems.object4);
			assertTrue(_listener.validateKey(TestItems.object4Key));

			_mapFx.add(TestItems.object1Key, TestItems.object1);
			assertTrue(_listener.validateKey(TestItems.object1Key));

			_mapFx.add(TestItems.object3Key, TestItems.object3);
			assertTrue(_listener.validateKey(TestItems.object3Key));
		}

		public function test_add_duplicates_eventKey() : void {
			_mapFx.add(TestItems.object1Key, TestItems.object2);
			assertTrue(_listener.validateKey(TestItems.object1Key));

			_mapFx.add(TestItems.object2Key, TestItems.object4);
			assertTrue(_listener.validateKey(TestItems.object2Key));

			_mapFx.add(TestItems.object3Key, TestItems.object2);
			assertTrue(_listener.validateKey(TestItems.object3Key));

			_mapFx.add(TestItems.object4Key, TestItems.object1);
			assertTrue(_listener.validateKey(TestItems.object4Key));

			_mapFx.add(TestItems.object5Key, TestItems.object3);
			assertTrue(_listener.validateKey(TestItems.object5Key));

			_mapFx.add(TestItems.object6Key, TestItems.object1);
			assertTrue(_listener.validateKey(TestItems.object6Key));

			_mapFx.add(TestItems.object7Key, TestItems.object1);
			assertTrue(_listener.validateKey(TestItems.object7Key));

		}

		/*
		 * Test remove
		 */
		
		public function test_remove_eventKey() : void {
			assertTrue(_mapFx.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_mapFx.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object3Key, TestItems.object3));

			setUpListener();
			
			_mapFx.remove(TestItems.object1);
			assertTrue(_listener.validateKey(TestItems.object1Key));

			_mapFx.remove(TestItems.object3);
			assertTrue(_listener.validateKey(TestItems.object3Key));
		}

		/*
		 * Test remove all
		 */

		public function test_removeAll_eventKey() : void {
			assertTrue(_mapFx.add(TestItems.object1Key, TestItems.object1));
			assertTrue(_mapFx.add(TestItems.object2Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object3Key, TestItems.object3));
			assertTrue(_mapFx.add(TestItems.object4Key, TestItems.object4));
			assertTrue(_mapFx.add(TestItems.object5Key, TestItems.object4));
			assertTrue(_mapFx.add(TestItems.object6Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object7Key, TestItems.object5));
			assertTrue(_mapFx.add(TestItems.object8Key, TestItems.object2));
			assertTrue(_mapFx.add(TestItems.object9Key, TestItems.object3));
			assertTrue(_mapFx.add(TestItems.object10Key, TestItems.object2));

			setUpListener();

			_mapFx.removeAll(TestItems.object2);
			
			if (_test.collection is ITestOrder) {
				assertTrue(ArrayUtils.arraysEqual(
					[TestItems.object2Key, TestItems.object6Key, TestItems.object8Key, TestItems.object10Key],
					_listener.eventKeys()
				));
				
			} else {
				assertTrue(ArrayUtils.arraysMatch(
					[TestItems.object2Key, TestItems.object6Key, TestItems.object8Key, TestItems.object10Key],
					_listener.eventKeys()
				));
				
			}
			
		}

		/*
		 * Test clear
		 */
		
		public function test_clear_eventKey() : void {
			_test.fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			_mapFx.clear();
			assertTrue(_listener.validateKey(undefined));
		}
		
		/*
		 * Test iterator remove
		 */

		public function test_iterator_remove_eventKey() : void {
			_test.fillCollection(TestItems.itemArray(5));

			setUpListener();
			
			var iterator : IMapIterator = _mapFx.iterator() as IMapIterator;
			var keys : Array = _test.allKeys(iterator);
			
			// remove at start
			
			iterator.next();
			iterator.remove();
			assertTrue(_listener.validateKey(keys[0]));
			
			// remove in between
			
			iterator.next();
			iterator.next();
			iterator.remove();
			assertTrue(_listener.validateKey(keys[2]));

			// remove at end
			
			iterator.next();
			iterator.next();
			iterator.remove();
			assertTrue(_listener.validateKey(keys[4]));

			// remove at end
			
			iterator.previous();
			iterator.remove();
			assertTrue(_listener.validateKey(keys[3]));

			// remove sole item
			
			iterator.previous();
			iterator.remove();
			assertTrue(_listener.validateKey(keys[1]));

		}
	}
}
