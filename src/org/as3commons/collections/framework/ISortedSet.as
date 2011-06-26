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
	 * Sort ordered set definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A sorted set is a set that orders its items by a sort criterion.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by instance directly or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by a specific sort criterion.</li>
	 * <li>Cannot contain duplicates.</li>
	 * <li>May contain multiple equal items.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic set definition, a sorted set provides:</p>
	 * 
	 * <ul>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Order related methods (from <code>ISortOrder</code>).<br />
	 * <code>hasEqual()</code></li>
	 * <li>Order related methods.<br />
	 * <code>lesser(), higher(), equalItems()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Note</strong></p>
	 * 
	 * <p>The sort algorithm of a sorted set is stable. Multiple equal items are sorted in the
	 * order they are added.</p>
	 * 
	 * @author Jens Struwe 18.03.2010
	 * @see ISet ISet interface - Detailed description of the basic set features.
	 */
	public interface ISortedSet extends ISet, ISortOrder {

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

		/**
		 * Returns the last item that is lesser than the given item.
		 * 
		 * @param item The item to test.
		 * @return The last lesser item or <code>undefined</code> if there is no lesser item.
		 */
		function lesser(item : *) : *;

		/**
		 * Returns the first item that is higher than the given item.
		 * 
		 * @param item The item to test.
		 * @return The next higher item or <code>undefined</code> if there is no higher item.
		 */
		function higher(item : *) : *;

		/**
		 * Returns an array of all items that are equal to the given item.
		 * 
		 * <p>If there is no equal item, the method returns an empty array.</p>
		 * 
		 * @param item The item to test.
		 * @return An array of all equal items.
		 */
		function equalItems(item : *) : Array;

	}
}
