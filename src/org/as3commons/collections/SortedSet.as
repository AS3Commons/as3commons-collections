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
	import org.as3commons.collections.framework.ISortedSet;
	import org.as3commons.collections.framework.core.AbstractSortedCollection;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.SortedSetIterator;
	import org.as3commons.collections.framework.core.as3commons_collections;

	import flash.utils.Dictionary;

	/**
	 * Sort order implementation of a set.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>SortedSet</code> is a combination of a dictionary and a linked list.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Getting or removing of items - constant runtime O(1).<br />
	 * <code>add(), first, last, remove(), removeFirst(), removeLast()</code></li>
	 * <li>Item lookup inspection operations - constant runtime O(1).<br />
	 * has(), lesser(), higher(), equalItems()</code></li>
	 * <li>Adding of items - logarithmic runtime O(log n).<br />
	 * add()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts an item as the cursor parameter. If the given
	 * item is not contained by the set, it will be ignored.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>ISetIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed if the comparator allows <code>null</code>.</p>
	 * 
	 * <p id="link_SortedSetExample"><strong>SortedSet example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>SortedSet</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>Set</code> and <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: SortedSetExample}}
	 * 
	 * <p id="link_SetExample"><strong>Set example</strong></p>
	 * 
	 * {{EXAMPLE: SetExample}}
	 * 
	 * <p id="link_ArrayListExample"><strong>ArrayList example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListExample}}
	 * 
	 * <p id="link_ArrayListIteratorExample"><strong>ArrayListIterator example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListIteratorExample}}
	 * 
	 * @author Jens Struwe 24.03.2010
	 * @see org.as3commons.collections.framework.ISortedSet ISortedSet interface - Detailed description of the sorted set features.
	 * @see org.as3commons.collections.framework.ISetIterator ISetIterator interface - Detailed description of the set iterator features.
	 * @see org.as3commons.collections.framework.ISet ISet interface - Detailed description of the base set features.
	 */
	public class SortedSet extends AbstractSortedCollection implements ISortedSet {
		
		use namespace as3commons_collections;

		/**
		 * The non string items.
		 */
		private var _items : Dictionary;

		/**
		 * The string items.
		 */
		private var _stringItems : Object;
		
		/**
		 * SortedSet constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function SortedSet(comparator : IComparator = null) {
			super(comparator);

			_items = new Dictionary();
			_stringItems = new Object();
		}
		
		/*
		 * ISortedSet
		 */

		/**
		 * @inheritDoc
		 */
		public function next(item : *) : * {
			var node : SortedNode = getNode(item);
			if (node) {
				node = nextNode_internal(node);
				if (node) return node.item;
			}
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function previous(item : *) : * {
			var node : SortedNode = getNode(item);
			if (node) {
				node = previousNode_internal(node);
				if (node) return node.item;
			}
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function lesser(item : *) : * {
			var node : SortedNode = lesserNode(item);
			if (!node) return undefined;
			return node.item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function higher(item : *) : * {
			var node : SortedNode = higherNode(item);
			if (!node) return undefined;
			return node.item;
		}

		/**
		 * @inheritDoc
		 */
		public function equalItems(item : *) : Array {
			var equalItems : Array = new Array();
			var node : SortedNode = firstEqualNode(item);
			if (!node) return equalItems;
			
			while (node) {
				if (_comparator.compare(item, node.item)) break;
				equalItems.push(node.item);
				node = nextNode_internal(node);
			}
			
			return equalItems;
		}

		/*
		 * ISet
		 */

		/**
		 * @inheritDoc
		 */
		public function add(item : *) : Boolean {
			var node : SortedNode;
			
			if (item is String) {
				if (_stringItems[item] !== undefined) return false;
				node = new SortedNode(item);
				addNode(node);
				_stringItems[item] = node;

			} else {
				if (_items[item] !== undefined) return false;
				node = new SortedNode(item);
				addNode(node);
				_items[item] = node;
			}
			return true;
		}
		
		/*
		 * ICollection
		 */
		
		/**
		 * @inheritDoc
		 */
		override public function has(item : *) : Boolean {
			if (item is String) return _stringItems[item] !== undefined;
			return _items[item] !== undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function remove(item : *) : Boolean {
			var node : SortedNode;
			
			if (item is String) {
				node = _stringItems[item];
				if (!node) return false;

			} else {
				node = _items[item];
				if (!node) return false;
			}
			
			removeNode(node);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clear() : Boolean {
			if (!_size) return false;

			_items = new Dictionary();
			_stringItems = new Object();
			
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
			var node : SortedNode;
			if (cursor is String) node = _stringItems[cursor];
			else node = _items[cursor];
			return new SortedSetIterator(this, node);
		}

		/*
		 * Protected
		 */
		
		/**
		 * Returns the node of the given item.
		 * 
		 * @param item The item to get the node for.
		 * @return The node or <code>null</code> if the item is not contained.
		 */
		protected function getNode(item : *) : SortedNode {
			if (item is String) return _stringItems[item];
			return _items[item];
		}

		/**
		 * @inheritDoc
		 */
		override protected function removeNode(node : SortedNode) : void {
			super.removeNode(node);

			if (node.item is String) {
				delete _stringItems[node.item];

			} else {
				delete _items[node.item];
			}
		}

	}
}
