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
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.framework.IOrderedSetIterator;
	import org.as3commons.collections.framework.core.AbstractLinkedCollectionIterator;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Internal <code>LinkedSet</code> iterator implementation.
	 * 
	 * @author Jens Struwe 26.03.2010
	 */
	public class LinkedSetIterator extends AbstractLinkedCollectionIterator implements IOrderedSetIterator {
		
		use namespace as3commons_collections;

		/**
		 * LinkedSetIterator constructor.
		 * 
		 * <p>If <code>next</code> is specified, the iterator returns the item of that
		 * node with the first call to <code>next()</code> and its predecessor
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param orderedSet The set to be enumerated.
		 * @param next The node to start the iteration with.
		 */
		public function LinkedSetIterator(orderedSet : LinkedSet, next : LinkedNode = null) {
			super(orderedSet);
			
			if (next) _next = next;
		}
		
		/*
		 * IOrderedSetIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		public function addBefore(item : *) : Boolean {
			if (_next) {
				if (!LinkedSet(_collection).addBefore(_next.item, item)) return false;
			} else {
				if (!LinkedSet(_collection).addLast(item)) return false;
			}
			_current = null;
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAfter(item : *) : Boolean {
			if (_next) {
				if (!LinkedSet(_collection).addBefore(_next.item, item)) return false;
				_next = _next.left;
			} else {
				if (!LinkedSet(_collection).add(item)) return false;
				_next = _collection.lastNode_internal;
			}
			_current = null;
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function replace(item : *) : Boolean {
			if (!_current) return false;
			
			var oldCurrent : LinkedNode = _current;
			var previousNode : LinkedNode = _current.left;

			if (!LinkedSet(_collection).replace(oldCurrent.item, item)) return false;
			//if (!LinkedSet(_collection).replaceNode_internal(_current, item)) return false;
			_current = previousNode ? previousNode.right : _collection.firstNode_internal;

			if (oldCurrent == _next) {
				_next = _current;						
			}

			return true;
		}

		/*
		 * ISetIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function get previousItem() : * {
			return _next
				? _next.left ? _next.left.item : undefined
				: _collection.size ? _collection.lastNode_internal.item : undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextItem() : * {
			return _next ? _next.item : undefined;
		}

		/*
		 * Protected
		 */

		/**
		 * @inheritDoc
		 */
		override protected function removeCurrent() : void {
			LinkedSet(_collection).remove(_current.item);
		}
		
	}
}
