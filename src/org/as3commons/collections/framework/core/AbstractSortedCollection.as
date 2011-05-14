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
package org.as3commons.collections.framework.core {

	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISortOrder;
	import org.as3commons.collections.utils.NullComparator;

	/**
	 * Abstract sorted tree based collection implementation.
	 * 
	 * <p>This implementation is based on the treap data structure which is here modified to
	 * enable duplicate items wich includes multiple equal items.</p>
	 * 
	 * @author Jens Struwe 30.03.2010
	 */
	public class AbstractSortedCollection implements ISortOrder {

		use namespace as3commons_collections;

		/**
		 * The sort criterion.
		 */
		protected var _comparator : IComparator;

		/**
		 * The root node.
		 */
		protected var _root : SortedNode;

		/**
		 * The size of the collection.
		 */
		protected var _size : uint = 0;
		
		/**
		 * AbstractSortedCollection constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function AbstractSortedCollection(comparator : IComparator = null) {
			_comparator = comparator ? comparator : new NullComparator();
		}
		
		/*
		 * ISortedOrder
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
			var node : SortedNode = _root;
			
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) {
					node = node.left;
				} else if (compare == 1) {
					node = node.right;
				} else {
					return true;
				}
			}

			return false;
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
			var node : SortedNode = mostLeftNode_internal();
			if (!node) return undefined;
			removeNode(node);
			return node.item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeLast() : * {
			var node : SortedNode = mostRightNode_internal();
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
		public function get size() : uint {
			return _size;
		}

		/**
		 * @inheritDoc
		 */
		public function has(item : *) : Boolean {
			var node : SortedNode = firstEqualNode(item);
			if (!node) return false;
			
			if (node.item === item) return true;
			node = nextNode_internal(node);
			while (node) {
				if (_comparator.compare(item, node.item)) break;
				if (node.item === item) return true;
				node = nextNode_internal(node);
			}
			
			return false;
		}

		/**
		 * @inheritDoc
		 */
		public function toArray() : Array {
			var array : Array = new Array();

			var node : SortedNode = mostLeftNode_internal();
			
			while (node) {
				array.push(node.item);
				node = nextNode_internal(node);
			}

			return array;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(item : *) : Boolean {
			var node : SortedNode = firstEqualNode(item);
			if (!node) return false;
			
			if (node.item === item) {
				removeNode(node);
				return true;
			}
			node = nextNode_internal(node);
			while (node) {
				if (_comparator.compare(item, node.item)) break;
				if (node.item === item) {
					removeNode(node);
					return true;
				}
				node = nextNode_internal(node);
			}
			
			return false;
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

		/*
		 * IIterable
		 */

		/**
		 * @inheritDoc
		 */
		public function iterator(cursor : * = undefined) : IIterator {
			return null;
		}

		/*
		 * as3commons_collections
		 */

 		/**
		 * Framework internal method to retrieve the lowest node of the given subtree (node).
		 * 
		 * @param node The root node of the subtree.
		 * @return The lowest node or <code>null</code>, if the collection is empty.
		 */
		as3commons_collections function mostLeftNode_internal(node : SortedNode = null) : SortedNode {
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
		 * @return The highest node or <code>null</code>, if the collection is empty.
		 */
		as3commons_collections function mostRightNode_internal(node : SortedNode = null) : SortedNode {
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
		 * @return The next node or <code>null</code> if the node is the first item or the collection is empty.
		 */
		as3commons_collections function nextNode_internal(node : SortedNode) : SortedNode {
			if (node.right) {
				 node = mostLeftNode_internal(node.right);
			} else {
				var parent : SortedNode = node.parent;
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
		 * @return The previous node or <code>null</code> if the node is the last node or the collection is empty.
		 */
		as3commons_collections function previousNode_internal(node : SortedNode) : SortedNode {
			if (node.left) {
				 node = mostRightNode_internal(node.left);
			} else {
				var parent : SortedNode = node.parent;
				while (parent && node == parent.left) {
					node = parent;
					parent = parent.parent;
				}
				node = parent;
			}
			return node;
		}

		/**
		 * Framework internal method to remove a node from the collection.
		 * 
		 * @param node The node to remove.
		 */
		as3commons_collections function removeNode_internal(node : SortedNode) : void {
			removeNode(node);
		}

		/*
		 * Protected
		 */

		/**
		 * Adds an item to the tree.
		 * 
		 * <p>The method creates a new tree node, inserts the node as the leaf of
		 * its successor/predecessor and rotates then the node upwards until
		 * the tree becomes consistent again regarding the priority constraint.</p>
		 * 
		 * <p>If the tree is empty, the method simply creates a new root node.</p>
		 * 
		 * @param newNode The node to add.
		 */
		protected function addNode(newNode : SortedNode) : void {
			
			// add first node
			
			if (!_root) {
				_comparator.compare(newNode.item, newNode.item); // type check, should throw an error if not passed
				_root = newNode;
				_size++;
				return;
			}
			
			// add node to tree

			var node : SortedNode = _root;
			while (node) {
				var compare : int = _comparator.compare(newNode.item, node.item);
				if (!compare) compare = newNode.order < node.order ? -1 : 1;

				if (compare == -1) { // add item in left branch
					if (node.left) {
						node = node.left;
					} else {
						newNode.parent = node;
						node.left = newNode;
						node = node.left;
						break;
					}
				} else if (compare == 1) { // add item in right branch
					if (node.right) {
						node = node.right;
					} else {
						newNode.parent = node;
						node.right = newNode;
						node = node.right;
						break;
					}
				} else {
					// never reached
					return;
				}
			}
			
			// bubble up
			
			while (node.parent) {
				if (node.parent.priority >= node.priority) break;
				rotate(node.parent, node);
			}

			_size++;
		}
		
		/**
		 * Removes a node from the tree.
		 * 
		 * <p>The method rotates the given node downwards until it becomes a leaf node
		 * and gets removed from the tree.</p>
		 * 
		 * @param node The node to remove.
		 */
		protected function removeNode(node : SortedNode) : void {
			// bubble down

			var child : SortedNode;
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
		protected function rotate(parent : SortedNode, child : SortedNode) : void {
			var grandparent : SortedNode = parent.parent;

			var right : String = "right"; // rotate with right child
			var left : String = "left";
			if (child == parent.left) { // rotate with left child
				right = "left";
				left = "right";
			}

			// set left of child to be the new right of parent
			parent[right] = child[left];
			if (child[left]) SortedNode(child[left]).parent = parent;

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
		 * Returns the first node whose item equals the given item.
		 * 
		 * @param item The item to test.
		 * @return The first equal node or <code>undefined</code> if there is no equal item contained.
		 */
		protected function firstEqualNode(item : *) : SortedNode {
			var node : SortedNode = _root;
			var firstEqual : SortedNode;
			
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) { // item lesser than node
					if (firstEqual) return firstEqual;
					node = node.left;

				} else if (compare == 1) { // item greater than node
					node = node.right;

				} else { // item equals node
					firstEqual = node;
					node = node.left;
				}
			}

			return firstEqual;
		}
		
		/**
		 * Returns the last node whose item is lesser than the given item.
		 * 
		 * @param item The item to test.
		 * @return The last lesser node or <code>null</code> if there is no lesser item.
		 */
		protected function lesserNode(item : *) : SortedNode {
			var node : SortedNode = _root;
			var lesser : SortedNode;
			
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
		protected function higherNode(item : *) : SortedNode {
			var node : SortedNode = _root;
			var higher : SortedNode;
			
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
