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
	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.MapEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Bindable version of the <code>LinkedMap</code> implementation.
	 * 
	 * <p><strong><code>LinkedMapFx</code> event kinds</strong></p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code></li>
	 * <li><code>CollectionEvent.ITEM_REPLACED</code></li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code></li>
	 * <li><code>CollectionEvent.RESET</code></li>
	 * </ul>
	 * 
	 * <p id="link_LinkedMapFxExample"><strong>LinkedMapFx example</strong></p>
	 * 
	 * {{EXAMPLE: LinkedMapFxExample}}
	 * 
	 * @author Jens Struwe 29.03.2010
	 * @see org.as3commons.collections.fx.events.MapEvent MapEvent - Description of the map event properties.
	 * @see org.as3commons.collections.LinkedMap LinkedMap - LinkedMap description and usage examples.
	 */
	public class LinkedMapFx extends LinkedMap implements ICollectionFx {

		use namespace as3commons_collections;

		/**
		 * Event dispatcher.
		 */
		private var _eventDispatcher : IEventDispatcher;

		/**
		 * LinkedMapFx constructor.
		 */
		public function LinkedMapFx() {
			_eventDispatcher = new EventDispatcher(this);
		}
		
		/*
		 * IOrderedMap
		 */

		/**
		 * @inheritDoc
		 */
		override public function addFirst(key : *, item : *) : Boolean {
			var added : Boolean = super.addFirst(key, item);
			if (added) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					key,
					item,
					LinkedMapNode(firstNode_internal)
				));
			}
			return added;
		}

		/**
		 * @inheritDoc
		 */
		override public function addLast(key : *, item : *) : Boolean {
			var added : Boolean = super.addLast(key, item);
			if (added) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					key,
					item,
					LinkedMapNode(lastNode_internal)
				));
			}
			return added;
		}

		/**
		 * @inheritDoc
		 */
		override public function addBefore(nextKey : *, key : *, item : *) : Boolean {
			var added : Boolean = super.addBefore(nextKey, key, item);
			if (added) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					key,
					item,
					getNode(key)
				));
			}
			return added;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAfter(previousKey : *, key : *, item : *) : Boolean {
			var added : Boolean = super.addAfter(previousKey, key, item);
			if (added) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					key,
					item,
					getNode(key)
				));
			}
			return added;
		}

		/**
		 * @inheritDoc
		 */
		override public function reverse() : Boolean {
			var reversed : Boolean = super.reverse();
			if (reversed) dispatchEvent(new MapEvent(CollectionEvent.RESET, this));
			return reversed;
		}

		/**
		 * @inheritDoc
		 */
		override public function sort(comparator : IComparator) : Boolean {
			var sorted : Boolean = super.sort(comparator);
			if (sorted) dispatchEvent(new MapEvent(CollectionEvent.RESET, this));
			return sorted;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeFirst() : * {
			var first : LinkedMapNode = firstNode_internal as LinkedMapNode;
			var item : * = super.removeFirst();
			if (item !== undefined) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_REMOVED,
					this,
					first.key,
					first.item,
					LinkedMapNode(firstNode_internal)
				));
				return first.item;
			}
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeLast() : * {
			var last : LinkedMapNode = lastNode_internal as LinkedMapNode;
			var item : * = super.removeLast();
			if (item !== undefined) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_REMOVED,
					this,
					last.key,
					last.item
				));
				return last.item;
			}
			return undefined;
		}

		/*
		 * IMap
		 */

		/**
		 * @inheritDoc
		 */
		override public function add(key : *, item : *) : Boolean {
			var added : Boolean = super.add(key, item);
			if (added) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_ADDED,
					this,
					key,
					item,
					getNode(key)
				));
			}
			return added;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function replaceFor(key : *, item : *) : Boolean {
			var replaced : Boolean = super.replaceFor(key, item);
			if (replaced) {
				dispatchEvent(new LinkedMapFxEvent(
					CollectionEvent.ITEM_REPLACED,
					this,
					key,
					item,
					getNode(key)
				));
			}
			return replaced;
		}
		
		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		override public function clear() : Boolean {
			var removed : Boolean = super.clear();
			if (removed) dispatchEvent(new MapEvent(CollectionEvent.RESET, this));
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
		override protected function removeNode(node : LinkedNode) : void {
			var nextNode : LinkedNode = node.right;
			super.removeNode(node);
			dispatchEvent(new LinkedMapFxEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				LinkedMapNode(node).key,
				node.item,
				nextNode as LinkedMapNode
			));
		}
	}
}

import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.fx.events.MapEvent;

internal class LinkedMapFxEvent extends MapEvent {
	
	public var nextNode : LinkedMapNode;

	public function LinkedMapFxEvent(
		theKind : String,
		theMap : IMap,
		theKey : * = undefined,
		theItem : * = undefined,
		theNextNode : LinkedMapNode = null
	) {
		nextNode = theNextNode;
		
		super(theKind, theMap, theKey, theItem);
	}

	override public function iterator() : ICollectionIterator {
		if (kind == RESET) return null;
		if (nextNode) return map.iterator(nextNode.key) as ICollectionIterator;
		var iterator : ICollectionIterator = map.iterator() as ICollectionIterator;
		iterator.end();
		return iterator;
	}
}
