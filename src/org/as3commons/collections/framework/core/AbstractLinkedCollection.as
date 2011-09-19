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
	import org.as3commons.collections.framework.IInsertionOrder;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Abstract linked list based collection implementation.
	 * 
	 * @author Jens Struwe 04.03.2010
	 */
	public class AbstractLinkedCollection implements IInsertionOrder {

		/**
		 * The first node.
		 */
		protected var _first : LinkedNode;

		/**
		 * The last node.
		 */
		protected var _last : LinkedNode;

		/**
		 * The size of the list.
		 */
		protected var _size : uint = 0;

		/**
		 * AbstractLinkedCollection constructor.
		 */
		public function AbstractLinkedCollection() {
		}

		/**
		 * @inheritDoc
		 */
		public function reverse() : Boolean {
			if (_size < 2) return false;
			
			var node : LinkedNode = _last;
			var left : LinkedNode;
			var right : LinkedNode;

			while (node) {
				left = node.left;
				if (!node.right) {
					node.right = node.left;
					node.left = null;
					_first = node;
				} else if (!node.left) {
					node.left = node.right;
					node.right = null;
					_last = node;
				} else {
					right = node.right;
					node.right = node.left;
					node.left = right;
				}
				node = left;
			}

			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort(comparator : IComparator) : Boolean {
			if (_size < 2) return false;
			mergeSort(comparator);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get first() : * {
			if (_first) return _first.item;
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get last() : * {
			if (_last) return _last.item;
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeFirst() : * {
			if (!_size) return undefined;
			
			var item : * = _first.item;

			_first = _first.right;
			if (_first) _first.left = null;
			else _last = null;
			_size--;

			return item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeLast() : * {
			if (!_size) return undefined;
			
			var item : * = _last.item;

			_last = _last.left;
			if (_last) _last.right = null;
			else _first = null;
			_size--;

			return item;
		}

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
			return firstNodeOf(item) != null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toArray() : Array {
			var node : LinkedNode = _first;
			var array : Array = new Array();
			while (node) {
				array.push(node.item);
				node = node.right;
			}
			return array;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(item : *) : Boolean {
			var node : LinkedNode = firstNodeOf(item);
			if (!node) return false; 
			removeNode(node);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear() : Boolean {
			if (!_size) return false;
			_first = _last = null;
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
		 * Framework internal getter to retrieve the start node of the list. 
		 */
		as3commons_collections function get firstNode_internal() : LinkedNode {
			return _first;
		}
		
		/**
		 * Framework internal getter to retrieve the last node of the list. 
		 */
		as3commons_collections function get lastNode_internal() : LinkedNode {
			return _last;
		}

		/*
		 * Protected
		 */
		
		/**
		 * Inserts a new node before an existing node.
		 * 
		 * <p>For convenience, the <code>next</code> may be null, which appends the node
		 * to the list.</p>
		 * 
		 * @param right The existing node.
		 * @param node The node to be added before.
		 */
		protected function addNodeBefore(next : LinkedNode, node : LinkedNode) : void {
			if (!next) {
				addNodeLast(node);
				return;
			}
			
			if (!next.left) _first = node; // has been the first

			// link new node
			node.left = next.left;
			node.right = next;
			// update predecessor
			if (next.left) next.left.right = node;
			// link as successor
			next.left = node;

			_size++;
		}

		/**
		 * Inserts a new node after an existing node.
		 * 
		 * <p>For convenience, the <code>next</code> may be null, which adds the node
		 * at begin of the list.</p>
		 * 
		 * @param left The existing node.
		 * @param node The new node to be added after.
		 */
		protected function addNodeAfter(previous : LinkedNode, node : LinkedNode) : void {
			if (!previous) {
				addNodeFirst(node);
				return;
			}

			if (!previous.right) _last = node; // has been the last

			// link new node
			node.left = previous;
			node.right = previous.right;
			// update successor
			if (previous.right) previous.right.left = node;
			// link as predecessor
			previous.right = node;

			_size++;
		}

		/**
		 * Retrieves the first node containing the specified item.
		 * 
		 * @param item The item to get its node.
		 * @return The node or <code>undefined</code> if the item is not contained.
		 */
		protected function firstNodeOf(item : *) : LinkedNode {
			var node : LinkedNode = _first;
			while (node) {
				if (item === node.item) return node;
				node = node.right;
			}
			return null;
		}

		/**
		 * Inserts a new node at the begin of the list.
		 * 
		 * @param node The node to add at start.
		 */
		protected function addNodeFirst(node : LinkedNode) : void {
			if (!_first) {
				_first = _last = node;
				_size = 1;
				return;
			}
			_first.left = node;
			node.right = _first;
			_first = node;
			_size++;
		}

		/**
		 * Inserts a new node at the end of the list.
		 * 
		 * @param node The node to add at end.
		 */
		protected function addNodeLast(node : LinkedNode) : void {
			if (!_first) {
				_first = _last = node;
				_size = 1;
				return;
			}
			
			_last.right = node;
			node.left = _last;
			_last = node;
			_size++;
		}

		/**
		 * Unlinks a node and connects predecessor with successor.
		 * 
		 * @param node The node to remove
		 */
		protected function removeNode(node : LinkedNode) : void {
			// unlink node 
			if (node.left) {
				node.left.right = node.right;
			} else {
				_first = node.right; // has been the first
			}

			if (node.right) {
				node.right.left = node.left;
			} else {
				_last = node.left; // has been the last
			}
			
			_size--;
		}
		
		/**
		 * Merge sort algorithm.
		 * 
		 * <p>The algorithm has been implemented by Michael Baczynski,
		 * http://lab.polygonal.de/ds/ and is unmodified taken from there.</p>
		 * 
		 * @param comparator The sort criterion.
		 */
		protected function mergeSort(comparator : IComparator) : void {
			var h : LinkedNode = _first;
			var p : LinkedNode, q : LinkedNode, e : LinkedNode, tail : LinkedNode;
			var insize : int = 1, nmerges : int, psize : int, qsize : int, i : int;

			while (true) {
				p = h;
				h = tail = null;
				nmerges = 0;
				
				while (p) {
					nmerges++;
					for (i = 0, psize = 0, q = p; i < insize; i++) {
						psize++;
						q = q.right;
						if (!q) break;
					}
					qsize = insize;

					while (psize > 0 || (qsize > 0 && q)) {
						if (psize == 0) {
							e = q; q = q.right; qsize--;
						} else if (qsize == 0 || !q) {
							e = p; p = p.right; psize--;
						} else if (comparator.compare(p.item, q.item) <= 0) {
							e = p; p = p.right; psize--;
						} else {
							e = q; q = q.right; qsize--;
						}
						
						if (tail) tail.right = e;
						else h = e;
						
						e.left = tail;
						tail = e;
					}
					p = q;
				}
				
				tail.right = null;
				if (nmerges <= 1) {
					break;
				}
				insize <<= 1;
			}

			_first = h;
			_last = tail;
		}
		
		/**
		 * Insertion sort algorithm.
		 * 
		 * <p>The algorithm has been implemented by Michael Baczynski,
		 * http://lab.polygonal.de/ds/ and is modified taken from there.</p>
		 * 
		private function insertionSort(comparator : IComparator) : void {
			if (!_first) return;
			
			var current : LinkedNode;
			var left : LinkedNode;
			var right : LinkedNode;
			var i : LinkedNode;

			current = _first.right;
			while (current) {
				right = current.right;
				left = current.left;
				
				if (comparator.compare(left.item, current.item) == 1) {
					i = left;
					
					while (i.left) {
						if (comparator.compare(i.left.item, current.item) == 1) {
							i = i.left;
						} else {
							break;
						}
					}

					if (right) {
						left.right = right;
						right.left = left;
					} else {
						left.right = null;
					}
					
					if (i == _first) {
						current.left = null;
						current.right = i;
						
						i.left = current;
						_first = current;
					} else {
						current.left = i.left;
						i.left.right = current;
						
						current.right = i;
						i.left = current;
					}
				}
				current = right;
			}

		}
		 */

	}
}
