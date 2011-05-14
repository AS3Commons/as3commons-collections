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
	import org.as3commons.collections.SortedMap;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ICollectionFx;
	import org.as3commons.collections.framework.core.SortedMapNode;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.fx.events.CollectionEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Bindable version of the <code>SortedMap</code> implementation.
	 * 
	 * <p><strong><code>SortedMapFx</code> event kinds</strong></p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code></li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code></li>
	 * <li><code>CollectionEvent.RESET</code></li>
	 * </ul>
	 * 
	 * <p>As of its sort order, the <code>SortedMap</code> may change the
	 * position of a key-value-pair within the map after an item replacement
	 * operation (<code>replaceFor()</code>). To anyhow notify a listener about
	 * the former position of the old item and the new position of the replacing
	 * item, the map dispatches in this case a <code>CollectionEvent.ITEM_REMOVED</code>
	 * event immediately followed by a <code>CollectionEvent.ITEM_ADDED</code> event.</p>
	 * 
	 * <p id="link_SortedMapFxExample"><strong>SortedMapFx example</strong></p>
	 * 
	 * {{EXAMPLE: SortedMapFxExample}}
	 * 
	 * @author Jens Struwe 30.03.2010
	 * @see org.as3commons.collections.fx.events.MapEvent MapEvent - Description of the map event properties.
	 * @see org.as3commons.collections.SortedMap SortedMap - SortedMap description and usage examples.
	 */
	public class SortedMapFx extends SortedMap implements ICollectionFx {

		use namespace as3commons_collections;

		/**
		 * Event dispatcher.
		 */
		private var _eventDispatcher : IEventDispatcher;
		
		/**
		 * SortedMapFx constructor.
		 */
		public function SortedMapFx(comparator : IComparator = null) {
			_eventDispatcher = new EventDispatcher(this);

			super(comparator);
		}
		
		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		override public function clear() : Boolean {
			var removed : Boolean = super.clear();
			if (removed) dispatchEvent(new SortedMapFxEvent(CollectionEvent.RESET, this));
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
		override protected function addNode(node : SortedNode) : void {
			super.addNode(node);
			dispatchEvent(new SortedMapFxEvent(
				CollectionEvent.ITEM_ADDED,
				this,
				SortedMapNode(node).key,
				node.item,
				node as SortedMapNode
			));
		}

		/**
		 * @inheritDoc
		 */
		override protected function removeNode(node : SortedNode) : void {
			var nextNode : SortedMapNode = nextNode_internal(node) as SortedMapNode;
			super.removeNode(node);
			dispatchEvent(new SortedMapFxEvent(
				CollectionEvent.ITEM_REMOVED,
				this,
				SortedMapNode(node).key,
				node.item,
				nextNode
			));
		}
	}
}

import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.core.SortedMapNode;
import org.as3commons.collections.fx.events.MapEvent;

internal class SortedMapFxEvent extends MapEvent {
	
	public var nextNode : SortedMapNode;

	public function SortedMapFxEvent(
		theKind : String,
		theMap : IMap,
		theKey : * = undefined,
		theItem : * = undefined,
		theNextNode : SortedMapNode = null
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
