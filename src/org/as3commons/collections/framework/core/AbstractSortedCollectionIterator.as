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
	import org.as3commons.collections.framework.ICollectionIterator;

	/**
	 * Abstract sorted tree based collection iterator implementation.
	 * 
	 * @author Jens Struwe 30.03.2010
	 */
	public class AbstractSortedCollectionIterator implements ICollectionIterator {

		use namespace as3commons_collections;

		/**
		 * The list to enumerate.
		 */
		protected var _collection : AbstractSortedCollection;

		/**
		 * The cursor position.
		 * 
		 * <p>The cursor is positioned before the item stored in the <code>_next</code>
		 * property. If the collection is empty or the cursor is placed at
		 * end, <code>_next</code> has the value <code>null</code>.</p>
		 */
		protected var _next : SortedNode;

		/**
		 * The node of the last returned item.
		 * 
		 * <p>Initially this property is <code>null</code> (no item returned yet).</p>
		 * 
		 * <p><code>start(), end(), addBefore(), addAfter()</code> and <code>remove()</code>
		 * set this property to <code>null</code>.</p>
		 */
		protected var _current : SortedNode;
		
		/**
		 * AbstractSortedCollectionIterator constructor.
		 * 
		 * <p>If <code>next</code> is specified, the iterator returns the item of that
		 * node with the first call to <code>next()</code> and its predecessor
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param collection The sorted collection.
		 * @param next The node to start the iteration with.
		 */
		public function AbstractSortedCollectionIterator(collection : AbstractSortedCollection, next : SortedNode = null) {
			_collection = collection;
			
			if (next) _next = next;
			else if (collection.size) _next = _collection.mostLeftNode_internal();
		}

		/*
		 * ICollectionIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function start() : void {
			_next = _collection.size ? _collection.mostLeftNode_internal() : null;
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
			return _next != _collection.mostLeftNode_internal() && _collection.size;
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous() : * {
			if (_next == _collection.mostLeftNode_internal() || !_collection.size) {
				_current = null;
				return undefined;
			}

			_next = _next == null ? _collection.mostRightNode_internal() : _collection.previousNode_internal(_next);
			_current = _next;

			return _current.item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get current() : * {
			if (!_current) return undefined;
			return _current.item;
		}

		/**
		 * @inheritDoc
		 */
		public function remove() : Boolean {
			if (!_current) return false;
			
			_next = _collection.nextNode_internal(_current);
			_collection.removeNode_internal(_current);
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
			_next = _collection.nextNode_internal(_next);

			return _current.item;
		}
		
	}
}
