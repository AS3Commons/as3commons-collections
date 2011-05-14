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
package org.as3commons.collections.utils {

	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.SortedList;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IList;

	/**
	 * List builder using the builder pattern.
	 * 
	 * <p>Uses the builder Pattern to simplify the creation of new <code>IList</code> instances
	 * in a fluent fashion.</p>
	 *  
	 * <p>Example: Creating a new <code>ArrayList</code> instance using ListBuilder.</p>
	 * 
	 * <listing>
	 * 		const result : IList = ListBuilder.newArrayList()
	 * 			.add("item-one")
	 * 			.add("item-two")
	 * 			.build();
	 * 		
	 * 		// Creates the following list: { item-one, item-two }
	 * 		trace(result);
	 * </listing>;
	 * 
	 * @author John Reeves 14.04.2011
	 */
	public class ListBuilder {

		/**
		 * Backing <code>IList</code> instance.
		 */
		private var _list : IList;
		
		/**
		 * Starts construction of a new <code>ArrayList</code> instance.
		 * 
		 * @return A <code>ListBuilder</code> instance which will build and return an instance of <code>ArrayList</code>
		 */		
		public static function newArrayList() : ListBuilder {
			return new ListBuilder(new ArrayList());
		}

		/**
		 * Starts construction of a new <code>SortedList</code> instance.
		 * 
		 * @param comparator The sort criterion which will be used by the resulting <code>SortedList</code> instance.
		 * @return A <code>ListBuilder</code> instance which will build and return an instance of <code>SortedList</code>
		 */	
		public static function newSortedList(comparator : IComparator) : ListBuilder {
			return new ListBuilder(new SortedList(comparator));
		}
		
		/**
		 * Please make use of one of the static factory methods for creating a new <code>ListBuilder</code> instance.
		 * 
		 * @private
		 */
		public function ListBuilder(underlyingList : IList) {
			_list = underlyingList;
		}
		
		/**
		 * Adds the supplied item to the <code>IList</code> under construction.
		 * 
		 * <p>Returns a reference to this <code>ListBuilder</code> instance.</p>
		 * 
		 * @param item to add to the <code>IList</code> instance under construction.
		 * @return A reference to this <code>ListBuilder</code> instance to allow method chaining.
		 */
		public function add(item : *) : ListBuilder {
			_list.add(item);
			return this;
		}
		
		/**
		 * Completes construction.
		 */
		public function build() : IList {
			return _list;
		}
	}
}
