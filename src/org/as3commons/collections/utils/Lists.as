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
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.framework.ISortOrder;
	import org.as3commons.collections.iterators.FilterIterator;

	/**
	 * <code>IList</code> utilities.
	 * 
	 * <p id="link_ListsAddFromExample"><strong><code>Lists.addFrom...()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: ListsAddFromExample}}
	 * 
	 * <p id="link_ListsCloneExample"><strong><code>Lists.clone()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: ListsCloneExample}}
	 * 
	 * <p id="link_ListsCopyExample"><strong><code>Lists.copy()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: ListsCopyExample}}
	 * 
	 * <p id="link_AddFromArgsExample"><strong><code>Lists.new...()</code> example</strong></p>
	 * 
	 * {{EXAMPLE: AddFromArgsExample}}
	 * 
	 * <p id="link_NestedCollectionsExample"><strong>Nested collections example</strong></p>
	 * 
	 * {{EXAMPLE: NestedCollectionsExample}}
	 * 
	 * @author Jens Struwe 21.04.2011
	 */
	public class Lists {

		/*
		 * Factories
		 */

		/**
		 * Creates, populates and returns a new <code>ArrayList</code> instance.
		 * 
		 * <p>The arguments may be left out. In that case no item is added to the list.</p>
		 * 
		 * <listing>
				var list : ArrayList = Lists.newArrayList(item1, item2, ...);
		 * </listing>
		 * 
		 * @param ...args List of items to add to the list.
		 * @return A new <code>ArrayList</code> instance populated from the given arguments.
		 */
		public static function newArrayList(...args) : ArrayList {
			var list : ArrayList = new ArrayList();
			addFromArray(list, args);
			return list;
		}

		/**
		 * Creates, populates and returns a new <code>ArrayList</code> instance.
		 * 
		 * <p>The arguments may be left out. In that case no item is added to the list.</p>
		 * 
		 * <listing>
				var list : ArrayList = Lists.newSortedList(comparator, item1, item2, ...);
		 * </listing>
		 * 
		 * @param ...args List of items to add to the list.
		 * @param comparator The sort criterion.
		 * @return A new <code>SortedList</code> instance populated from the given arguments.
		 */
		public static function newSortedList(comparator : IComparator, ...args) : SortedList {
			var list : SortedList = new SortedList(comparator);
			addFromArray(list, args);
			return list;
		}

		/*
		 * Population
		 */

		/**
		 * Adds the contents of the given <code>Array</code> to the specified list.
		 * 
		 * <listing>
				var array : Array = [item1, item2, ...];
				var count : uint = Lists.addFromArray(list, array);
		 * </listing>
		 * 
		 * @param list The list to populate.
		 * @param source The <code>Array</code> to add from.
		 * @return The number of items added to the list.
		 */
		public static function addFromArray(list : IList, source : Array) : uint {
			if (!source) return 0;

			var numAdded : uint;
			var wrapper : Args;
			for (var i : uint; i < source.length; i++) {
				if (source[i] is Args) {
					wrapper = source[i];
					if (wrapper.source is Array) numAdded += addFromArray(list, wrapper.source as Array);
					else if (wrapper.source is ICollection) numAdded += addFromCollection(list, wrapper.source as ICollection);
					else {
						list.add(wrapper.source);
						numAdded++;
					}

				} else {
					list.add(source[i]);
					numAdded++;
				}
			}
			return numAdded;
		}

		/**
		 * Adds the contents of the given <code>ICollection</code> to the specified list.
		 * 
		 * <listing>
				var count : uint = Lists.addFromCollection(list, sourceCollection);
		 * </listing>
		 * 
		 * @param list The list to populate.
		 * @param source The <code>ICollection</code> to add from.
		 * @return The number of items added to the list.
		 */
		public static function addFromCollection(list : IList, source : ICollection) : uint {
			if (!source) return 0;

			var added : uint;
			var iterator : IIterator = source.iterator();
			while (iterator.hasNext()) {
				list.add(iterator.next());
				added++;
			} 
			return added;
		}

		/**
		 * Adds the given list of items to the specified list.
		 * 
		 * <listing>
				Lists.addFromArgs(myList, item1, item2, ...);
		 * </listing>
		 * 
		 * @param list The list to populate.
		 * @param ...args List of items to add to the list.
		 * @return The number of items added to the list.
		 */
		public static function addFromArgs(list : IList, ...args) : uint {
			return addFromArray(list, args);
		}

		/**
		 * Clones the supplied <code>IList</code> instance returning a new <code>IList</code>
		 * of the same type.
		 * 
		 * <p>If a filter is specified the resulting list only contains items that
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
					
			var list : IList = Lists.clone(list, filter);
		 * </listing>
		 * 
		 * @param list The <code>IList</code> instance to clone.
		 * @param filter Function which will be applied to each item in the source list.
		 * @return A new <code>IList</code> instance.
		 */
		public static function clone(list : IList, filter : Function = null) : IList {
			var clone : IList = new ((list as Object).constructor)() as IList;
			if (list is ISortOrder) ISortOrder(clone).comparator = ISortOrder(list).comparator;
			
			var iterator : IIterator = new FilterIterator(list, filter);
			while (iterator.hasNext()) {
				clone.add(iterator.next());
			}
			return clone;
		}

		/**
		 * Copies items from one list to another.
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
					
			Lists.copy(sourceList, destinationList, filter);
		 * </listing>
		 * 
		 * @param source The <code>IList</code> instance to copy from.
		 * @param destination The <code>IList</code> to copy to.
		 * @param filter Function which will be applied to each item in the source list.
		 * @return The number of items copied to the list.
		 */
		public static function copy(source : IList, destination : IList, filter : Function = null) : uint {
			var iterator : IIterator = new FilterIterator(source, filter);
			var numAdded : uint;
			while (iterator.hasNext()) {
				destination.add(iterator.next());
				numAdded++;
			}
			return numAdded;
		}

	}
}
