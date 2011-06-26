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
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IOrderedMap;
	import org.as3commons.collections.framework.core.AbstractLinkedDuplicatesCollection;
	import org.as3commons.collections.framework.core.LinkedMapIterator;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.framework.core.LinkedNode;

	import flash.utils.Dictionary;

	/**
	 * Insertion order implementation of a map.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>LinkedMap</code> is a combination of a dictionary and a linked list.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Adding, getting or removing of items - constant runtime O(1).<br />
	 * <code>add(), addFirst(), addLast(), first, last, removeFirst(), removeLast()</code></li>
	 * <li>Key lookup operations - constant runtime O(1).<br />
	 * hasKey(), addBefore(), addAfter(), itemFor(), replaceFor(), removeKey()</code></li>
	 * <li>Item lookup operations - linear runtime O(n).<br />
	 * has(), count(), remove(), removeAll()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts a key as the cursor parameter. If the given
	 * key is not contained by the map, it will be ignored.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>IOrderedMapIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed for keys as well as for values.</p>
	 * 
	 * <p id="link_LinkedMapExample"><strong>LinkedMap example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>LinkedMap</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>Map</code> and <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: LinkedMapExample}}
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
	 * @author Jens Struwe 25.03.2010
	 * @see org.as3commons.collections.framework.IOrderedMap IOrderedMap interface - Detailed description of the ordered map features.
	 * @see org.as3commons.collections.framework.IOrderedMapIterator IOrderedMapIterator interface - Detailed description of the ordered map iterator features.
	 * @see org.as3commons.collections.framework.IMap IMap interface - Detailed description of the base map features.
	 */
	public class LinkedMap extends AbstractLinkedDuplicatesCollection implements IOrderedMap {
		
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
		 * LinkedMap constructor.
		 */
		public function LinkedMap() {
			_items = new Dictionary();
			_keys = new Dictionary();
			_stringMap = new Object();
		}
		
		/*
		 * IOrderedMap
		 */

		/**
		 * @inheritDoc
		 */
		public function addFirst(key : *, item : *) : Boolean {
			var node : LinkedMapNode = add_private(key, item);
			if (node) {
				addNodeFirst(node);
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addLast(key : *, item : *) : Boolean {
			var node : LinkedMapNode = add_private(key, item);
			if (node) {
				addNodeLast(node);
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addBefore(nextKey : *, key : *, item : *) : Boolean {
			var nextNode : LinkedMapNode;

			if (nextKey is String) nextNode = _stringMap[nextKey];
			else nextNode = _items[nextKey];
			if (!nextNode) return false;
			
			var node : LinkedMapNode = add_private(key, item);
			if (!node) return false;

			addNodeBefore(nextNode, node);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAfter(previousKey : *, key : *, item : *) : Boolean {
			var previousNode : LinkedMapNode;

			if (previousKey is String) previousNode = _stringMap[previousKey];
			else previousNode = _items[previousKey];
			if (!previousNode) return false;
			
			var node : LinkedMapNode = add_private(key, item);

			if (!node) return false;

			addNodeAfter(previousNode, node);
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function get firstKey() : * {
			if (_first) return LinkedMapNode(_first).key;
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function get lastKey() : * {
			if (_last) return LinkedMapNode(_last).key;
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function nextKey(key : *) : * {
			var node : LinkedNode = getNode(key);
			if (node && node.right) return LinkedMapNode(node.right).key;
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function previousKey(key : *) : * {
			var node : LinkedNode = getNode(key);
			if (node && node.left) return LinkedMapNode(node.left).key;
			return undefined;
		}

		/*
		 * ILinkedCollection
		 */

		/**
		 * @inheritDoc
		 */
		override public function removeFirst() : * {
			if (!_size) return undefined;
			removeKey_private(LinkedMapNode(_first).key);
			return super.removeFirst();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeLast() : * {
			if (!_size) return undefined;
			removeKey_private(LinkedMapNode(_last).key);
			return super.removeLast();
		}

		/*
		 * IMap
		 */

		/**
		 * @inheritDoc
		 */
		public function add(key : *, item : *) : Boolean {
			var node : LinkedMapNode = add_private(key, item);
			if (node) {
				addNodeLast(node);
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function replaceFor(key : *, item : *) : Boolean {
			var node : LinkedMapNode;
			if (key is String) node = _stringMap[key];
			else node = _items[key];
			if (node && node.item !== item) {
				node.item = item;
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
			var node : LinkedMapNode;
			if (key is String) node = _stringMap[key];
			else node = _items[key];
			return node ? node.item : undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function keysToArray() : Array {
			var node : LinkedNode = _first;
			var keys : Array = new Array();
			while (node) {
				keys.push(LinkedMapNode(node).key);
				node = node.right;
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
			var node : LinkedNode;
			
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
			var node : LinkedMapNode;
			if (cursor is String) node = _stringMap[cursor];
			else node = _items[cursor];
			return new LinkedMapIterator(this, node);
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
		protected function getNode(key : *) : LinkedMapNode {
			if (key is String) return _stringMap[key];
			return _items[key];
		}

		/**
		 * @inheritDoc
		 */
		override protected function removeNode(node : LinkedNode) : void {
			super.removeNode(node);
			removeKey_private(LinkedMapNode(node).key);
		}

		/*
		 * Private
		 */

		/**
		 * Adds the given item to the internal map.
		 */
		private function add_private(key : *, item : *) : LinkedMapNode {
			var node : LinkedMapNode;
			
			if (key is String) {
				if (_stringMap[key] !== undefined) return null;
				node = new LinkedMapNode(key, item);
				_stringMap[key] = node;

			} else {
				if (_keys[key] !== undefined) return null;
				node = new LinkedMapNode(key, item);
				_keys[key] = key;
				_items[key] = node;
			}
			
			return node;
		}
		
		/**
		 * Removes the given key from the internal map.
		 */
		private function removeKey_private(key : *) : void {
			if (key is String) {
				delete _stringMap[key];

			} else {
				delete _keys[key];
				delete _items[key];
			}
		}

	}
}

import org.as3commons.collections.LinkedMap;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.core.as3commons_collections;

internal class KeyIterator implements IIterator {

	use namespace as3commons_collections;

	private var _next : LinkedNode;

	public function KeyIterator(map : LinkedMap) {
		_next = map.firstNode_internal;
	}

	public function hasNext() : Boolean{
		return _next != null;
	}

	public function next() : * {
		if (!_next) return undefined;
		var next : LinkedNode = _next;
		_next = _next.right;
		return LinkedMapNode(next).key;
	}	
}
