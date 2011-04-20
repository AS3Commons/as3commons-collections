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
	 * Base collection definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>This is the base definition of all collections in this library. A collection is defined
	 * as a data structure with a generalised interface.</p>
	 * 
	 * <ul>
	 * <li>Elements are accessed (at least) sequentially accessed using an iterator.</li>
	 * <li>No predefined oder of items.</li>
	 * <li>May or may not contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Each collection in this library provides:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>ICollectionIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Current size information (in constant time).<br />
	 * <code>size</code></li>
	 * <li>Conversion into an array.<br />
	 * <code>toArray()</code></li>
	 * <li>Existance test and removal of items (by instance).<br />
	 * <code>has(), remove()</code></li>
	 * <li>Removing of the entire content.<br />
	 * <code>clear()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Collection types and subinterfaces</strong></p>
	 * 
	 * <p>A collection can be classified by different criterias.</p>
	 * 
	 * <p><u>Access type</u></p>
	 * 
	 * <p>All collections enable sequential access using an iterator. Lists, sets and maps
	 * additionally provide (constant time) access using a unique identifier.</p>
	 *
	 * <ul>
	 * <li><code>ICollection</code> - Items can be always sequentially accessed using an iterator.</li>
	 * <li><code>IList</code> - Items can be accessed using an (unique) index.</li>
	 * <li><code>ISet</code> - Items can be accessed using the (unique) item itself.</li>
	 * <li><code>IMap</code> - Items can be accessed using a (unique) key.</li>
	 * </ul>
	 * 
	 * <p><u>Order of items</u></p>
	 * 
	 * <p>The <code>ICollection</code> interface does not prescribe the order in which items
	 * are stored or returned.</p>
	 * 
	 * <ul>
	 * <li><code>ICollection</code> - Items may have an order (or not).</li>
	 * <li><code>IOrder</code> - Items are ordered - either by insertion or by a sort order.</li>
	 * <li><code>IInsertionOrder</code> - Items are stored in the order they were inserted.</li>
	 * <li><code>ISortOrder</code> - Items are ordered depending on a sort criterion.</li>
	 * </ul>
	 * 
	 * <p><u>Multiplicity of items</u></p>
	 * 
	 * <p>The <code>ICollection</code> interface does not prescribe whether a collection
	 * is permitted to host mulitple entries of the same instance (or not).</p>
	 * 
	 * <ul>
	 * <li><code>ICollection</code> - Duplicates may be allowed (or not).</li>
	 * <li><code>IDuplicateItemsCollection</code> - Duplicates are explicitly permitted.</li>
	 * </ul>
	 * 
	 * <p><u>Binding capabilities</u></p>
	 * 
	 * <p>Certain collections (all lists, sets and maps) are offered in an additional bindable
	 * version which enables the external tracking of its state in a performant way.</p>
	 * 
	 * <ul>
	 * <li><code>ICollection</code> - Bindable (or not).</li>
	 * <li><code>ICollectionFx</code> - Bindable.</li>
	 * </ul>
	 * 
	 * @author Jens Struwe 17.03.2010
	 */
	public interface ICollection extends IIterable {

		/**
		 * The number of items contained by the collection.
		 */
		function get size() : uint;

		/**
		 * Tests if an item is contained by the collection.
		 * 
		 * @param item The item to test.
		 * @return <code>true</code> if the item is contained.
		 */
		function has(item : *) : Boolean;

		/**
		 * Returns an array of all items.
		 * 
		 * <p>The order of items in the array is the same as in the particular collection.</p>
		 * 
		 * <p>Certain collections do not have an explicit order (<code>Map</code>, <code>Set</code>).
		 * The order of the items in the array is then not predictable.</p>  
		 * 
		 * <p>If the collection maintains an array as its data source, a copy
		 * of the internal array is returned rather than the original array.</p>
		 * 
		 * @return An array of the items of the collection.
		 */
		function toArray() : Array;
		
		/**
		 * Removes an item from the collection.
		 * 
		 * <p>Trying to remove an item which is not contained by the collection
		 * leaves the collection untouched and returns <code>false</code>.</p>
		 * 
		 * <p>If the collection contains multiple entries of the given item
		 * the first occurrence of the item will be removed.</p>
		 * 
		 * @param item The item to remove.
		 * @return <code>true</code> if the item has been removed.
		 */
		function remove(item : *) : Boolean;

		/**
		 * Removes all items from the collection.
		 * 
		 * <p>If the collection is already empty, the method aborts with <code>false</code>.</p>
		 * 
		 * @return <code>true</code> if items have been removed.
		 */
		function clear() : Boolean;

	}
}
