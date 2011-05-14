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
package org.as3commons.collections {

	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ISortedList;
	import org.as3commons.collections.framework.core.AbstractList;
	import org.as3commons.collections.utils.ArrayUtils;
	import org.as3commons.collections.utils.NullComparator;

	/**
	 * Sort order implementation of a list.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>SortedList</code> maintains an array as its source. Insertion or
	 * lookup operations are performed using a binary array search.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Getting of items - constant runtime O(1).<br />
	 * <code>first, last, itemAt()</code></li>
	 * <li>Removing of items at end - constant runtime O(1).<br />
	 * <code>removeLast()</code></li>
	 * <li>Item lookup inspection operations - logarithmic runtime O(log n).<br />
	 * has(), count(), firstIndexOf(), lastIndexOf(), lesserIndex(), higherIndex(), equalIndices()</code></li>
	 * <li>Adding or removing of items - linear runtime O(n).<br />
	 * <code>add(), removeFirst(), remove(), removeAll()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts an index position as the cursor parameter.
	 * If the specified index position exceeds the list length, the returned iterator is positioned
	 * at the end of the list.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>IListIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed if the comparator allows <code>null</code>.</p>
	 * 
	 * <p id="link_SortedListExample"><strong>SortedList example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>SortedList</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: SortedListExample}}
	 * 
	 * <p id="link_ArrayListExample"><strong>ArrayList example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListExample}}
	 * 
	 * <p id="link_ArrayListIteratorExample"><strong>ArrayListIterator example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListIteratorExample}}
	 * 
	 * @author Jens Struwe 19.03.2010
	 * @see org.as3commons.collections.framework.ISortedList ISortedList interface - Detailed description of the sorted list features.
	 * @see org.as3commons.collections.framework.IListIterator IListIterator interface - Detailed description of the base list iterator features.
	 * @see org.as3commons.collections.framework.IList IList interface - Detailed description of the base list features.
	 */
	public class SortedList extends AbstractList implements ISortedList {

		/**
		 * The sort criterion.
		 */
		protected var _comparator : IComparator;

		/**
		 * SortedArrayList constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function SortedList(comparator : IComparator = null) {
			_comparator = comparator ? comparator : new NullComparator();
		}

		/*
		 * ISortedList
		 */
		
		/**
		 * @inheritDoc
		 */
		public function lesserIndex(item : *) : int {
			var index : int = firstIndexOfEqual(item);
			
			if (index > -1) { // first equal item exists
				return index ? index - 1 : -1;				

			} else if (index == -1) { // first equal item should be added at start
				return -1;

			} else { // first equal item should be added after start
				return (- index - 1) - 1;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function higherIndex(item : *) : int {
			var index : int = lastIndexOfEqual(item);

			if (index > -1) { // last equal item exists
				index++;

			} else { // last equal item should be added there 
				index = - index - 1;
			}
			
			return index == _array.length ? -1 : index;
		}
		
		/**
		 * @inheritDoc
		 */
		public function equalIndices(item : *) : Array {
			var indices : Array = new Array();
			var firstIndex : int = firstIndexOfEqual(item);
			if (firstIndex < 0) return indices;
			
			indices.push(firstIndex);
			var size : uint = _array.length;
			for (var i : uint = firstIndex + 1; i < size; i++) {
				if (_comparator.compare(item, _array[i])) break;
				indices.push(i);
			}
			return indices;
		}
		
		/*
		 * ISortedOrder
		 */

		/**
		 * @inheritDoc
		 */
		public function set comparator(comparator : IComparator) : void {
			if (_array.length) throw new ArgumentError("You cannot set a comparator to a collection with size > 0");
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
			if (firstIndexOfEqual(item) < 0) return false;
			return true;
		}
		
		/*
		 * IList
		 */

		/**
		 * @inheritDoc
		 */
		override public function set array(array : Array) : void {
			_array = array.concat();
			ArrayUtils.mergeSort(_array, _comparator);
		}

		/**
		 * @inheritDoc
		 */
		override public function add(item : *) : uint {
			if (!_array.length) _comparator.compare(item, item); // type check, should throw an error if not passed
			
			var index : int = lastIndexOfEqual(item);
			if (index > -1) {
				index++;
			} else {
				index = - index - 1;
			}
			_array.splice(index, 0, item);
			return index;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function count(item : *) : uint {
			var count : uint = 0;
			var firstIndex : int = firstIndexOfEqual(item);
			if (firstIndex < 0) return 0;
			
			var i : uint;
			var size : uint = _array.length;
			for (i = firstIndex; i < size; i++) {
				if (_comparator.compare(item, _array[i])) break;
				if (item === _array[i]) count++;
			}
			return count;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function firstIndexOf(item : *) : int {
			var firstIndex : int = firstIndexOfEqual(item);
			if (firstIndex < 0) return -1;
			
			if (item === _array[firstIndex]) return firstIndex;
			var size : uint = _array.length;
			for (var i : uint = firstIndex + 1; i < size; i++) {
				if (_comparator.compare(item, _array[i])) break;
				if (item === _array[i]) return i;
			}
			return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function lastIndexOf(item : *) : int {
			var lastIndex : int = lastIndexOfEqual(item);
			if (lastIndex < 0) return -1;
			
			if (item === _array[lastIndex]) return lastIndex;
			for (var i : uint = lastIndex - 1; i >= 0; i--) {
				if (_comparator.compare(item, _array[i])) break;
				if (item === _array[i]) return i;
			}
			return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(item : *) : uint {
			var firstIndex : int = firstIndexOfEqual(item);
			if (firstIndex < 0) return 0;
			
			var numItems : uint = _array.length;
			var size : uint = _array.length;
			for (var i : uint = firstIndex; i < size; i++) {
				if (_comparator.compare(item, _array[i])) break;

				if (item === _array[i]) {
					_array.splice(i, 1);

					itemRemoved(i, item); // notify subclasses

					i--;
					size--;
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
		override public function has(item : *) : Boolean {
			var firstIndex : int = firstIndexOfEqual(item);
			if (firstIndex < 0) return false;
			
			if (item === _array[firstIndex]) return true;
			var size : uint = _array.length;
			for (var i : uint = firstIndex + 1; i < size; i++) {
				if (_comparator.compare(item, _array[i])) break;
				if (item === _array[i]) return true;
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function remove(item : *) : Boolean {
			var firstIndex : int = firstIndexOfEqual(item);
			if (firstIndex < 0) return false;

			var i : uint;
			var size : uint = _array.length;
			for (i = firstIndex; i < size; i++) {
				if (_comparator.compare(item, _array[i])) break;
				if (_array[i] === item) {
					_array.splice(i, 1);

					itemRemoved(i, item); // notify subclasses

					return true;
				}
			}
			return false;
		}
		
		/*
		 * Private
		 */

		/**
		 * Returns the index of the first equal item.
		 * 
		 * <p>Returns <code>-1</code> if no equal item is contained.</p>
		 * 
		 * @param item The item to test.
		 * @return The first index of an equal item.
		 */
		protected function firstIndexOfEqual(item : *) : int {
			var start : uint = 0;
			var end : int = _array.length - 1;  // end may become negative
			var cursor : uint;
			var match : Boolean = false;
			while (start <= end) {
				cursor = (end + start) / 2;
				switch (_comparator.compare(item, _array[cursor])) {
					case 0:
						if (cursor == start) return cursor;
						match = true;
						end = cursor - 1;
						break;
					case -1: // array at cursor greater than item
						if (cursor == start) return -1 - cursor;
						end = cursor - 1; 
						break;
					case 1: // array at cursor lesser than item
						if (cursor == end) {
							if (match) return cursor + 1;
							return -1 - (cursor + 1);
						}
						start = cursor + 1; 
						break;
				}
			}
			return -1;
		}
		
		/**
		 * Returns the index of the last equal item.
		 * 
		 * <p>Returns <code>-1</code> if no equal item is contained.</p>
		 * 
		 * @param item The item to test.
		 * @return The last index of an equal item.
		 */
		protected function lastIndexOfEqual(item : *) : int {
			var start : uint = 0;
			var end : int = _array.length - 1;  // end may become negative
			var cursor : uint;
			var match : Boolean = false;
			while (start <= end) {
				cursor = (end + start) / 2;
				switch (_comparator.compare(item, _array[cursor])) {
					case 0:
						if (cursor == end) return cursor;
						match = true;
						start = cursor + 1;
						break;
					case -1: // array at cursor greater than item
						if (cursor == start) {
							if (match) return cursor - 1;
							return -1 - cursor;
						}
						end = cursor - 1; 
						break;
					case 1: // array at cursor lesser than item
						if (cursor == end) return -1 - (cursor + 1);
						start = cursor + 1; 
						break;
				}
			}
			return -1;
		}

	}
}
