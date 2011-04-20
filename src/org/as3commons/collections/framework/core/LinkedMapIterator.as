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
	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.IOrderedMapIterator;
	import org.as3commons.collections.framework.core.AbstractLinkedCollectionIterator;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Internal <code>LinkedMap</code> iterator implementation.
	 * 
	 * @author Jens Struwe 26.03.2010
	 */
	public class LinkedMapIterator extends AbstractLinkedCollectionIterator implements IOrderedMapIterator {
		
		use namespace as3commons_collections;

		/**
		 * LinkedMapIterator constructor.
		 * 
		 * <p>If <code>next</code> is specified, the iterator returns the item of that
		 * node with the first call to <code>next()</code> and its predecessor
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param orderedMap The map to be enumerated.
		 * @param next The node to start the iteration with.
		 */
		public function LinkedMapIterator(orderedMap : LinkedMap, next : LinkedMapNode = null) {
			super(orderedMap);
			
			if (next) _next = next;
		}
		
		/*
		 * IOrderedMapIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		public function addBefore(key : *, item : *) : Boolean {
			if (_next) {
				if (!LinkedMap(_collection).addBefore(LinkedMapNode(_next).key, key, item)) return false;
			} else {
				if (!LinkedMap(_collection).addLast(key, item)) return false;
			}
			_current = null;
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAfter(key : *, item : *) : Boolean {
			if (_next) {
				if (!LinkedMap(_collection).addBefore(LinkedMapNode(_next).key, key, item)) return false;
				_next = _next.left;
			} else {
				if (!LinkedMap(_collection).add(key, item)) return false;
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
			
			return LinkedMap(_collection).replaceFor(LinkedMapNode(_current).key, item);
		}

		/*
		 * IMapIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function get previousKey() : * {
			return _next
				? _next.left ? LinkedMapNode(_next.left).key : undefined
				: _collection.size ? LinkedMapNode(_collection.lastNode_internal).key : undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextKey() : * {
			return _next ? LinkedMapNode(_next).key : undefined;
		}

		/**
		 * @inheritDoc
		 */
		public function get key() : * {
			return _current ? LinkedMapNode(_current).key : undefined;
		}

		/*
		 * Protected
		 */

		/**
		 * @inheritDoc
		 */
		override protected function removeCurrent() : void {
			LinkedMap(_collection).removeKey(LinkedMapNode(_current).key);
		}
		
	}
}
