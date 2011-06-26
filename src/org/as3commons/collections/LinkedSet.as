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
	import org.as3commons.collections.framework.IOrderedSet;
	import org.as3commons.collections.framework.core.AbstractLinkedCollection;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.LinkedSetIterator;

	import flash.utils.Dictionary;

	/**
	 * Insertion order implementation of a set.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>LinkedSet</code> is a combination of a dictionary and a linked list.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Adding, getting or removing of items - constant runtime O(1).<br />
	 * <code>add(), addFirst(), addLast(), first, last, removeFirst(), removeLast()</code></li>
	 * <li>Item lookup operations - constant runtime O(1).<br />
	 * addBefore(), addAfter(), has(), count(), replace(), remove()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts an item as the cursor parameter. If the given
	 * item is not contained by the set, it will be ignored.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>IOrderedSetIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed.</p>
	 * 
	 * <p id="link_LinkedSetExample"><strong>LinkedSet example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>LinkedSet</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>Set</code> and <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: LinkedSetExample}}
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
	 * @author Jens Struwe 25.03.2010
	 * @see org.as3commons.collections.framework.IOrderedSet IOrderedSet interface - Detailed description of the ordered set features.
	 * @see org.as3commons.collections.framework.IOrderedSetIterator IOrderedSetIterator interface - Detailed description of the ordered set iterator features.
	 * @see org.as3commons.collections.framework.ISet ISet interface - Detailed description of the base set features.
	 */
	public class LinkedSet extends AbstractLinkedCollection implements IOrderedSet {
		
		/**
		 * The non string items.
		 */
		private var _items : Dictionary;

		/**
		 * The string items.
		 */
		private var _stringItems : Object;
		
		/**
		 * LinkedSet constructor.
		 */
		public function LinkedSet() {
			_items = new Dictionary();
			_stringItems = new Object();
		}
		
		/*
		 * IOrderedSet
		 */

		/**
		 * @inheritDoc
		 */
		public function addFirst(item : *) : Boolean {
			var node : LinkedNode = add_private(item);
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
		public function addLast(item : *) : Boolean {
			var node : LinkedNode = add_private(item);
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
		public function addBefore(nextItem : *, item : *) : Boolean {
			var nextNode : LinkedNode;

			if (nextItem is String) nextNode = _stringItems[nextItem];
			else nextNode = _items[nextItem];
			if (!nextNode) return false;
			
			var node : LinkedNode = add_private(item);
			if (!node) return false;

			addNodeBefore(nextNode, node);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAfter(previousItem : *, item : *) : Boolean {
			var previousNode : LinkedNode;

			if (previousItem is String) previousNode = _stringItems[previousItem];
			else previousNode = _items[previousItem];
			if (!previousNode) return false;

			var node : LinkedNode = add_private(item);
			if (!node) return false;

			addNodeAfter(previousNode, node);
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function replace(oldItem: *, item : *) : Boolean {
			// test new item if it is already contained
			if (item is String && _stringItems[item] !== undefined) return false;
			else if (_items[item] !== undefined) return false;

			// test old item if it is contained
			var node : LinkedNode;
			if (oldItem is String) {
				if (_stringItems[oldItem] !== undefined) {
					node = _stringItems[oldItem];
					node.item = item;
					_stringItems[item] = node;
					delete _stringItems[oldItem];
					return true;
				}
			} else {
				if (_items[oldItem] !== undefined) {
					node = _items[oldItem];
					node.item = item;
					_items[item] = node;
					delete _items[oldItem];
					return true;
				}
			}

			return false;
		}

		/**
		 * @inheritDoc
		 */
		public function next(item : *) : * {
			var node : LinkedNode = getNode(item);
			if (node && node.right) return node.right.item;
			return undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function previous(item : *) : * {
			var node : LinkedNode = getNode(item);
			if (node && node.left) return node.left.item;
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
			remove_private(_first.item);
			return super.removeFirst();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeLast() : * {
			if (!_size) return undefined;
			remove_private(_last.item);
			return super.removeLast();
		}

		/*
		 * ISet
		 */

		/**
		 * @inheritDoc
		 */
		public function add(item : *) : Boolean {
			var node : LinkedNode = add_private(item);
			if (node) {
				addNodeLast(node);
				return true;
			} else {
				return false;
			}
		}
		
		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		override public function has(item : *) : Boolean {
			return item is String ? _stringItems[item] !== undefined : _items[item] !== undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function remove(item : *) : Boolean {
			var node : LinkedNode;
			
			if (item is String) {
				if (_stringItems[item] === undefined) return false;
				node = _stringItems[item];

			} else {
				if (_items[item] === undefined) return false;
				node = _items[item];
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
			var node : LinkedNode;
			if (cursor is String) node = _stringItems[cursor];
			else node = _items[cursor];
			return new LinkedSetIterator(this, node);
		}

		/*
		 * Protected
		 */

		/**
		 * @inheritDoc
		 */
		override protected function removeNode(node : LinkedNode) : void {
			remove_private(node.item);
			super.removeNode(node);
		}
		
		/**
		 * Returns the node of the given item.
		 * 
		 * @param item The item to get the node for.
		 * @return The node or <code>null</code> if the item is not contained.
		 */
		protected function getNode(item : *) : LinkedNode {
			if (item is String) return _stringItems[item];
			return _items[item];
		}

		/*
		 * Private
		 */

		/**
		 * Adds the given item to the internal map.
		 */
		private function add_private(item : *) : LinkedNode {
			var node : LinkedNode;
			
			if (item is String) {
				if (_stringItems[item] !== undefined) return null;
				node = new LinkedNode(item);
				_stringItems[item] = node;

			} else {
				if (_items[item] !== undefined) return null;
				node = new LinkedNode(item);
				_items[item] = node;
			}
			
			return node;
		}
		
		/**
		 * Removes the given item from the internal map.
		 */
		private function remove_private(item : *) : void {
			if (item is String) delete _stringItems[item];
			else delete _items[item];
		}
	}
}
