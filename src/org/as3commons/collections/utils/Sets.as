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
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.framework.ISortOrder;
	import org.as3commons.collections.iterators.FilterIterator;

	/**
	 * <code>ISet</code> utilities.
	 * 
	 * <p id="link_SetsAddFromExample"><strong><code>Sets.addFrom...()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: SetsAddFromExample}}
	 * 
	 * <p id="link_SetsCloneExample"><strong><code>Sets.clone()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: SetsCloneExample}}
	 * 
	 * <p id="link_SetsCopyExample"><strong><code>Sets.copy()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: SetsCopyExample}}
	 * 
	 * <p id="link_AddFromArgsExample"><strong><code>Sets.new...()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: AddFromArgsExample}}
	 * 
	 * <p id="link_NestedCollectionsExample"><strong>Nested collections example</strong></p>
	 * 
	 * {{EXAMPLE: NestedCollectionsExample}}
	 * 
	 * @author Jens Struwe 21.04.2011
	 */
	public class Sets {

		/*
		 * Factories
		 */

		/**
		 * Creates, populates and returns a new <code>Set</code> instance.
		 * 
		 * <p>The arguments may be left out. In that case no item is added to the set.</p>
		 * 
		 * <listing>
				var theSet : LinkedSet = Sets.newSet(item1, item2, ...);
		 * </listing>
		 * 
		 * @param ...args List of key-item-pairs to add to the set.
		 * @return A new <code>Set</code> instance populated from the given arguments.
		 */
		public static function newSet(...args) : Set {
			var theSet : Set = new Set();
			addFromArray(theSet, args);
			return theSet;
		}

		/**
		 * Creates, populates and returns a new <code>LinkedSet</code> instance.
		 * 
		 * <p>The arguments may be left out. In that case no item is added to the set.</p>
		 * 
		 * <listing>
				var theSet : LinkedSet = Sets.newLinkedSet(item1, item2, ...);
		 * </listing>
		 * 
		 * @param ...args List of items to add to the set.
		 * @return A new <code>LinkedSet</code> instance populated from the given arguments.
		 */
		public static function newLinkedSet(...args) : LinkedSet {
			var theSet : LinkedSet = new LinkedSet();
			addFromArray(theSet, args);
			return theSet;
		}

		/**
		 * Creates, populates and returns a new <code>LinkedSet</code> instance.
		 * 
		 * <p>The arguments may be left out. In that case no item is added to the set.</p>
		 * 
		 * <listing>
				var theSet : LinkedSet = Sets.newSortedSet(comparator, item1, item2, ...);
		 * </listing>
		 * 
		 * @param ...args List of items to add to the set.
		 * @param comparator The sort criterion.
		 * @return A new <code>LinkedSet</code> instance populated from the given arguments.
		 */
		public static function newSortedSet(comparator : IComparator, ...args) : SortedSet {
			var theSet : SortedSet = new SortedSet(comparator);
			addFromArray(theSet, args);
			return theSet;
		}

		/*
		 * Population
		 */

		/**
		 * Adds the contents of the given <code>Array</code> to the specified set.
		 * 
		 * <listing>
				var array : Array = [item1, item2, ...];
				var count : uint = Sets.addFromArray(theSet, array);
		 * </listing>
		 * 
		 * @param theSet The set to populate.
		 * @param source The <code>Array</code> to add from.
		 * @return The number of items added to the set.
		 */
		public static function addFromArray(theSet : ISet, source : Array) : uint {
			if (!source) return 0;

			var numAdded : uint;
			var wrapper : Args;
			for (var i : uint; i < source.length; i++) {
				if (source[i] is Args) {
					wrapper = source[i];
					if (wrapper.source is Array) numAdded += addFromArray(theSet, wrapper.source as Array);
					else if (wrapper.source is ICollection) numAdded += addFromCollection(theSet, wrapper.source as ICollection);
					else {
						if (theSet.add(wrapper.source)) numAdded++;
					}

				} else {
					if (theSet.add(source[i])) numAdded++;
				}
			}
			return numAdded;
		}

		/**
		 * Adds the contents of the given <code>ICollection</code> to the specified set.
		 * 
		 * <listing>
				var count : uint = Sets.addFromCollection(theSet, sourceCollection);
		 * </listing>
		 * 
		 * @param theSet The set to populate.
		 * @param source The <code>ICollection</code> to add from.
		 * @return The number of items added to the set.
		 */
		public static function addFromCollection(theSet : ISet, source : ICollection) : uint {
			if (!source) return 0;

			var added : uint;
			var iterator : IIterator = source.iterator();
			while (iterator.hasNext()) {
				theSet.add(iterator.next());
				added++;
			} 
			return added;
		}

		/**
		 * Adds the given list of items to the specified set.
		 * 
		 * <listing>
				Sets.addFromArgs(mySet, item1, item2, ...);
		 * </listing>
		 * 
		 * @param theSet The set to populate.
		 * @param ...args List of items to add to the set.
		 * @return The number of items added to the set.
		 */
		public static function addFromArgs(theSet : ISet, ...args) : uint {
			return addFromArray(theSet, args);
		}

		/**
		 * Clones the supplied <code>ISet</code> instance returning a new <code>ISet</code>
		 * of the same type.
		 * 
		 * <p>If a filter is specified the resulting set only contains items that
		 * meet the supplied predicates.<p>
		 * 
		 * <p>The filter function accepts the current item and returns a boolean
		 * value (<code>true</code> if the item is accepted).</p>
		 * 
		 * <listing>
			function itemFilter(item : *) : Boolean {
				var accept : Boolean = false;
				// test the item
				return accept;
			}
					
			var theSet : ISet = Sets.clone(theSet, filter);
		 * </listing>
		 * 
		 * @param theSet The <code>ISet</code> instance to clone.
		 * @param filter Function which will be applied to each item in the source theSet.
		 * @return A new <code>ISet</code> instance.
		 */
		public static function clone(theSet : ISet, filter : Function = null) : ISet {
			var clone : ISet = new ((theSet as Object).constructor)() as ISet;
			if (theSet is ISortOrder) ISortOrder(clone).comparator = ISortOrder(theSet).comparator;
			
			var iterator : IIterator = new FilterIterator(theSet, filter);
			while (iterator.hasNext()) {
				clone.add(iterator.next());
			}
			return clone;
		}

		/**
		 * Copies items from one set to another.
		 * 
		 * <p>If a filter is specified only items are copied that meet the
		 * supplied predicates.<p>
		 * 
		 * <p>The filter function accepts the current item and returns a boolean
		 * value (<code>true</code> if the item is accepted).</p>
		 * 
		 * <listing>
			function itemFilter(item : *) : Boolean {
				var accept : Boolean = false;
				// test the item
				return accept;
			}
					
			Sets.copy(sourceSet, destinationSet, filter);
		 * </listing>
		 * 
		 * @param source The <code>ISet</code> instance to copy from.
		 * @param destination The <code>ISet</code> to copy to.
		 * @param filter Function which will be applied to each item in the source set.
		 * @return The number of items copied to the set.
		 */
		public static function copy(source : ISet, destination : ISet, filter : Function = null) : uint {
			var iterator : IIterator = new FilterIterator(source, filter);
			var numAdded : uint;
			while (iterator.hasNext()) {
				if (destination.add(iterator.next())) numAdded++;
			}
			return numAdded;
		}

	}
}
