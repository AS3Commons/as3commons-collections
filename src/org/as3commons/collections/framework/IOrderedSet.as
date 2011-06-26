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
	 * Insertion ordered set definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An ordered set is a set that orders its items by insertion.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by instance directly or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by insertion.</li>
	 * <li>Cannot contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic set definition, a ordered set provides:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IOrderedSetIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Order modification operations (from <code>IInsertionOrder</code>).<br />
	 * <code>sort(), reverse()</code></li>
	 * <li>Random adding or replacing of items.<br />
	 * <code>addFirst(), addLast(), addBefore(), addAfter(), replace()</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 18.03.2010
	 * @see ISet ISet interface - Detailed description of the basic set features.
	 */
	public interface IOrderedSet extends ISet, IInsertionOrder {

		/**
		 * Adds an item in front of the set.
		 * 
		 * <p>If the item is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addFirst(item : *) : Boolean;

		/**
		 * Adds an item at the end of the set.
		 * 
		 * <p>If the item is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addLast(item : *) : Boolean;

		/**
		 * Adds an item before an existing one.
		 * 
		 * <p>If the item is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param nextItem The item to add before.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addBefore(nextItem : *, item : *) : Boolean;
		
		/**
		 * Adds an item after an existing one.
		 * 
		 * <p>If the item is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param previousItem The item to add after.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addAfter(previousItem : *, item : *) : Boolean;

		/**
		 * Replaces an item. 
		 * 
		 * <p>The new item is added at the same position as the old item.</p>
		 * 
		 * <p>If the item is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param oldItem The item replace.
		 * @param item The replacing item.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function replace(oldItem: *, item : *) : Boolean;
		
		/**
		 * Returns the successor of the given item.
		 * 
		 * <p>If the item is not contained, the method returns <code>undefined</code>.</p>
		 * 
		 * @param item The item to get its successor.
		 * @return The predecessor or <code>undefined</code>.
		 */
		function next(item : *) : *;

		/**
		 * Returns the predecessor of the given item.
		 * 
		 * <p>If the item is not contained, the method returns <code>undefined</code>.</p>
		 * 
		 * @param item The item to get its predecessor.
		 * @return The predecessor or <code>undefined</code>.
		 */
		function previous(item : *) : *;

	}
}
