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
package org.as3commons.collections.iterators {

	import org.as3commons.collections.framework.IBasicMapIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMap;

	/**
	 * MapFilterIterator iterator.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>MapFilterIterator</code> accepts an <code>IMap</code> instance
	 * and a key filter function and works the same way as the <code>IIterator</code> returned
	 * by the particular <code>iterator()</code> method of the given iterable collection.
	 * In difference to, the <code>MapFilterIterator</code> considers only those items that
	 * pass the given filter.</p>
	 * 
	 * <p>It is possible to additionally specify an item filter, which further narrows the
	 * result by testing against the possible returned item.</p>
	 * 
	 * <p><strong>Filter functions</strong></p>
	 * 
	 * <p>The key filter function accepts the current key and returns a boolean
	 * value (<code>true</code> if the key is accepted).</p>
	 * 
	 * <listing>
			function keyFilter(key : *) : Boolean {
				var accept : Boolean = false;
				// test the key
				return accept;
			}
			
			var iterator : IIterator = new MapFilterIterator(map, keyFilter);
	 * </listing>
	 * 
	 * <p>The item filter function accepts the current item and returns a boolean
	 * value (<code>true</code> if the item is accepted).</p>
	 * 
	 * <listing>
			function itemFilter(item : *) : Boolean {
				var accept : Boolean = false;
				// test the item
				return accept;
			}
			
			var iterator : IIterator = new MapFilterIterator(map, keyFilter, itemFilter);
	 * </listing>
	 * 
	 * @author Jens Struwe 12.02.2009
	 * @see org.as3commons.collections.framework.IIterator IIterator interface - Description of the basic iterator features.
	 * @see FilterIterator FilterIterator - Filter iterator usage example.
	 * 
	 * @TODO To be tested.
	 */
	public final class MapFilterIterator implements IBasicMapIterator {

		/**
		 * The map to filter.
		 */
		private var _map : IMap;

		/**
		 * The inner iterator.
		 */
		private var _iterator : IIterator;

		/**
		 * The key of the next item to return.
		 */
		private var _nextKey : *;

		/**
		 * The key of last returned item.
		 */
		private var _currentKey : *;

		/**
		 * The key filter.
		 */
		private var _keyFilter : Function;

		/**
		 * The item filter.
		 */
		private var _itemFilter : Function;

		/**
		 * MapFilterIterator constructor.
		 * 
		 * @param iterable An <code>IIterable</code> implementing collection.
		 * @param keyFilter The key filter function. 
		 * @param itemFilter The item filter function (optional). 
		 */
		public function MapFilterIterator(map : IMap, keyFilter : Function, itemFilter : Function = null) {
			_map = map;
			_iterator = map.keyIterator();

			_keyFilter = keyFilter != null ? keyFilter : nullFilter;
			_itemFilter = itemFilter != null ? itemFilter : nullFilter;
		}
	
		/*
		 * IIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function hasNext() : Boolean {
			if (_nextKey !== undefined) return true;

			var nextKey : *;
			var next : *;
			while (_iterator.hasNext()) {
				nextKey = _iterator.next();
				next = _map.itemFor(nextKey);

				if (_keyFilter(nextKey) && _itemFilter(next)) {
					_nextKey = nextKey;
					return true;
				}

			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next() : * {
			if (_nextKey === undefined && !hasNext()) {
				_currentKey = undefined;
				return undefined;
			}
			
			_currentKey = _nextKey;
			_nextKey = undefined;
			return _map.itemFor(_currentKey);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get key() : * {
			return _currentKey;
		}

		/*
		 * Private
		 */
		
		/**
		 * Filter to be used if no filter has been specified else.
		 */
		private function nullFilter(key : *) : Boolean {
			return true;
		}

	}
}
