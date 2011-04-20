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
package org.as3commons.collections.framework {

	/**
	 * Base list definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A list is an index based ordered sequence of elements.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by an index or sequentially accessed using an iterator.</li>
	 * <li>Always ordered, by insertion or by a specific sort criterion.</li>
	 * <li>May contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the <code>ICollection</code>, a list offers:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IListIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Methods to handle duplicates (from <code>IDuplicates</code>).<br />
	 * <code>count(), removeAll()</code></li>
	 * <li>Index based inspection, retrieval and removal methods.<br />
	 * <code>firstIndexOf(), lastIndexOf(), itemAt(), removeAt(), removeAllAt()</code></li>
	 * <li>Methods to populate a list.<br />
	 * <code>array, add()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>There is no direct implementor of this interface.</p>
	 * 
	 * <p>The collection <code>LinkedList</code> does not implement this interface since
	 * it does not provide index based access to its items.</p>
	 * 
	 * @author Jens Struwe 17.02.2010
	 * @see ICollection ICollection interface - Detailed description of the base collection features.
	 */
	public interface IList extends IOrder, IDuplicates {
		
		/**
		 * Specifies an array to be maintained by the list.
		 * 
		 * <p>Already contained elements will be removed beforehand.</p>
		 * 
		 * <p>The list stores a copy of the given array not the array itself.</p>
		 * 
		 * @param array The array.
		 */
		function set array(array : Array) : void;
		
		/**
		 * Adds an item to the list.
		 * 
		 * <p>The <code>ArrayList</code> appends the item.</p>
		 * 
		 * <p>The position of items that are added to a <code>SortedList</code>
		 * depends on its sort order.</p>
		 * 
		 * @param item The item to add.
		 * @return The position where the item has been added.
		 */
		function add(item : *) : uint;

		/**
		 * Returns the index of the first occurrence of an item.
		 * 
		 * @param item The item to test.
		 * @return The first position of the item or <code>-1</code> if the item is not contained.
		 */
		function firstIndexOf(item : *) : int;
		
		/**
		 * Returns the index of the last occurrence of an item.
		 * 
		 * @param item The item to test.
		 * @return The last position of the item or <code>-1</code> if the item is not contained.
		 */
		function lastIndexOf(item : *) : int;

		/**
		 * Returns the item at the specified position.
		 * 
		 * @param index The position of the item to get.
		 * @return The item or <code>undefined</code> if the position is invalid.
		 */
		function itemAt(index : uint) : *;
		
		/**
		 * Removes the item at the specified position.
		 * 
		 * @param index The position of the item to remove.
		 * @return The removed item or <code>undefined</code> if there is no item at that position.
		 */
		function removeAt(index : uint) : *;
	
		/**
		 * Removes a number of items starting at the specified position.
		 * 
		 * <p>If the given position exceeds the list size, the method aborts with <code>false</code>.</p>
		 * 
		 * <p>If the number of items exceeds the list size, the method
		 * removes all items starting at the given index.</p>
		 * 
		 * <p>Returns an empty array if the index is invalid.</p>
		 * 
		 * @param index The position of the first item to remove.
		 * @param numItems The number of items to remove.
		 * @return An array of all removed items.
		 */
		function removeAllAt(index : uint, numItems : uint) : Array;

	}

}
