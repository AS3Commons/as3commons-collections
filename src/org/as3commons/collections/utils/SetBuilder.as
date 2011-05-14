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

	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.Set;
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.ISet;

	/**
	 * Set builder using the builder pattern.
	 * 
	 * <p>Uses the builder Pattern to simplify the creation of new ISet instances in a fluent fashion.</p>
	 *  
	 * <p>Example: Creating a new LinkedSet instance using SetBuilder.</p>
	 * 
	 * <listing>
	 * 		const result : ISet = SetBuilder.newLinkedSet()
	 * 			.add("item-one")
	 * 			.add("item-two")
	 * 			.build();
	 * 		
	 * 		// Creates the following set: { item-one, item-two }
	 * 		trace(result);
	 * </listing>
	 * 
	 * @author John Reeves 14.04.2011
	 */
	public class SetBuilder {

		/**
		 * Backing <code>ISet</code> instance.
		 */
		private var _set : ISet;
		
		/**
		 * Starts the construction of a new <code>Set</code> instance.
		 * 
		 * @return a <code>SetBuilder</code> instance which will build and return an instance of Set
		 */
		public static function newSet() : SetBuilder {
			return new SetBuilder(new Set());
		}
		
		/**
		 * Starts construction of a new <code>LinkedSet</code> instance.
		 * 
		 * @return a <code>SetBuilder</code> instance which will build and return an instance of <code>LinkedSet</code>
		 */		
		public static function newLinkedSet() : SetBuilder {
			return new SetBuilder(new LinkedSet());
		}

		/**
		 * Starts construction of a new <code>SortedSet</code> instance.
		 * 
		 * @param comparator The sort criterion which will be used by the resulting <code>SortedSet</code> instance.
		 * @return a <code>SetBuilder</code> instance which will build and return an instance of <code>SortedSet</code>
		 */	
		public static function newSortedSet(comparator : IComparator) : SetBuilder {
			return new SetBuilder(new SortedSet(comparator));
		}
		
		/**
		 * Please make use of one of the static factory methods for creating a new <code>SetBuilder</code> instance.
		 * 
		 * @private
		 */
		public function SetBuilder(underlyingSet : ISet) {
			_set = underlyingSet;
		}
		
		/**
		 * Adds the supplied item to the <code>ISet</code> under construction.
		 * 
		 * <p>Returns a reference to this SetBuilder instance.</p>
		 * 
		 * @param item to add to the <code>ISet</code> instance under construction.
		 * @return a reference to this <code>SetBuilder</code> instance to allow method chaining.
		 */
		public function add(item : *) : SetBuilder {
			_set.add(item);
			return this;
		}
		
		/**
		 * Completes construction.
		 */
		public function build() : ISet {
			return _set;
		}
	}
}
