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
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.fx.events.CollectionEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Bindable version of the <code>SortedSet</code> implementation.
	 * 
	 * <p><strong><code>SortedSetFx</code> event kinds</strong></p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code></li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code></li>
	 * <li><code>CollectionEvent.RESET</code></li>
	 * </ul>
	 * 
	 * <p id="link_SortedSetFxExample"><strong>SortedSetFx example</strong></p>
	 * 
	 * {{EXAMPLE: SortedSetFxExample}}
	 * 
	 * @author Jens Struwe 30.03.2010
	 * @see org.as3commons.collections.fx.events.SetEvent SetEvent - Description of the set event properties.
	 * @see org.as3commons.collections.SortedSet SortedSet - SortedSet description and usage examples.
	 */
	public class SortedSetFx extends SortedSet implements ICollectionFx {

		use namespace as3commons_collections;

		/**
		 * Event dispatcher.
		 */
		private var _eventDispatcher : IEventDispatcher;
		
		/**
		 * SortedListFx constructor.
		 */
		public function SortedSetFx(comparator : IComparator = null) {
			_eventDispatcher = new EventDispatcher(this);

			super(comparator);
		}
		
		/*
		 * ISet
		 */

		/**
		 * @inheritDoc
		 */
		override public function add(item : *) : Boolean {
			var added : Boolean = super.add(item);
			if (added) {
				dispatchEvent(new SortedSetFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					item,
					getNode(item)
				));
			}
			return added;
		}
		
		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		override public function clear() : Boolean {
			var removed : Boolean = super.clear();
			if (removed) dispatchEvent(new SortedSetFxEvent(CollectionEvent.RESET, this));
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
		override protected function removeNode(node : SortedNode) : void {
			var nextNode : SortedNode = nextNode_internal(node);
			super.removeNode(node);
			dispatchEvent(new SortedSetFxEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				node.item,
				nextNode
			));
		}
	}
}

import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.ISet;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.fx.events.SetEvent;

internal class SortedSetFxEvent extends SetEvent {
	
	public var nextNode : SortedNode;

	public function SortedSetFxEvent(
		theKind : String,
		theSet : ISet,
		theItem : * = undefined,
		theNextNode : SortedNode = null
	) {
		nextNode = theNextNode;
		
		super(theKind, theSet, theItem);
	}

	override public function iterator() : ICollectionIterator {
		if (kind == RESET) return null;
		if (nextNode) return set.iterator(nextNode.item) as ICollectionIterator;
		var iterator : ICollectionIterator = set.iterator() as ICollectionIterator;
		iterator.end();
		return iterator;
	}
}
