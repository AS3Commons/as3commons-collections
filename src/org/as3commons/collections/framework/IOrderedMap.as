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
	 * Insertion ordered map definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An ordered map is a map that orders its items by insertion.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by a key or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by insertion.</li>
	 * <li>May contain duplicates but no duplicate keys.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic map definition, an ordered map provides:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IOrderedMapIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Order modification operations (from <code>IInsertionOrder</code>).<br />
	 * <code>sort(), reverse()</code></li>
	 * <li>Random adding of items.<br />
	 * <code>addFirst(), addLast(), addBefore(), addAfter()</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 18.03.2010
	 * @see IMap IMap interface - Detailed description of the basic map features.
	 */
	public interface IOrderedMap extends IMap, IInsertionOrder {

		/**
		 * Adds an item in front of the map.
		 * 
		 * <p>If the key is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param item The item to add.
		 * @param key The key of the item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addFirst(key : *, item : *) : Boolean;

		/**
		 * Adds an item at the end of the map.
		 * 
		 * <p>If the key is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param item The item to add.
		 * @param key The key of the item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addLast(key : *, item : *) : Boolean;

		/**
		 * Adds an item before an existing one.
		 * 
		 * <p>If the key is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param nextKey The key of the item to add before.
		 * @param item The item to add.
		 * @param key The key of the item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addBefore(nextKey : *, key : *, item : *) : Boolean;
		
		/**
		 * Adds an item after an existing one.
		 * 
		 * <p>If the key is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * @param previousKey The key of the item to add after.
		 * @param item The item to add.
		 * @param key The key of the item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addAfter(previousKey : *, key : *, item : *) : Boolean;

		/**
		 * Returns the key of the first item, if any.
		 * 
		 * <p>If the key is not contained, the method returns <code>undefined</code>.</p>
		 * 
		 * @return The key of the first item or <code>undefined</code>.
		 */
		function get firstKey() : *;

		/**
		 * Returns the key of the last item, if any.
		 * 
		 * <p>If the key is not contained, the method returns <code>undefined</code>.</p>
		 * 
		 * @return The key of the last item or <code>undefined</code>.
		 */
		function get lastKey() : *;

		/**
		 * Returns the key of the successor of the item mapped to the given key.
		 * 
		 * <p>If the key is not contained, the method returns <code>undefined</code>.</p>
		 * 
		 * @param item The key of item to get its successing key.
		 * @return The key of the predecessor or <code>undefined</code>.
		 */
		function nextKey(key : *) : *;

		/**
		 * Returns the key of the predecessor of the item mapped to the given key.
		 * 
		 * <p>If the key is not contained, the method returns <code>undefined</code>.</p>
		 * 
		 * @param item The key of item to get its predecessing key.
		 * @return The key of the predecessor or <code>undefined</code>.
		 */
		function previousKey(key : *) : *;

	}
}
