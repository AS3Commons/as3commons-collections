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
package org.as3commons.collections {

	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISortedMap;
	import org.as3commons.collections.framework.core.AbstractSortedDuplicatesCollection;
	import org.as3commons.collections.framework.core.SortedMapIterator;
	import org.as3commons.collections.framework.core.SortedMapNode;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	import flash.utils.Dictionary;

	/**
	 * Sort order implementation of a map.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>SortedMap</code> is a combination of a dictionary and a binary search tree.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Getting or removing of items - constant runtime O(1).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Key lookup operations - constant runtime O(1).<br />
	 * hasKey(), addBefore(), addAfter(), itemFor(), replaceFor(), removeKey()</code></li>
	 * <li>Adding and removing of items - logarithmic runtime O(log n).<br />
	 * add(), remove(), removeAll()</code></li>
	 * <li>Item lookup inspection operations - logarithmic runtime O(log n).<br />
	 * has(), count(), lesserKey(), higherKey(), equalKeys()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts a key as the cursor parameter. If the given
	 * key is not contained by the map, it will be ignored.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>IMapIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed for keys and for values if the comparator allows <code>null</code>.</p>
	 * 
	 * <p id="link_SortedMapExample"><strong>SortedMap example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>SortedMap</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>Map</code> and <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: SortedMapExample}}
	 * 
	 * <p id="link_MapExample"><strong>Map example</strong></p>
	 * 
	 * {{EXAMPLE: MapExample}}
	 * 
	 * <p id="link_ArrayListExample"><strong>ArrayList example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListExample}}
	 * 
	 * <p id="link_ArrayListIteratorExample"><strong>ArrayListIterator example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListIteratorExample}}
	 * 
	 * @author Jens Struwe 30.03.2010
	 * @see org.as3commons.collections.framework.ISortedMap ISortedMap interface - Detailed description of the sorted map features.
	 * @see org.as3commons.collections.framework.IMapIterator IMapIterator interface - Detailed description of the map iterator features.
	 * @see org.as3commons.collections.framework.IMap IMap interface - Detailed description of the base map features.
	 */
	public class SortedMap extends AbstractSortedDuplicatesCollection implements ISortedMap {

		use namespace as3commons_collections;

		/**
		 * The non string keys.
		 */
		protected var _keys : Dictionary;

		/**
		 * The items of the non string keys.
		 */
		protected var _items : Dictionary;

		/**
		 * The stringed key item map.
		 */
		protected var _stringMap : Object;
		
		/**
		 * SortedMap constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function SortedMap(comparator : IComparator = null) {
			super(comparator);

			_items = new Dictionary();
			_keys = new Dictionary();
			_stringMap = new Object();
		}
		
		/*
		 * ISortedMap
		 */
		
		/**
		 * @inheritDoc
		 */
		public function get firstKey() : * {
			if (!_root) return undefined;
			return SortedMapNode(mostLeftNode_internal()).key;
		}

		/**
		 * @inheritDoc
		 */
		public function get lastKey() : * {
			if (!_root) return undefined;
			return SortedMapNode(mostRightNode_internal()).key;
		}

		/**
		 * @inheritDoc
		 */
		public function nextKey(key : *) : * {
			var node : SortedMapNode = getNode(key);
			if (node) {
				node = nextNode_internal(node) as SortedMapNode;
				if (node) return node.key;
			}
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function previousKey(key : *) : * {
			var node : SortedMapNode = getNode(key);
			if (node) {
				node = previousNode_internal(node) as SortedMapNode;
				if (node) return node.key;
			}
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function lesserKey(item : *) : * {
			var node : SortedMapNode = lesserNode(item) as SortedMapNode;
			if (!node) return undefined;
			return node.key;
		}
		
		/**
		 * @inheritDoc
		 */
		public function higherKey(item : *) : * {
			var node : SortedMapNode = higherNode(item) as SortedMapNode;
			if (!node) return undefined;
			return node.key;
		}

		/**
		 * @inheritDoc
		 */
		public function equalKeys(item : *) : Array {
			var equalKeys : Array = new Array();
			var node : SortedNode = firstEqualNode(item);
			if (!node) return equalKeys;
			
			while (node) {
				if (_comparator.compare(item, node.item)) break;
				equalKeys.push(SortedMapNode(node).key);
				node = nextNode_internal(node);
			}
			
			return equalKeys;
		}

		/*
		 * IMap
		 */
		
		/**
		 * @inheritDoc
		 */
		public function add(key : *, item : *) : Boolean {
			if (key is String) {
				if (_stringMap[key] !== undefined) return false;

			} else {
				if (_keys[key] !== undefined) return false;
			}
			addNode(new SortedMapNode(key, item));
			
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function replaceFor(key : *, item : *) : Boolean {
			var node : SortedMapNode;
			if (key is String) node = _stringMap[key];
			else node = _items[key];

			if (node && node.item !== item) {
				
				removeNode(node);
				node.item = item;
				addNode(node);
				return true;
			}

			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasKey(key : *) : Boolean {
			return key is String ? _stringMap[key] !== undefined : _keys[key] !== undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function itemFor(key : *) : * {
			var node : SortedMapNode;
			if (key is String) node = _stringMap[key];
			else node = _items[key];
			return node ? node.item : undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function keysToArray() : Array {
			var node : SortedNode = mostLeftNode_internal();
			var keys : Array = new Array();
			while (node) {
				keys.push(SortedMapNode(node).key);
				node = nextNode_internal(node);
			}
			return keys;
		}
		
		/**
		 * @inheritDoc
		 */
		public function keyIterator() : IIterator {
			return new KeyIterator(this);
		}

		/**
		 * @inheritDoc
		 */
		public function removeKey(key : *) : * {
			var node : SortedMapNode;
			
			if (key is String) {
				if (_stringMap[key] === undefined) return undefined;
				node = _stringMap[key];

			} else {
				if (_keys[key] === undefined) return undefined;
				node = _items[key];
			}
			
			removeNode(node);
			return node.item;
		}
		
		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		override public function clear() : Boolean {
			if (!_size) return false;
			
			_keys = new Dictionary();
			_items = new Dictionary();
			_stringMap = new Object();

			super.clear();
			return true;
		}

		/*
		 * IIterable
		 */

		/**
		 * @inheritDoc
		 */
		override public function iterator(cursor : * = undefined) : IIterator {
			var node : SortedMapNode;
			if (cursor is String) node = _stringMap[cursor];
			else node = _items[cursor];
			return new SortedMapIterator(this, node);
		}

		/*
		 * Protected
		 */

		/**
		 * Returns the node of the given key.
		 * 
		 * @param key The key to get the node for.
		 * @return The node or <code>null</code> if the key is not contained.
		 */
		protected function getNode(key : *) : SortedMapNode {
			if (key is String) return _stringMap[key];
			return _items[key];
		}

		/**
		 * @inheritDoc
		 */
		override protected function addNode(node : SortedNode) : void {
			super.addNode(node);
			
			var key : * = SortedMapNode(node).key;
			
			if (key is String) {
				_stringMap[key] = node;

			} else {
				_keys[key] = key;
				_items[key] = node;
			}
			
		}

		/**
		 * @inheritDoc
		 */
		override protected function removeNode(node : SortedNode) : void {
			super.removeNode(node);

			var key : * = SortedMapNode(node).key;

			if (key is String) {
				delete _stringMap[key];

			} else {
				delete _keys[key];
				delete _items[key];
			}
		}
	}
}

import org.as3commons.collections.SortedMap;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.core.SortedMapNode;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.framework.core.as3commons_collections;

internal class KeyIterator implements IIterator {

	use namespace as3commons_collections;

	private var _map : SortedMap;
	private var _next : SortedNode;

	public function KeyIterator(map : SortedMap) {
		_map = map;
		_next = map.mostLeftNode_internal();
	}

	public function hasNext() : Boolean{
		return _next != null;
	}

	public function next() : * {
		if (!_next) return undefined;
		var next : SortedNode = _next;
		_next = _map.nextNode_internal(_next);
		return SortedMapNode(next).key;
	}	
}
