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
	import org.as3commons.collections.SortedList;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Bindable version of the <code>SortedList</code> implementation.
	 * 
	 * <p><strong><code>SortedListFx</code> event kinds</strong></p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code></li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code></li>
	 * <li><code>CollectionEvent.RESET</code></li>
	 * </ul>
	 * 
	 * <p id="link_SortedListFxExample"><strong>SortedListFx example</strong></p>
	 * 
	 * {{EXAMPLE: SortedListFxExample}}
	 * 
	 * @author Jens Struwe 22.03.2010
	 * @see org.as3commons.collections.fx.events.ListEvent ListEvent - Description of the list event properties.
	 * @see org.as3commons.collections.SortedList SortedList - SortedList description and usage examples.
	 */
	public class SortedListFx extends SortedList implements ICollectionFx {

		/**
		 * Event dispatcher.
		 */
		private var _eventDispatcher : IEventDispatcher;
		
		/**
		 * SortedListFx constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function SortedListFx(comparator : IComparator = null) {
			_eventDispatcher = new EventDispatcher(this);

			super(comparator);
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

		/*
		 * ICollection
		 */

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
