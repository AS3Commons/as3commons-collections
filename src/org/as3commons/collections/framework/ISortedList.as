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
	 * Sort ordered list definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A sorted list is a list that orders its items by a sort criterion.</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by an index or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by a specific sort criterion.</li>
	 * <li>May contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Addionally to or refining the basic list definition, a sorted list provides:</p>
	 * 
	 * <ul>
	 * <li>Order related methods (from <code>ISortOrder</code>).<br />
	 * <code>hasEqual()</code></li>
	 * <li>Order related methods.<br />
	 * <code>lesserIndex(), higherIndex(), equalIndices()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Note</strong></p>
	 * 
	 * <p>The sort algorithm of a sorted list is stable. Multiple equal items are sorted in the
	 * order they are added.</p>
	 * 
	 * @author Jens Struwe 18.03.2010
	 * @see IList IList interface - Detailed description of the basic list features.
	 */
	public interface ISortedList extends IList, ISortOrder {

		/**
		 * Returns the index of the last item that is lesser than the given item.
		 * 
		 * @param item The item to test.
		 * @return The index of the last lesser item or <code>-1</code> if there is no lesser item.
		 */
		function lesserIndex(item : *) : int;

		/**
		 * Returns the index of the first item that is higher than the given item.
		 * 
		 * @param item The item to test.
		 * @return The index of the next higher item or <code>-1</code> if there is no higher item.
		 */
		function higherIndex(item : *) : int;
		
		/**
		 * Returns an array of the indices of all items that are equal to the given item.
		 * 
		 * <p>If there is no equal item, the method returns an empty array.</p>
		 * 
		 * @param item The item to test.
		 * @return An array of the indices of all equal items.
		 */
		function equalIndices(item : *) : Array;

	}
}
