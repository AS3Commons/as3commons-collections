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
	 * Base map definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A map stores key-value-pairs and adresses its items over a key.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by a key.</li>
	 * <li>No predefined oder of items.</li>
	 * <li>May contain duplicates but no duplicate keys.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the <code>ICollection</code>, a map offers:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IMapIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Methods to handle duplicates (from <code>IDuplicates</code>).<br />
	 * <code>count(), removeAll()</code></li>
	 * <li>Key based inspection, retrieval and removal methods.<br />
	 * <code>hasKey(), itemFor(), replaceFor(), removeKey(), keysToArray()</code></li>
	 * <li>Adding of items.<br />
	 * <code>add()</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 17.03.2010
	 * @see ICollection ICollection interface - Detailed description of the base collection features.
	 */
	public interface IMap extends IDuplicates {
		
		/**
		 * Adds an item to the map.
		 * 
		 * <p>If the map already contains the given key, the method abords with <code>false</code>.</p>
		 * 
		 * <p>The <code>LinkedMap</code> appends the item.</p>
		 * 
		 * <p>The position of items that are added to a <code>SortedMap</code>
		 * depends on its sort order.</p>
		 * 
		 * @param key The key of the item to add.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function add(key : *, item : *) : Boolean;
		
		/**
		 * Replaces the item associated with the given key.
		 * 
		 * <p>If the key is not contained or the given item equals the item
		 * stored with the given key, the method abords with <code>false</code>.</p>
		 * 
		 * @param key The key.
		 * @param item The replacing item.
		 * @return <code>true</code> if the item has been replaced.
		 */
		function replaceFor(key : *, item : *) : Boolean;

		/**
		 * Returns <code>true</code> if the map contains the given key.
		 * 
		 * @param key The key to test.
		 * @return <code>true</code> if the key is contained.
		 */
		function hasKey(key : *) : Boolean;

		/**
		 * Returns the item associated with the given key.
		 * 
		 * @param key The key.
		 * @return The item if the key is contained, else <code>undefined</code>.
		 */
		function itemFor(key : *) : *;

		/**
		 * Returns an array of all keys in the order of the particular map.
		 * 
		 * <p>The order of keys in the array is the same as in the particular collection.</p>
		 * 
		 * @return An array of the keys of the map.
		 */
		function keysToArray() : Array;

		/**
		 * Returns an iterator over the keys of the map.
		 * 
		 * <p>The order of keys returned by the iterator is the same as in the particular collection.</p>
		 * 
		 * @return An iterator over the map keys.
		 */
		function keyIterator() : IIterator;

		/**
		 * Removes the given key and its associated item from the map.
		 * 
		 * <p>If the key is not contained the method abords with <code>undefined</code>.</p>
		 * @param key The key.
		 * @return The item associated with the removed key or <code>undefined</code> if the key is not contained.
		 */
		function removeKey(key : *) : *;

	}

}
