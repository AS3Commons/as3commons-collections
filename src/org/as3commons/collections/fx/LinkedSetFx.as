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
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.SetEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Bindable version of the <code>LinkedSet</code> implementation.
	 * 
	 * <p><strong><code>LinkedSetFx</code> event kinds</strong></p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code></li>
	 * <li><code>CollectionEvent.ITEM_REPLACED</code></li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code></li>
	 * <li><code>CollectionEvent.RESET</code></li>
	 * </ul>
	 * 
	 * <p id="link_LinkedSetFxExample"><strong>LinkedSetFx example</strong></p>
	 * 
	 * {{EXAMPLE: LinkedSetFxExample}}
	 * 
	 * @author Jens Struwe 25.03.2010
	 * @see org.as3commons.collections.fx.events.SetEvent SetEvent - Description of the set event properties.
	 * @see org.as3commons.collections.LinkedSet LinkedSet - LinkedSet description and usage examples.
	 */
	public class LinkedSetFx extends LinkedSet implements ICollectionFx {
		
		use namespace as3commons_collections;

		/**
		 * Event dispatcher.
		 */
		private var _eventDispatcher : IEventDispatcher;

		/**
		 * LinkedSetFx constructor.
		 */
		public function LinkedSetFx() {
			_eventDispatcher = new EventDispatcher(this);
		}

		/*
		 * IOrderedSet
		 */

		/**
		 * @inheritDoc
		 */
		override public function addFirst(item : *) : Boolean {
			var added : Boolean = super.addFirst(item);
			if (added) {
				dispatchEvent(new LinkedSetFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					item,
					firstNode_internal
				));
			}
			return added;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addLast(item : *) : Boolean {
			var added : Boolean = super.addLast(item);
			if (added) {
				dispatchEvent(new LinkedSetFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					item,
					lastNode_internal
				));
			}
			return added;
		}
		
		override public function replace(oldItem : *, item : *) : Boolean {
			var replaced : Boolean = super.replace(oldItem, item);
			if (replaced) {
				dispatchEvent(new LinkedSetFxEvent(
					CollectionEvent.ITEM_REPLACED, this,
					item,
					getNode(item)
				));
				
			}
			return replaced;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function reverse() : Boolean {
			var reversed : Boolean = super.reverse();
			if (reversed) dispatchEvent(new SetEvent(CollectionEvent.RESET, this));
			return reversed;
		}

		/**
		 * @inheritDoc
		 */
		override public function sort(comparator : IComparator) : Boolean {
			var sorted : Boolean = super.sort(comparator);
			if (sorted) dispatchEvent(new SetEvent(CollectionEvent.RESET, this));
			return sorted;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeFirst() : * {
			var first : LinkedNode = firstNode_internal;
			var item : * = super.removeFirst();
			if (item !== undefined) {
				dispatchEvent(new LinkedSetFxEvent(
					CollectionEvent.ITEM_REMOVED,
					this,
					first.item,
					firstNode_internal
				));
				return first.item;
			}
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeLast() : * {
			var last : LinkedNode = lastNode_internal;
			var item : * = super.removeLast();
			if (item !== undefined) {
				dispatchEvent(new LinkedSetFxEvent(
					CollectionEvent.ITEM_REMOVED,
					this,
					last.item
				));
				return last.item;
			}
			return undefined;
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
				dispatchEvent(new LinkedSetFxEvent(
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
			if (removed) dispatchEvent(new SetEvent(CollectionEvent.RESET, this));
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
		override protected function addNodeAfter(previous : LinkedNode, node : LinkedNode) : void {
			super.addNodeAfter(previous, node);
			dispatchEvent(new LinkedSetFxEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				node.item,
				node
			));
		}

		/**
		 * @inheritDoc
		 */
		override protected function addNodeBefore(next : LinkedNode, node : LinkedNode) : void {
			super.addNodeBefore(next, node);
			dispatchEvent(new LinkedSetFxEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				node.item,
				node
			));
		}

		/**
		 * @inheritDoc
		 */
		override protected function removeNode(node : LinkedNode) : void {
			var nextNode : LinkedNode = node.right;
			super.removeNode(node);
			dispatchEvent(new LinkedSetFxEvent(
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
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.fx.events.SetEvent;

internal class LinkedSetFxEvent extends SetEvent {
	
	public var nextNode : LinkedNode;

	public function LinkedSetFxEvent(
		theKind : String,
		theSet : ISet,
		theItem : * = undefined,
		theNextNode : LinkedNode = null
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
