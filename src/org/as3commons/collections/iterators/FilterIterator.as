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
	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	/**
	 * Filter iterator.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>FilterIterator</code> accepts an <code>IIterable</code> instance
	 * and a filter function and works the same way as the <code>IIterator</code> returned
	 * by the particular <code>iterator()</code> method of the given iterable collection.
	 * In difference to, the <code>FilterIterator</code> considers only those items that
	 * pass the given filter.</p>
	 * 
	 * <p><strong>Filter function</strong></p>
	 * 
	 * <p>The filter function accepts the current item and returns a boolean
	 * value (<code>true</code> if the item is accepted).</p>
	 * 
	 * <listing>
			function filter(item : *) : Boolean {
				var accept : Boolean = false;
				// test the item
				return accept;
			}
			
			var iterator : IIterator = new FilterIterator(collection, filter);
	 * </listing>
	 * 
	 * <p id="link_FilterIteratorExample"><strong>Filter iterator example</strong></p>
	 * 
	 * {{EXAMPLE: FilterIteratorExample}}
	 * 
	 * @author Jens Struwe 12.02.2009
	 * @see org.as3commons.collections.framework.IIterator IIterator interface - Description of the basic iterator features.
	 */
	public final class FilterIterator implements IIterator {

		/**
		 * The inner iterator.
		 */
		private var _iterator : IIterator;

		/**
		 * The next item to return.
		 */
		private var _next : *;

		/**
		 * The filter.
		 */
		private var _filter : Function;

		/**
		 * FilterIterator constructor.
		 * 
		 * @param iterable An <code>IIterable</code> implementing collection.
		 * @param filter The filter function. 
		 */
		public function FilterIterator(iterable : IIterable, filter : Function) {
			_iterator = iterable.iterator();
			_filter = filter != null ? filter : nullFilter;
		}
	
		/*
		 * IIterator
		 */

		/**
		 * @inheritDoc
		 */
		public function hasNext() : Boolean {
			if (_next !== undefined) return true;

			var next : *;
			while (_iterator.hasNext()) {
				next = _iterator.next();
				if (_filter(next)) {
					_next = next;
					return true;
				}
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next() : * {
			if (_next === undefined && !hasNext()) return undefined;
			
			var current : * = _next;
			_next = undefined;
			return current;
		}
		
		/*
		 * Private
		 */
		
		/**
		 * Filter to be used if no filter has been specified else.
		 */
		private function nullFilter(item : *) : Boolean {
			return true;
		}
		
	}
}
