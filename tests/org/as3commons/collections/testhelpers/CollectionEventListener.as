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
package org.as3commons.collections.testhelpers {
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;
	import org.as3commons.collections.fx.events.MapEvent;

	/**
	 * @author Jens Struwe 01.03.2010
	 */
	public class CollectionEventListener {

		private var _collection : *;
		private var _eventReceived : Boolean = false;
		private var _event : CollectionEvent;
		private var _events : Array;
		private var _sizes : Array;
		
		public function CollectionEventListener(collection : *) {
			_collection = collection;
			_events = new Array();
			_sizes = new Array();
			_collection.addEventListener(CollectionEvent.COLLECTION_CHANGED, collectionChanged);
		}
		
		private function collectionChanged(event : CollectionEvent) : void {
			_eventReceived = true;
			_event = event;
			_events.push(event);
			_sizes.push(_collection.size);
		}

		public function get eventReceived() : Boolean {
			var received : Boolean = _eventReceived;
			_eventReceived = false;
			return received;
		}
		
		public function get event() : * {
			var event : CollectionEvent = _event;
			_events = new Array();
			_event = null;
			return event;
		}

		public function get numEvents() : uint {
			return _events.length;
		}

		public function get events() : Array {
			var events : Array = _events;
			_events = new Array();
			_event = null;
			return events;
		}
		
		public function cleanUp() : void {
			_collection.removeEventListener(CollectionEvent.COLLECTION_CHANGED, collectionChanged);
		}

		public function validateSize(expectedSize : uint) : Boolean {
			eventReceived; // clear
			var size : int = _sizes[0];
			_sizes = new Array();
			return size == expectedSize;
		}

		public function validateSizes(expectedSizes : Array) : Boolean {
			eventReceived; // clear
			for (var i : uint = 0; i < _sizes.length; i++) {
				if (expectedSizes[i] != _sizes[i]) return false;
			}
			_sizes = new Array();
			return true;
		}

		public function validateIndex(expectedIndex : int) : Boolean {
			eventReceived; // clear
			var listEvent : ListEvent = event;
			if (expectedIndex != listEvent.index) return false;
			
			if (expectedIndex > -1) {
				if (!(listEvent.iterator() is IListIterator)) return false;
				if (listEvent.list.itemAt(listEvent.index) !== listEvent.iterator().next()) return false;
			} else {
				if (listEvent.iterator()) return false;
			}
			return true;
		}

		public function validateIndices(expectedIndices : Array) : Boolean {
			eventReceived; // clear
			var events : Array = events;
			for (var i : uint = 0; i < events.length; i++) {
				var listEvent : ListEvent = events[i];
				if (expectedIndices[i] != listEvent.index) return false;

				if (!(listEvent.iterator() is IListIterator)) return false;
				if (listEvent.list.itemAt(listEvent.index) !== listEvent.iterator().next()) return false;
			}
			return true;
		}

		public function validateKey(expectedKey : *) : Boolean {
			eventReceived; // clear
			var mapEvent : MapEvent = event;
			if (expectedKey !== mapEvent.key) return false;
			return true;
		}

		public function validateKeys(expectedKeys : Array) : Boolean {
			eventReceived; // clear
			var events : Array = events;
			for (var i : uint = 0; i < events.length; i++) {
				var mapEvent : MapEvent = events[i];
				if (expectedKeys[i] != mapEvent.key) return false;
			}
			return true;
		}
		
		public function eventKeys() : Array {
			var keys : Array = new Array();
			eventReceived; // clear
			var events : Array = events;
			for (var i : uint = 0; i < events.length; i++) {
				keys.push(MapEvent(events[i]).key);
			}
			return keys;
		}

	}
}
