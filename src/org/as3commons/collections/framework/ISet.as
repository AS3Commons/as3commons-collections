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
	 * Base set definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A set cannot contain duplicate elements:</p>
	 * 
	 * <ul>
	 * <li>Elements are addressed by instance directly or sequentially accessed using an iterator.</li>
	 * <li>No predefined oder of items.</li>
	 * <li>Cannot contain duplicates.</li>
	 * </ul>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the <code>ICollection</code>, a set offers:</p>
	 * 
	 * <ul>
	 * <li>Rich sequential access using an <code>ISetIterator</code>.<br />
	 * <code>iterator()</code></li>
	 * <li>Adding of items.<br />
	 * <code>add()</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 17.03.2010
	 * @see ICollection ICollection interface - Detailed description of the base collection features.
	 */
	public interface ISet extends ICollection {

		/**
		 * Adds an item to the set.
		 * 
		 * <p>If the set already contains the given item, the method abords with <code>false</code>.</p>
		 * 
		 * <p>The <code>LinkedSet</code> appends the item.</p>
		 * 
		 * <p>The position of items that are added to a <code>SortedSet</code>
		 * depends on its sort order.</p>
		 * 
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function add(item : *) : Boolean;

	}

}
