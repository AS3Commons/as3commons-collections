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
	import org.as3commons.collections.framework.IListIterator;

	/**
	 * Array iterator.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>ArrayIterator</code> is an <code>IListIterator</code> capable to
	 * enumerate an arbitrary array.</p>
	 * 
	 * @author Jens Struwe 09.03.2009
	 * @see org.as3commons.collections.framework.IListIterator IListIterator interface - Description of the basic list iterator features.
	 */
	public class ArrayIterator implements IListIterator {

		/**
		 * The array to enumerate.
		 */
		protected var _array : Array;

		/**
		 * The cursor position.
		 * 
		 * <p>The cursor is positioned before the item stored in the <code>_next</code>
		 * property. If the array is empty or the cursor is placed after the
		 * last item, <code>_next</code> has the value <code>-1</code>.</p>
		 */
		protected var _next : int;
		
		/**
		 * The index of the last returned item.
		 * 
		 * <p>Initially this property is set to <code>-1</code> (no item returned yet).</p>
		 * 
		 * <p><code>start(), end()</code> set this property to <code>-1</code>.</p>
		 */
		protected var _current : int = -1;

		/**
		 * ArrayIterator constructor.
		 * 
		 * <p>If <code>index</code> is specified, the iterator returns the item at that
		 * index with the first call to <code>next()</code> and the item at <code>index -1</code>
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param array The array to be enumerated.
		 * @param index Start position of enumeration.
		 */
		public function ArrayIterator(array : Array, index : uint = 0) {
			_array = array;

			_next = index >= _array.length ? -1 : index;
		}
		
		/*
		 * IListIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		public function get previousIndex() : int {
			return _next == -1 ? _array.length - 1 : _next - 1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextIndex() : int {
			return _next;
		}

		/**
		 * @inheritDoc
		 */
		public function get index() : int {
			return _current;
		}
		
		/*
		 * ICollectionIterator
		 */
	
		/**
		 * @inheritDoc
		 */
		public function hasPrevious() : Boolean {
			return _next && _array.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous() : * {
			if (_next == 0 || !_array.length) {
				_current = -1;
				return undefined;
			}

			_next = _next == -1 ? _array.length - 1 : _next - 1;
			_current = _next;

			return _array[_current];
		}
		
		/**
		 * @inheritDoc
		 */
		public function get current() : * {
			return _array[_current];
		}

		/**
		 * @inheritDoc
		 */
		public function start() : void {
			_next = _array.length ? 0 : -1;
			_current = -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function end() : void {
			_next = _current = -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove() : Boolean {
			if (_current == -1) return false;
			
			if (_current == _next) { // removed after previous()
				if (_next >= _array.length - 1) _next = -1;
			} else { // removed after next()
				if (_next > 0) _next--;
			}

			removeCurrent();
			_current = -1;
			return true;
		}

		/*
		 * IIterator
		 */
	
		/**
		 * @inheritDoc
		 */
		public function hasNext() : Boolean {
			return _next > -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next() : * {
			if (_next == -1) {
				_current = -1;
				return undefined;
			}
			
			_current = _next;
			_next = _next >= _array.length - 1 ? -1 : _next + 1;

			return _array[_current];
		}
		
		/*
		 * Protected
		 */
		
		/**
		 * Template method to enable subclasses of this iterator to
		 * remove the current item from its particular associated
		 * collection.
		 */
		protected function removeCurrent() : void {
			_array.splice(_current, 1)[0];
		}
		
	}
}
