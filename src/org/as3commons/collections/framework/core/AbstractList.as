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
	import org.as3commons.collections.framework.IDataProvider;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IList;

	/**
	 * Abstract list implementation.
	 * 
	 * @author Jens Struwe 23.03.2010
	 */
	public class AbstractList implements IList, IDataProvider {
		
		/**
		 * The internal array.
		 */
		protected var _array : Array;
		
		/**
		 * AbstractList constructor.
		 */
		public function AbstractList() {
			_array = new Array();
		}

		/*
		 * IList
		 */

		/**
		 * @inheritDoc
		 */
		public function set array(array : Array) : void {
			_array = array.concat();
		}

		/**
		 * @inheritDoc
		 */
		public function add(item : *) : uint {
			_array.push(item);
			return _array.length - 1;
		}
	
		/**
		 * @inheritDoc
		 */
		public function count(item : *) : uint {
			var count : uint = 0;
			var size : uint = _array.length;
			for (var i : int = 0; i < size; i++) {
				if (_array[i] === item) count++;
			}
			return count;
		}

		/**
		 * @inheritDoc
		 */
		public function firstIndexOf(item : *) : int {
			return _array.indexOf(item);
		}
	
		/**
		 * @inheritDoc
		 */
		public function lastIndexOf(item : *) : int {
			for (var i : int = _array.length - 1; i >= 0; i--) {
				if (item === _array[i]) return i;
			}
			return -1;
		}
	
		/**
		 * @inheritDoc
		 */
		public function get first() : * {
			return _array[0];
		}
		
		/**
		 * @inheritDoc
		 */
		public function get last() : * {
			return _array[_array.length - 1];
		}

		/**
		 * @inheritDoc
		 */
		public function itemAt(index : uint) : * {
			return _array[index];
		}
	
		/**
		 * @inheritDoc
		 */
		public function removeFirst() : * {
			return _array.shift();
		}

		/**
		 * @inheritDoc
		 */
		public function removeLast() : * {
			return _array.pop();
		}

		/**
		 * @inheritDoc
		 */
		public function removeAt(index : uint) : * {
			return _array.splice(index, 1)[0];
		}
	
		/**
		 * @inheritDoc
		 */
		public function removeAllAt(index : uint, numItems : uint) : Array {
			return _array.splice(index, numItems);
		}

		/**
		 * @inheritDoc
		 */
		public function removeAll(item : *) : uint {
			var numItems : uint = _array.length;
			for (var i : int = 0; i < numItems; i++) {
				if (_array[i] === item) {
					_array.splice(i, 1);

					itemRemoved(i, item); // notify subclasses

					i--;
				}
			}
			return numItems - _array.length;
		}

		/*
		 * ICollection
		 */

		/**
		 * @inheritDoc
		 */
		public function get size() : uint {
			return _array.length;
		}

		/**
		 * @inheritDoc
		 */
		public function has(item : *) : Boolean {
			return firstIndexOf(item) > -1;
		}

		/**
		 * @inheritDoc
		 */
		public function toArray() : Array {
			return _array.concat();
		}

		/**
		 * @inheritDoc
		 */
		public function remove(item : *) : Boolean {
			var index : int = _array.indexOf(item);
			if (index == -1) return false;
			_array.splice(index, 1);

			itemRemoved(index, item); // notify subclasses

			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear() : Boolean {
			if (!_array.length) return false;
			_array = new Array();
			return true;
		}
	
		/*
		 * IIterable
		 */

		/**
		 * @inheritDoc
		 */
		public function iterator(cursor : * = undefined) : IIterator {
			var index : uint = cursor is uint ? cursor : 0;
			return new AbstractListIterator(this, index);
		}
		
		/*
		 * as3commons_collections
		 */
		
		/**
		 * Framework internal getter to retrieve a reference to the internal array.
		 */
		as3commons_collections function get array_internal() : Array {
			return _array;
		}
		
		/*
		 * Protected
		 */
		
		/**
		 * Template method to notify subclasses after an item has been removed.
		 * 
		 * @param index The former index of the removed item.
		 * @param item The removed item.
		 */
		protected function itemRemoved(index : uint, item : *) : void {
			// hook
		}
	}
}
