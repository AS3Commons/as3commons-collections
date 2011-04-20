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
	import org.as3commons.collections.Treap;
	import org.as3commons.collections.framework.IBinarySearchTreeIterator;
	import org.as3commons.collections.framework.core.TreapNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Internal <code>Treap</code> iterator implementation.
	 * 
	 * @author Jens Struwe 30.03.2010
	 */
	public class TreapIterator implements IBinarySearchTreeIterator {

		use namespace as3commons_collections;

		/**
		 * The list to enumerate.
		 */
		protected var _treap : Treap;

		/**
		 * The cursor position.
		 * 
		 * <p>The cursor is positioned before the item stored in the <code>_next</code>
		 * property. If the collection is empty or the cursor is placed at
		 * end, <code>_next</code> has the value <code>null</code>.</p>
		 */
		protected var _next : TreapNode;

		/**
		 * The node of the last returned item.
		 * 
		 * <p>Initially this property is <code>null</code> (no item returned yet).</p>
		 * 
		 * <p><code>start(), end(), addBefore(), addAfter()</code> and <code>remove()</code>
		 * set this property to <code>null</code>.</p>
		 */
		protected var _current : TreapNode;
		
		/**
		 * TreapIterator constructor.
		 * 
		 * <p>If <code>next</code> is specified, the iterator returns the item of that
		 * node with the first call to <code>next()</code> and its predecessor
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param collection The sorted collection.
		 * @param next The node to start the iteration with.
		 */
		public function TreapIterator(treap : Treap, next : TreapNode) {
			_treap = treap;
			
			if (next) _next = next;
			else if (treap.size) _next = _treap.mostLeftNode_internal();
		}
		
		/*
		 * ITreapIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function get previousItem() : * {
			if (_next) {
				var previous : TreapNode = _treap.previousNode_internal(_next);
				return previous ? previous.item : undefined;
			} else {
				return _treap.size ? _treap.mostRightNode_internal().item : undefined;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextItem() : * {
			return _next ? _next.item : undefined;
		}

		/*
		 * ICollectionIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function start() : void {
			_next = _treap.size ? _treap.mostLeftNode_internal() : null;
			_current = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function end() : void {
			_next = _current = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasPrevious() : Boolean {
			return _next != _treap.mostLeftNode_internal() && _treap.size;
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous() : * {
			if (_next == _treap.mostLeftNode_internal() || !_treap.size) {
				_current = null;
				return undefined;
			}

			_next = _next == null ? _treap.mostRightNode_internal() : _treap.previousNode_internal(_next);
			_current = _next;

			return _current ? _current.item : undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get current() : * {
			return _current ? _current.item : undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function remove() : Boolean {
			if (!_current) return false;
			
			_next = _treap.nextNode_internal(_current);
			_treap.removeNode_internal(_current);
			_current = null;
			return true;
		}
		
		/*
		 * IIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function hasNext() : Boolean {
			return _next != null;
		}

		/**
		 * @inheritDoc
		 */
		public function next() : * {
			if (!_next) {
				_current = null;
				return undefined;
			}
			
			_current = _next;
			_next = _treap.nextNode_internal(_next);

			return _current ? _current.item : undefined;
		}
		
	}
}
