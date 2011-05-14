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
	import org.as3commons.collections.framework.IRecursiveIterator;

	/**
	 * Recursive filter iterator.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>RecursiveFilterIterator</code> accepts an <code>IIterable</code> instance
	 * and iterates recursively over the items of the given iterable collection while applying
	 * the specified filters. To do so, all children that should be further iterated should be
	 * also instance of <code>IIterable</code>.</p>
	 * 
	 * <p><strong>Filter functions</strong></p>
	 * 
	 * <p>Its possible to set up two different filters. The first filter tests if an
	 * item should be returned. The second filter tests if children of a specific item
	 * should be considered or not. Children of items that did not pass the first
	 * <code>filter</code> function are skipped by the iterator. This is the difference
	 * to <code>RecursiveFilterIterator2</code>. It is possible to set
	 * up both filters together.</p>
	 * 
	 * <p>Both filter functions accept the current item and return a boolean
	 * value (<code>true</code> if the item is accepted).</p>
	 * 
	 * <listing>
			function filter(item : *) : Boolean {
				var accept : Boolean = false;
				// test the item
				return accept;
			}

			function childrenFilter(item : *) : Boolean {
				var accept : Boolean = false;
				// test the item
				return accept;
			}
			
			var iterator : IRecursiveIterator = new RecursiveFilterIterator(collection, filter, childrenFilter);
	 * </listing>
	 * 
	 * <p id="link_RecursiveFilterIteratorExample"><strong>Recursive filter iterator example</strong></p>
	 * 
	 * {{EXAMPLE: RecursiveFilterIteratorExample}}
	 * 
	 * @author Jens Struwe 14.05.2009
	 * @see org.as3commons.collections.framework.IRecursiveIterator IRecursiveIterator interface - Description of the recursive iterator features.
	 * @see FilterIterator FilterIterator - Filter iterator usage example.
	 */
	public final class RecursiveFilterIterator implements IRecursiveIterator {

		/**
		 * Iterator to start with.
		 */
		private var _iterator : IIterator;

		/**
		 * The filter.
		 */
		private var _filter : Function;

		/**
		 * The children filter.
		 */
		private var _childrenFilter : Function;

		/**
		 * Base depth of the iterator.
		 */
		private var _rootDepth : uint;

		/**
		 * Depth of the current child iterator.
		 */
		private var _depth : uint;

		/**
		 * Cursor child iterator.
		 */
		private var _childIterator : IRecursiveIterator;

		/**
		 * Cache for recursion detection.
		 */
		private var _parentItems : Array;
	
		/**
		 * Next item to return.
		 */
		private var _next : *;

		/**
		 * RecursiveFilterIterator constructor.
		 * 
		 * @param iterable An <code>IIterable</code> implementing collection.
		 * @param filter The filter function. 
		 * @param childrenFilter The children filter function. 
		 * @param depth Internally passed recursion depth. 
		 * @param parentItems Internally passed parent chain, considered in recursion detection.
		 */
		public function RecursiveFilterIterator(
			iterable : IIterable,
			filter : Function,
			childrenFilter : Function,
			depth : uint = 0,
			parentItems : Array = null
		) {
			_filter = filter != null ? filter : nullFilter;
			_childrenFilter = childrenFilter != null ? childrenFilter : nullFilter;
			
			_rootDepth = depth;
			_depth = depth;
			
			_iterator = iterable.iterator();
			_parentItems = parentItems ? parentItems : new Array(iterable);
		}
	
		/*
		 * IRecursiveIterator
		 */

		/**
		 * The recursion depth of the current item.
		 */
		public function get depth() : uint {
			return _depth;
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
			if (_childIterator) {
				while (_childIterator.hasNext()) {
					next = _childIterator.next();
					if (_filter(next)) {
						_next = next;
						return true;
					}
				}
				_childIterator = null;
				return hasNext();
			}

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

			var next : *;
			
			if (_childIterator) {
				_depth = _childIterator.depth;
				next = _next;
				_next = undefined;
				return next;
			}

			_depth = _rootDepth; // cannot use _iterator.getDepth() as we have here an IIterator instance

			if (_next is IIterable && _childrenFilter(_next)) {
				if (_parentItems.indexOf(_next) < 0) {
					_childIterator = new RecursiveFilterIterator(
						_next,
						_filter,
						_childrenFilter,
						_depth + 1,
						_parentItems.concat(_next)
					);
				}
			}
			
			next = _next;
			_next = undefined;
			return next;
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
