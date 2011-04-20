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
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Abstract linked list based collection iterator implementation.
	 * 
	 * @author Jens Struwe 04.03.2010
	 */
	public class AbstractLinkedCollectionIterator implements ICollectionIterator {

		use namespace as3commons_collections;

		/**
		 * The list to enumerate.
		 */
		protected var _collection : AbstractLinkedCollection;

		/**
		 * The cursor position.
		 * 
		 * <p>The cursor is positioned before the item stored in the <code>_next</code>
		 * property. If the LinkedList is empty or the cursor is placed at
		 * end, <code>_next</code> has the value <code>null</code>.</p>
		 */
		protected var _next : LinkedNode;

		/**
		 * The node of the last returned item.
		 * 
		 * <p>Initially this property is <code>null</code> (no item returned yet).</p>
		 * 
		 * <p><code>start(), end(), addBefore(), addAfter()</code> and <code>remove()</code>
		 * set this property to <code>null</code>.</p>
		 */
		protected var _current : LinkedNode;

		/**
		 * AbstractLinkedCollectionIterator constructor.
		 * 
		 * @param collection The linked collection.
		 */
		public function AbstractLinkedCollectionIterator(collection : AbstractLinkedCollection) {
			_collection = collection;
			
			if (collection.size) _next = _collection.firstNode_internal;
		}
		
		/*
		 * ICollectionIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function start() : void {
			_next = _collection.size ? _collection.firstNode_internal : null;
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
			return _next != _collection.firstNode_internal && _collection.size;
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous() : * {
			if (_next == _collection.firstNode_internal || !_collection.size) {
				_current = null;
				return undefined;
			}

			_next = _next == null ? _collection.lastNode_internal : _next.left;
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
			
			_next = _current.right;

			removeCurrent();
			
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
			_next = _next.right;

			return _current.item;
		}
		
		/*
		 * Protected
		 */

		/**
		 * Template method to enable subclasses of this iterator to
		 * remove the item of the current node from its particular associated
		 * collection.
		 */
		protected function removeCurrent() : void {
		}

	}
}
