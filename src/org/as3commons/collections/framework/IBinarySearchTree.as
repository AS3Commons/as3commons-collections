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
	 * Binary search tree data structure definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A binary search tree is a sort ordered tree structure made up of
	 * tree nodes where each tree node has maximal exactly two children.
	 * The left child of a tree node is always lesser than its parent node.
	 * The right child of a tree node is always greater than its parent node.
	 * Adding, finding and removing of items can be done in logarithmic time.</p>
	 * 
	 * <li>Elements are addressed by instance directly or sequentially accessed using an iterator.</li>
	 * <li>Always ordered by a specific sort criterion.</li>
	 * <li>Cannot contain duplicates.</li>
	 * <li>Cannot contain multiple equal items (in difference to the <code>ISortedSet</code>).</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the <code>ICollection</code>, a binary search tree offers:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>IBinarySearchTreeIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Access to the first and the last element (from <code>IOrder</code>).<br />
	 * <code>first, last, removeFirst(), removeLast()</code></li>
	 * <li>Order related methods (from <code>ISortOrder</code>).<br />
	 * <code>hasEqual()</code></li>
	 * <li>Order related methods.<br />
	 * <code>lesser(), higher(), equalItem()</code></li>
	 * <li>Method to populate the tree.<br />
	 * <code>add()</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 31.03.2010
	 * @see ICollection ICollection interface - Detailed description of the base collection features.
	 */
	public interface IBinarySearchTree extends ISortOrder {

		/**
		 * Adds an item to the tree.
		 * 
		 * <p>If the tree already contains an item that is equal to the given one,
		 * the method abords with <code>false</code>.</p>
		 * 
		 * <p>Hence, if the tree already contains the given item, the method abords with <code>false</code>.</p>
		 * 
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function add(item : *) : Boolean;

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
		 * Returns the item that is equal to the given one.
		 * 
		 * <p>Returns of course the given item, if the item is contained.</p>
		 * 
		 * @param item The item to test.
		 * @return The equal item or <code>undefined</code> if there is no equal item.
		 */
		function equalItem(item : *) : *;

	}
}
