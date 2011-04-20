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
	import org.as3commons.collections.LinkedMapTest;
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IOrderedMap;
	import org.as3commons.collections.framework.IOrderedMapIterator;
	import org.as3commons.collections.mocks.LinkedMapFxMock;
	import org.as3commons.collections.testhelpers.CollectionEventListener;
	import org.as3commons.collections.testhelpers.TestItems;
	import org.as3commons.collections.units.fx.IInsertionOrderFxTests;
	import org.as3commons.collections.units.fx.IMapFxTests;
	import org.as3commons.collections.utils.StringComparator;

	/**
	 * @author Jens Struwe 29.03.2010
	 */
	public class LinkedMapFxTest extends LinkedMapTest {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new LinkedMapFxMock();
		}

		private function get _orderedMapFx() : IOrderedMap {
			return collection as IOrderedMap;
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
		 * MapFx tests
		 */

		public function test_map_fx() : void {
			new IMapFxTests(this).runAllTests();
		}

		/*
		 * Order tests
		 */

		public function test_order_fx() : void {
			new IInsertionOrderFxTests(this).runAllTests();
		}

		/*
		 * Specialised unit tests
		 */
	
		/*
		 * Test add first, last
		 */

		public function test_addFirst_eventKey() : void {

			// add to empty list
			
			_orderedMapFx.addFirst(TestItems.object2Key, TestItems.object2);
			_listener.validateKey(TestItems.object2Key);

			// add at start

			_orderedMapFx.addFirst(TestItems.object1Key, TestItems.object1);
			_listener.validateKey(TestItems.object1Key);

			// add at start

			_orderedMapFx.addFirst(TestItems.object3Key, TestItems.object3);
			_listener.validateKey(TestItems.object3Key);
		}

		public function test_addLast_eventKey() : void {

			// add to empty list
			
			_orderedMapFx.addLast(TestItems.object2Key, TestItems.object2);
			_listener.validateKey(TestItems.object2Key);

			// add at end

			_orderedMapFx.addLast(TestItems.object1Key, TestItems.object1);
			_listener.validateKey(TestItems.object1Key);

			// add at end

			_orderedMapFx.addLast(TestItems.object3Key, TestItems.object3);
			_listener.validateKey(TestItems.object3Key);
		}

		/*
		 * Test sort
		 */
		
		public function test_sort_eventKey() : void {
			_orderedMapFx.add(1, "dog");
			_orderedMapFx.add(2, "mouse");
			_orderedMapFx.add(3, "cat");
			_orderedMapFx.add(4, "Wolf");
			_orderedMapFx.add(5, "Anaconda");

			setUpListener();

			_orderedMapFx.sort(new StringComparator());
			_listener.validateKey(undefined);
			
		}

		/*
		 * Test reverse
		 */

		public function test_reverse_eventKey() : void {
			_orderedMapFx.add(1, "dog");
			_orderedMapFx.add(2, "mouse");
			_orderedMapFx.add(3, "cat");
			_orderedMapFx.add(4, "Wolf");
			_orderedMapFx.add(5, "Anaconda");

			setUpListener();

			_orderedMapFx.reverse();
			_listener.validateKey(undefined);
		}

		/*
		 * Test remove first, last
		 */

		public function test_removeFirst_eventKey() : void {
			_orderedMapFx.add(TestItems.object1Key, TestItems.object1);
			_orderedMapFx.add(TestItems.object2Key, TestItems.object2);
			_orderedMapFx.add(TestItems.object3Key, TestItems.object3);

			setUpListener();
			
			// remove first
			
			_orderedMapFx.removeFirst();
			assertTrue(_listener.validateKey(TestItems.object1Key));

			// remove first
			
			_orderedMapFx.removeFirst();
			assertTrue(_listener.validateKey(TestItems.object2Key));

			// remove first
			
			_orderedMapFx.removeFirst();
			assertTrue(_listener.validateKey(TestItems.object3Key));
		}

		public function test_removeLast_eventKey() : void {
			_orderedMapFx.add(TestItems.object1Key, TestItems.object1);
			_orderedMapFx.add(TestItems.object2Key, TestItems.object2);
			_orderedMapFx.add(TestItems.object3Key, TestItems.object3);

			setUpListener();
			
			// remove last
			
			_orderedMapFx.removeLast();
			assertTrue(_listener.validateKey(TestItems.object3Key));

			// remove last
			
			_orderedMapFx.removeLast();
			assertTrue(_listener.validateKey(TestItems.object2Key));
			
			// remove last
			
			_orderedMapFx.removeLast();
			assertTrue(_listener.validateKey(TestItems.object1Key));
		}

		/*
		 * Test iterator add before
		 */

		public function test_iterator_addBefore_eventKey() : void {
			fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			var iterator : IOrderedMapIterator = _orderedMapFx.iterator() as IOrderedMapIterator;
			
			// add before at start
			
			iterator.addBefore(TestItems.object4Key, TestItems.object4);
			_listener.validateKey(TestItems.object4Key);

			// add before after first
			
			iterator.addBefore(TestItems.object5Key, TestItems.object5);
			_listener.validateKey(TestItems.object5Key);

			// add before in between
			
			iterator.next();
			iterator.next();
			iterator.addBefore(TestItems.object6Key, TestItems.object6);
			_listener.validateKey(TestItems.object6Key);

			// add before at end
			
			iterator.next();
			assertTrue(undefined === iterator.next());
			iterator.addBefore(TestItems.object7Key, TestItems.object7);
			_listener.validateKey(TestItems.object7Key);

		}
			
		/*
		 * Test iterator add after
		 */

		public function test_iterator_addAfter_eventKey() : void {
			fillCollection(TestItems.itemArray(3));

			setUpListener();
			
			var iterator : IOrderedMapIterator = _orderedMapFx.iterator() as IOrderedMapIterator;
			
			// add before at start
			
			iterator.addAfter(TestItems.object4Key, TestItems.object4);
			_listener.validateKey(TestItems.object4Key);

			// add before after first
			
			iterator.addAfter(TestItems.object5Key, TestItems.object5);
			_listener.validateKey(TestItems.object5Key);

			// add before in between
			
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.addAfter(TestItems.object6Key, TestItems.object6);
			_listener.validateKey(TestItems.object6Key);

			// add before at end
			
			iterator.next();
			iterator.next();
			iterator.addAfter(TestItems.object7Key, TestItems.object7);
			_listener.validateKey(TestItems.object7Key);

		}
			
		public function test_iterator_replace_eventKey() : void {
			_orderedMapFx.add(TestItems.object1Key, TestItems.object1);
			_orderedMapFx.add(TestItems.object2Key, TestItems.object2);
			_orderedMapFx.add(TestItems.object3Key, TestItems.object3);
			_orderedMapFx.add(TestItems.object4Key, TestItems.object4);

			setUpListener();

			var iterator : IOrderedMapIterator = _orderedMapFx.iterator() as IOrderedMapIterator;

			// replace at start

			iterator.next();
			iterator.replace(TestItems.object5);
			_listener.validateKey(TestItems.object1Key);

			// replace in between

			iterator.next();
			iterator.next();
			iterator.replace(TestItems.object5);
			_listener.validateKey(TestItems.object3Key);

			// replace at end

			iterator.next();
			iterator.replace(TestItems.object6);
			_listener.validateKey(TestItems.object4Key);
		}

	}
}
