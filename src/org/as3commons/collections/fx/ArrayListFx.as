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
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @eventType org.as3commons.collections.fx.events.CollectionEvent.COLLECTION_CHANGED
	 */
	[Event(name="collectionChanged", type="org.as3commons.collections.fx.events.ListEvent")]

	/**
	 * Bindable version of the <code>ArrayList</code> implementation.
	 * 
	 * <p><strong><code>ArrayListFx</code> event kinds</strong></p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code></li>
	 * <li><code>CollectionEvent.ITEM_REPLACED</code></li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code></li>
	 * <li><code>CollectionEvent.RESET</code></li>
	 * </ul>
	 * 
	 * <p>The <code>ArrayList</code> offers two bulk methods to add or remove
	 * a list of items (<code>addAllAt(), removeAllAt()</code>) in one step.
	 * In response to either of those operations the event property <code>CollectionEvent.items</code>
	 * is set. In all other cases of adding, removing or replacing of items the
	 * event property <code>CollectionEvent.item</code> is set.</p>
	 * 
	 * <p id="link_ArrayListFxExample"><strong>ArrayListFx example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListFxExample}}
	 * 
	 * @author Jens Struwe 01.03.2010
	 * @see org.as3commons.collections.fx.events.ListEvent ListEvent - Description of the list event properties.
	 * @see org.as3commons.collections.ArrayList ArrayList - ArrayList description and usage examples.
	 */
	public class ArrayListFx extends ArrayList implements ICollectionFx {

		/**
		 * Event dispatcher.
		 */
		private var _eventDispatcher : IEventDispatcher;
		
		/**
		 * ArrayListFx constructor.
		 */
		public function ArrayListFx() {
			_eventDispatcher = new EventDispatcher(this);
		}

		/*
		 * IOrderedList
		 */

		/**
		 * @inheritDoc
		 */
		override public function addFirst(item : *) : void {
			super.addFirst(item);
			dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				0,
				1,
				item,
				null
			));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addLast(item : *) : void {
			super.addLast(item);
			dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				_array.length - 1,
				1,
				item,
				null
			));
		}

		/**
		 * @inheritDoc
		 */
		override public function addAt(index : uint, item : *) : Boolean {
			var added : Boolean = super.addAt(index, item);
			if (added) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				index,
				1,
				item,
				null
			));
			return added;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAllAt(index : uint, items : Array) : Boolean {
			var added : Boolean = super.addAllAt(index, items);
			if (added) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				index,
				items.length,
				null,
				items
			));
			return added;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function replaceAt(index : uint, item : *) : Boolean {
			var replaced : Boolean = super.replaceAt(index, item);
			if (replaced) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_REPLACED,
				this,
				index,
				1,
				item,
				null
			));
			return replaced;
		}

		/**
		 * @inheritDoc
		 */
		override public function reverse() : Boolean {
			var reversed : Boolean = super.reverse();
			if (reversed) dispatchEvent(new ListEvent(CollectionEvent.RESET, this));
			return reversed;
		}

		/**
		 * @inheritDoc
		 */
		override public function sort(comparator : IComparator) : Boolean {
			var sorted : Boolean = super.sort(comparator);
			if (sorted) dispatchEvent(new ListEvent(CollectionEvent.RESET, this));
			return sorted;
		}

		/*
		 * IList
		 */

		/**
		 * @inheritDoc
		 */
		override public function set array(array : Array) : void {
			super.array = array;
			dispatchEvent(new ListEvent(CollectionEvent.RESET, this));
		}

		/**
		 * @inheritDoc
		 */
		override public function add(item : *) : uint {
			var index : uint = super.add(item);
			dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				index,
				1,
				item,
				null
			));
			return index;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeFirst() : * {
			var item : * = super.removeFirst();
			if (item !== undefined) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				0,
				1,
				item,
				null
			));
			return item;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeLast() : * {
			var item : * = super.removeLast();
			if (item !== undefined) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				_array.length,
				1,
				item,
				null
			));
			return item;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeAt(index : uint) : * {
			var item : * = super.removeAt(index);
			if (item !== undefined) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				index,
				1,
				item,
				null
			));
			return item;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeAllAt(index : uint, numItems : uint) : Array {
			var items : Array = super.removeAllAt(index, numItems);
			if (items.length) dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				index,
				items.length,
				null,
				items
			));
			return items;
		}

		/**
		 * @inheritDoc
		 */
		override public function clear() : Boolean {
			var removed : Boolean = super.clear();
			if (removed) dispatchEvent(new ListEvent(CollectionEvent.RESET, this));
			return removed;
		}

		/*
		 * IEventDispatcher
		 */
		
		/**
		 * @inheritDoc
		 */
		public function dispatchEvent(event : Event) : Boolean {
			return _eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEventListener(type : String) : Boolean {
			return _eventDispatcher.hasEventListener(type);
		}
		
		/**
		 * @inheritDoc
		 */
		public function willTrigger(type : String) : Boolean {
			return _eventDispatcher.willTrigger(type);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
	
		/*
		 * Protected
		 */

		/**
		 * @inheritDoc
		 */
		override protected function itemRemoved(index : uint, item : *) : void {
			dispatchEvent(new ListEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				index,
				1,
				item,
				null
			));
		}

	}
}
