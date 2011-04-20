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
	 * Insertion ordered list definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An ordered list is a list that orders its items by insertion.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by an index or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by insertion.</li>
	 * <li>May contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic list definition, a ordered list provides:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IOrderedListIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Order modification operations (from <code>IInsertionOrder</code>).<br />
	 * <code>sort(), reverse()</code></li>
	 * <li>Random adding or replacing of items.<br />
	 * <code>addFirst(), addLast(), addAt(), addAllAt(), replaceAt()</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 17.02.2010
	 * @see IList IList interface - Detailed description of the basic list features.
	 */
	public interface IOrderedList extends IList, IInsertionOrder {
		
		/**
		 * Adds an item in front of the list.
		 * 
		 * @param item The item to add.
		 */
		function addFirst(item : *) : void;

		/**
		 * Adds an item at the end of the list.
		 * 
		 * @param item The item to add.
		 */
		function addLast(item : *) : void;

		/**
		 * Adds an item at a specific position.
		 * 
		 * <p>If the given position exceeds the list size, the method
		 * aborts with <code>false</code>.</p>
		 * 
		 * @param index The position of the new item.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addAt(index : uint, item : *) : Boolean;

		/**
		 * Adds an array of items at a specific position.
		 * 
		 * <p>If the given position exceeds the list size, the method aborts
		 * with <code>false</code>.</p>
		 * 
		 * @param index The position of the items to add.
		 * @param items An array of items to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addAllAt(index : uint, items : Array) : Boolean;
		
		/**
		 * Replaces the item at the specified position.
		 * 
		 * <p>If the item at the position strictly equals the given item or the index
		 * exceeds the list length, this method aborts with <code>false</code>.</p>
		 * 
		 * @param index The position of the item to replace.
		 * @param item The replacing item.
		 * @return <code>true</code> if the item has been replaced.
		 */
		function replaceAt(index : uint, item : *) : Boolean;

	}

}
