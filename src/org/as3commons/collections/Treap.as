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
	import org.as3commons.collections.utils.NullComparator;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IBinarySearchTree;
	import org.as3commons.collections.framework.core.TreapIterator;
	import org.as3commons.collections.framework.core.TreapNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Treap data structure implementation.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A treap is a randomised binary search tree where degeneration can be minimised
	 * by assigning a random priority value to each tree node. A treap is comparatively
	 * easy to implement and is at the same time highly performant. <i>"To summarize, in
	 * the mixed workload environment, the treap data structure outperformed the other 4
	 * implementations by a rather significant margin."</i> [1] The implementation of
	 * this class is taken from a Java template. [2]</p>
	 * 
	 * <p>The differences between <code>SortedSet</code> and <code>Treap</code> are:</p>
	 * 
	 * <ul>
	 * <li>The set maintains an internal dictionary of item-node entries to enable constant
	 * time item access.</li>
	 * <li>The set implements a modified form of the treap which can host duplicates and
	 * multiple equal items. The treap does not allow multiple equal items (and therefore
	 * duplicates).</li>
	 * </ul>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Getting or removing of items at start or at end - constant runtime O(1).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Adding an removing of items - logarithmic runtime O(log n).<br />
	 * add(), remove()</code></li>
	 * <li>Inspection operations - logarithmic runtime O(log n).<br />
	 * has(), lesser(), higher(), equalItems()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts an item as the cursor parameter. If the given
	 * item is not contained by the treap, it will be ignored.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>ISortedSetIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed if the comparator allows <code>null</code>.</p>
	 * 
	 * <p id="link_TreapExample"><strong>Treap example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>Treap</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: TreapExample}}
	 * 
	 * <p id="link_ArrayListExample"><strong>ArrayList example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListExample}}
	 * 
	 * <p id="link_ArrayListIteratorExample"><strong>ArrayListIterator example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListIteratorExample}}
	 * 
	 * @author Jens Struwe 18.03.2009
	 * @see org.as3commons.collections.framework.IBinarySearchTree IBinarySearchTree interface - Detailed description of the binary search tree features.
	 * @see org.as3commons.collections.framework.IBinarySearchTreeIterator IBinarySearchTreeIterator interface - Detailed description of the binary search tree iterator features.
	 * @see http://www.upgrade-cepis.org/issues/2004/5/up5-5Mosaic.pdf [1] Binary search tree performance comparision.
	 * @see http://users.cs.fiu.edu/~weiss/dsaajava/code/DataStructures/ [2] The borrowed Java implementation of a treap.
	 */
	public class Treap implements IBinarySearchTree {
		
		use namespace as3commons_collections;

		/**
		 * The sort criterion.
		 */
		protected var _comparator : IComparator;

		/**
		 * The root node.
		 */
		protected var _root : TreapNode;

		/**
		 * The size of the treap.
		 */
		protected var _size : uint = 0;
		
		/**
		 * Treap constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function Treap(comparator : IComparator = null) {
			_comparator = comparator ? comparator : new NullComparator();
		}
		
		/*
		 * ISortOrder
		 */

		/**
		 * @inheritDoc
		 */
		public function set comparator(comparator : IComparator) : void {
			if (_size) throw new ArgumentError("You cannot set a comparator to a collection with size > 0");
			_comparator = comparator;
		}

		/**
		 * @inheritDoc
		 */
		public function get comparator() : IComparator {
			return _comparator;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEqual(item : *) : Boolean {
			var node : TreapNode = getNode(item);
			return node ? true : false;
		}
		
		/*
		 * IBinarySearchTree
		 */

		/**
		 * @inheritDoc
		 */
		public function add(item : *) : Boolean {
			return add_protected(item) !== null;
		}

		/**
		 * @inheritDoc
		 */
		public function lesser(item : *) : * {
			var node : TreapNode = lesserNode(item);
			if (!node) return undefined;
			return node.item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function higher(item : *) : * {
			var node : TreapNode = higherNode(item);
			if (!node) return undefined;
			return node.item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function equalItem(item : *) : * {
			var node : TreapNode = getNode(item);
			return node ? node.item : undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function get first() : * {
			if (!_root) return undefined;
			return mostLeftNode_internal().item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get last() : * {
			if (!_root) return undefined;
			return mostRightNode_internal().item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeFirst() : * {
			var node : TreapNode = mostLeftNode_internal();
			if (!node) return undefined;
			removeNode(node);
			return node.item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeLast() : * {
			var node : TreapNode = mostRightNode_internal();
			if (!node) return undefined;
			removeNode(node);
			return node.item;
		}

		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		public function has(item : *) : Boolean {
			var node : TreapNode = getNode(item);
			return node && node.item === item ? true : false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(item : *) : Boolean {
			var node : TreapNode = getNode(item);
			if (!node || node.item !== item) return false;
			removeNode(node);
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function clear() : Boolean {
			if (!_size) return false;
			_root = null;
			_size = 0;
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function toArray() : Array {
			var array : Array = new Array();
			var iterator : IIterator = iterator();
			while (iterator.hasNext()) {
				array.push(iterator.next());
			}
			return array;
		}

		/**
		 * @inheritDoc
		 */
		public function get size() : uint {
			return _size;
		}
		
		/*
		 * IIterable
		 */
		
		/**
		 * @inheritDoc
		 */
		public function iterator(cursor : * = undefined) : IIterator {
			var node : TreapNode = mostLeftNode_internal();
			if (cursor) {
				var i : uint = 0;
				while (node && i < cursor) {
					node = nextNode_internal(node);
					i++;
				}
			}
			return new TreapIterator(this, node);
		}

		/*
		 * as3commons_collections
		 */

 		/**
		 * Framework internal method to retrieve the lowest node of the given subtree (node).
		 * 
		 * @param node The root node of the subtree.
		 * @return The lowest node or <code>null</code>, if the treap is empty.
		 */
		as3commons_collections function mostLeftNode_internal(node : TreapNode = null) : TreapNode {
			if (!_root) return null;
			if (!node) node = _root;
			while (node.left) {
				node = node.left;
			}
			return node;
		}
		
		/**
		 * Framework internal method to retrieve the highest node of the given subtree (node).
		 * 
		 * @param node The root node of the subtree.
		 * @return The highest node or <code>null</code>, if the treap is empty.
		 */
		as3commons_collections function mostRightNode_internal(node : TreapNode = null) : TreapNode {
			if (!_root) return null;
			if (!node) node = _root;
			while (node.right) {
				node = node.right;
			}
			return node;
		}

		/**
		 * Framework internal method to retrieve the successor of a given node.
		 * 
		 * @param node The node to get the successor.
		 * @return The next node or <code>null</code> if the node is the first item or the treap is empty.
		 */
		as3commons_collections function nextNode_internal(node : TreapNode) : TreapNode {
			if (node.right) {
				 node = mostLeftNode_internal(node.right);
			} else {
				var parent : TreapNode = node.parent;
				while (parent && node == parent.right) {
					node = parent;
					parent = parent.parent;
				}
				node = parent;
			}
			return node;
		}
	
		/**
		 * Framework internal method to retrieve the predecessor of a given node.
		 * 
		 * @param node The node to get the predecessor.
		 * @return The previous node or <code>null</code> if the node is the last node or the treap is empty.
		 */
		as3commons_collections function previousNode_internal(node : TreapNode) : TreapNode {
			if (node.left) {
				 node = mostRightNode_internal(node.left);
			} else {
				var parent : TreapNode = node.parent;
				while (parent && node == parent.left) {
					node = parent;
					parent = parent.parent;
				}
				node = parent;
			}
			return node;
		}

		/**
		 * Framework internal method to remove a node from the treap.
		 * 
		 * @param node The node to remove.
		 */
		as3commons_collections function removeNode_internal(node : TreapNode) : void {
			removeNode(node);
		}

		/*
		 * Protected
		 */

		/**
		 * Adds an item to the treap.
		 * 
		 * <p>The method creates a new treap node, inserts the node as the leaf of
		 * its successor/predecessor and rotates then the node upwards until
		 * the tree becomes consistent again regarding the priority constraint.</p>
		 * 
		 * <p>If the treap is empty, the method simply creates a new root node.</p>
		 * 
		 * @param item The data to insert into the tree.
		 * @return true, if the item has been inserted, false if an equal item already exists.
		 * @throws as3.collections.core.UnsupportedTypeException If the item cannot be compared.
		 */
		protected function add_protected(item : *) : TreapNode {
			
			// add first node
			
			if (!_root) {
				_comparator.compare(item, item); // type check, should throw an error if not passed
				_root = new TreapNode(item, null);
				_size++;
				return _root;
			}
			
			// add node to tree

			var node : TreapNode = _root;
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) { // add item in left branch
					if (node.left) {
						node = node.left;
						continue;
					} else {
						node.left = new TreapNode(item, node);
						node = node.left;
						break;
					}
				} else if (compare == 1) { // add item in right branch
					if (node.right) {
						node = node.right;
						continue;
					} else {
						node.right = new TreapNode(item, node);
						node = node.right;
						break;
					}
				} else { // add an item for an existing equality not permitted
					return null;
				}
			}
			
			// bubble up
			
			while (node.parent) {
				if (node.parent.priority >= node.priority) break;
				rotate(node.parent, node);
			}

			_size++;
			return node;
		}
		
		/**
		 * Removes a node from the tree.
		 * 
		 * <p>The method rotates the given node downwards until it becomes a leaf node
		 * and gets removed from the tree.</p>
		 * 
		 * @param node The node to remove.
		 */
		protected function removeNode(node : TreapNode) : void {
			// bubble down

			var child : TreapNode;
			while (node.left || node.right) {
				if (node.left && node.right) child = node.left.priority < node.right.priority ? node.left : node.right;
				else if (node.left) child = node.left;
				else if (node.right) child = node.right;
				else break;
				rotate(node, child);
			}
			
			// remove node from tree

			if (node.parent) {
				if (node.parent.left == node) {
					node.parent.left = null;
				} else {
					node.parent.right = null;
				}
				node.parent = null;
			} else {
				_root = null;
			}
			
			_size--;
		}
		
		/**
		 * Rotates a parent with its child node.
		 * 
		 * @param parent The parent node.
		 * @param child The child node.
		 */
		protected function rotate(parent : TreapNode, child : TreapNode) : void {
			var grandparent : TreapNode = parent.parent;

			var right : String = "right"; // rotate with right child
			var left : String = "left";
			if (child == parent.left) { // rotate with left child
				right = "left";
				left = "right";
			}

			// set left of child to be the new right of parent
			parent[right] = child[left];
			if (child[left]) TreapNode(child[left]).parent = parent;

			// set child as the new parent
			parent.parent = child;
			child[left] = parent;

			// link grandparent to the child
			child.parent = grandparent;
			if (grandparent) {
				if (grandparent[left] == parent) {
					grandparent[left] = child;
				} else {
					grandparent[right] = child;
				}
			} else {
				_root = child;
			}
		}

		/**
		 * Returns the node of the given item.
		 * 
		 * @param item The item to get the node for.
		 * @return The node or <code>null</code>, if the item is not contained.
		 */
		protected function getNode(item : *) : TreapNode {
			var node : TreapNode = _root;
			
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) {
					node = node.left;
				} else if (compare == 1) {
					node = node.right;
				} else {
					return node;
				}
			}

			return null;
		}
		
		/**
		 * Returns the last node whose item is lesser than the given item.
		 * 
		 * @param item The item to test.
		 * @return The last lesser node or <code>null</code> if there is no lesser item.
		 */
		protected function lesserNode(item : *) : TreapNode {
			var node : TreapNode = _root;
			var lesser : TreapNode;
			
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) {
					node = node.left;
				} else if (compare == 1) {
					lesser = node;
					node = node.right;
				} else {
					node = node.left;
				}
			}

			return lesser;
		}

		/**
		 * Returns the first node whose item is higher than the given item.
		 * 
		 * @param item The item to test.
		 * @return The next higher node or <code>null</code> if there is no higher item.
		 */
		protected function higherNode(item : *) : TreapNode {
			var node : TreapNode = _root;
			var higher : TreapNode;
			
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) {
					higher = node;
					node = node.left;
				} else if (compare == 1) {
					node = node.right;
				} else {
					node = node.right;
				}
			}

			return higher;
		}

	}
}
