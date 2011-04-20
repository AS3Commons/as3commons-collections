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
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.ISetIterator;
	import org.as3commons.collections.framework.core.AbstractSortedCollectionIterator;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Internal <code>SortedSet</code> iterator implementation.
	 * 
	 * @author Jens Struwe 01.04.2010
	 */
	public class SortedSetIterator extends AbstractSortedCollectionIterator implements ISetIterator {

		use namespace as3commons_collections;

		/**
		 * SortedMapIterator constructor.
		 * 
		 * <p>If <code>next</code> is specified, the iterator returns the item of that
		 * node with the first call to <code>next()</code> and its predecessor
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param sortedSet The set to be enumerated.
		 * @param next The node to start the iteration with.
		 */
		public function SortedSetIterator(sortedSet : SortedSet, next : SortedNode = null) {
			super(sortedSet, next);
		}
		
		/*
		 * ISetIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		public function get previousItem() : * {
			if (_next) {
				var previous : SortedNode = _collection.previousNode_internal(_next);
				return previous ? previous.item : undefined;
			} else {
				return _collection.size ? _collection.mostRightNode_internal().item : undefined;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextItem() : * {
			return _next ? _next.item : undefined;
		}
	}
}
