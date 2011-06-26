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
	 * Sort ordered map definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A sorted map is a map that orders its items by a sort criterion.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by a key or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by a specific sort criterion.</li>
	 * <li>May contain duplicates but no duplicate keys.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic map definition, a sorted map provides:</p>
	 * 
	 * <ul>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Order related methods (from <code>ISortOrder</code>).<br />
	 * <code>hasEqual()</code></li>
	 * <li>Order related methods.<br />
	 * <code>lesserKey(), higherKey(), equalKeys()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>In difference to other sorted map implementations (e.g. the Java TreeMap),
	 * a <code>ISortedMap</code> instance sorts over its values and not over its keys.</p>
	 * 
	 * <p>The sort algorithm of a sorted map is stable. Multiple equal items are sorted in the
	 * order they are added.</p>
	 * 
	 * @author Jens Struwe 18.03.2010
	 * @see IMap IMap interface - Detailed description of the basic map features.
	 */
	public interface ISortedMap extends IMap, ISortOrder {

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

		/**
		 * Returns the key of the last item that is lesser than the given item.
		 * 
		 * @param item The item to test.
		 * @return The key of the last lesser item or <code>undefined</code> if there is no lesser item.
		 */
		function lesserKey(item : *) : *;

		/**
		 * Returns the key of the first item that is higher than the given item.
		 * 
		 * @param item The item to test.
		 * @return The key of the next higher item or <code>undefined</code> if there is no higher item.
		 */
		function higherKey(item : *) : *;

		/**
		 * Returns an array of the keys of all items that are equal to the given item.
		 * 
		 * <p>If there is no equal item, the method returns an empty array.</p>
		 * 
		 * @param item The item to test.
		 * @return An array of the keys of all equal items.
		 */
		function equalKeys(item : *) : Array;

	}
}
