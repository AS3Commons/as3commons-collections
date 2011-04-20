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
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IOrderedList;
	import org.as3commons.collections.framework.core.AbstractList;
	import org.as3commons.collections.framework.core.ArrayListIterator;
	import org.as3commons.collections.utils.ArrayUtils;

	/**
	 * Insertion order implementation of a list.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>ArrayList</code> maintains an array as its source.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Adding or removing of items at end - constant runtime O(1).<br />
	 * <code>add(), addLast(), removeLast()</code></li>
	 * <li>Getting or replacing of items - constant runtime O(1).<br />
	 * <code>first, last, itemAt(), replaceAt()</code></li>
	 * <li>Adding or removing of items in front (or in between) - linear runtime O(n).<br />
	 * <code>addFirst(), addAt(), addAllAt(), removeFirst(), removeAt(), removeAllAt()</code></li>
	 * <li>Item lookup operations - linear runtime O(n).<br />
	 * has(), count(), firstIndexOf(), lastIndexOf(), remove(), removeAll()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method accepts an index position as the cursor parameter.
	 * If the specified index position exceeds the list length, the returned iterator is positioned
	 * at the end of the list.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>IArrayListIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed.</p>
	 * 
	 * <p id="link_ArrayListExample"><strong>ArrayList example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListExample}}
	 * 
	 * <p id="link_ArrayListIteratorExample"><strong>ArrayListIterator example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListIteratorExample}}
	 * 
	 * @author Jens Struwe 17.02.2010
	 * @see org.as3commons.collections.framework.IOrderedList IOrderedList interface - Detailed description of the ordered list features.
	 * @see org.as3commons.collections.framework.IOrderedListIterator IOrderedListIterator interface - Detailed description of the ordered list iterator features.
	 * @see org.as3commons.collections.framework.IList IList interface - Detailed description of the base list features.
	 */
	public class ArrayList extends AbstractList implements IOrderedList {
		
		/**
		 * ArrayList constructor.
		 */
		public function ArrayList() {
		}
		
		/*
		 * IOrderedList
		 */

		/**
		 * @inheritDoc
		 */
		public function addFirst(item : *) : void {
			_array.unshift(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addLast(item : *) : void {
			_array.push(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAt(index : uint, item : *) : Boolean {
			if (index <= _array.length) {
				_array.splice(index, 0, item);
				return true;
			} else {
				return false;
			}
		}
	
		/**
		 * @inheritDoc
		 */
		public function addAllAt(index : uint, items : Array) : Boolean {
			if (index <= _array.length) {
				_array = _array.slice(0, index).concat(items).concat(_array.slice(index));
				return true;
			} else {
				return false;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function replaceAt(index : uint, item : *) : Boolean {
			if (index < _array.length) {
				if (_array[index] === item) return false;
				_array[index] = item;
				return true;
			}
			return false;
		}
	
		/**
		 * @inheritDoc
		 */
		public function reverse() : Boolean {
			if (_array.length < 2) return false;
			_array.reverse();
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function sort(comparator : IComparator) : Boolean {
			if (_array.length < 2) return false;
			ArrayUtils.mergeSort(_array, comparator);
			return true;
		}
		
		/*
		 * IIterable
		 */

		/**
		 * @inheritDoc
		 */
		override public function iterator(cursor : * = undefined) : IIterator {
			var index : uint = cursor is uint ? cursor : 0;
			return new ArrayListIterator(this, index);
		}

	}
}
