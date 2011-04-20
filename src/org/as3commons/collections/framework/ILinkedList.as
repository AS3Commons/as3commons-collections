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
	 * Linked list data structure definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A linked list is an ordered sequence of items made up of mutually linking nodes.
	 * Insertion and removal operations at start, in between or at end only require
	 * constant time regardless of the size of the list.</p>
	 * 
	 * <ul>
	 * <li>Elements are accessed sequentially using an iterator.</li>
	 * <li>Always ordered by insertion.</li>
	 * <li>May contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic collection definition, the <code>LinkedList</code> provides:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IListIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Order modification operations (from <code>IInsertionOrder</code>).<br />
	 * <code>sort(), reverse()</code></li>
	 * <li>Methods to handle duplicates (from <code>IDuplicates</code>).<br />
	 * <code>count(), removeAll()</code></li>
	 * <li>Random adding of items.<br />
	 * <code>add(), addFirst(), addLast()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>A linked does not implement the <code>IList</code> interface since it does not provide
	 * index based access to its items.</p>
	 * 
	 * <p>The internal node structure is hidden to the user and cannot be accessed.</p>
	 * 
	 * @author Jens Struwe 04.03.2010
	 * @see ICollection ICollection interface - Detailed description of the base collection features.
	 */
	public interface ILinkedList extends IInsertionOrder, IDuplicates {

		/**
		 * Adds an item at the end of the list.
		 * 
		 * @param item The item to add.
		 */
		function add(item : *) : void;

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

	}
}
