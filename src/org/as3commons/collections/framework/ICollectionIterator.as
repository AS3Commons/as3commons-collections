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
	 * Base collection iterator definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An <code>ICollectionIterator</code> is an iterator with extended navigation and
	 * modification possibilities.</p>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <ul>
	 * <li>Resetting the cursor before the first or after the last item.<br />
	 * <code>start(), end()</code></li>
	 * <li>Retrieving items in the back direction.<br />
	 * <code>hasPrevious(), previous()</code></li>
	 * <li>Caching of the last returned item.<br />
	 * <code>current</code></li>
	 * <li>Removing of items during the iteration.<br />
	 * <code>remove()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Cursor and current element</strong></p>
	 * 
	 * <p>The internal cursor of an <code>ICollectionIterator</code> can have n + 1 positions: Before the
	 * first item, between two items and after the last item. To each possible cursor position
	 * is a next and a previous item defined (except to the start and end position where either
	 * a next or a previous item is defined).</p>
	 * 
	 * <table class="innertable">
	 * 
	 * <tr>
	 * <th>Position</th>
	 * <th>Iterator state</th>
	 * </tr>
	 * 
	 * <tr>
	 * <td>At start</td>
	 * <td><pre> ^  1  2  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>Between two items</td>
	 * <td><pre> 1  2  ^  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>At end</td>
	 * <td><pre> 1  2  3  4  ^ </pre></td>
	 * </tr>
	 * 
	 * </table>
	 * ^ = cursor
	 * 
	 * <p>A current element is available only after a prior <code>next()</code> or
	 * <code>previous()</code> call. The current item is nullified after all operations
	 * that modify the underlying collection order (<code>add(), remove()</code>)
	 * or the cursor position (<code>start(), end()</code>).</p>
	 * 
	 * <table class="innertable">
	 * 
	 * <tr>
	 * <th>Operation</th>
	 * <th>Return value</th>
	 * <th>Current item</th>
	 * <th>Iterator state</th>
	 * </tr>
	 * 
	 * <tr>
	 * <td>initial</td>
	 * <td></td>
	 * <td>undefined</td>
	 * <td><pre> ^  1  2  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>next()</td>
	 * <td>1</td>
	 * <td>1</td>
	 * <td><pre>[1] ^  2  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>next()</td>
	 * <td>2</td>
	 * <td>2</td>
	 * <td><pre> 1 [2] ^  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>remove()</td>
	 * <td>true</td>
	 * <td>undefined</td>
	 * <td><pre> 1  ^  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>remove()</td>
	 * <td>false</td>
	 * <td>undefined</td>
	 * <td><pre> 1  ^  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>next()</td>
	 * <td>3</td>
	 * <td>3</td>
	 * <td><pre> 1 [3] ^  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>start()</td>
	 * <td></td>
	 * <td>undefined</td>
	 * <td><pre> ^  1  3  4 </pre></td>
	 * </tr>
	 * 
	 * </table>
	 * ^ = cursor, [n] = current
	 * 
	 * <p>Subsequent calls to <code>next()</code> and <code>previous()</code> return
	 * the same item repeatedly since the cursor is placed alternately after or before
	 * the item that is returned.</p>
	 * 
	 * <table class="innertable">
	 * 
	 * <tr>
	 * <th>Operation</th>
	 * <th>Return value</th>
	 * <th>Current item</th>
	 * <th>Iterator state</th>
	 * </tr>
	 * 
	 * <tr>
	 * <td>initial</td>
	 * <td></td>
	 * <td>undefined</td>
	 * <td><pre> 1  2  ^  3  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>next()</td>
	 * <td>3</td>
	 * <td>3</td>
	 * <td><pre> 1  2 [3] ^  4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>previous()</td>
	 * <td>3</td>
	 * <td>3</td>
	 * <td><pre> 1  2  ^ [3] 4 </pre></td>
	 * </tr>
	 * 
	 * <tr>
	 * <td>next()</td>
	 * <td>3</td>
	 * <td>3</td>
	 * <td><pre> 1  2 [3] ^  4 </pre></td>
	 * </tr>
	 * 
	 * </table>
	 * ^ = cursor, [n] = current
	 * 
	 * <p id="link_CollectionIteratorExample"><strong>Collection iterator example</strong></p>
	 * 
	 * {{EXAMPLE: CollectionIteratorExample}}
	 * 
	 * @author Jens Struwe 18.02.2010
	 * @see IIterator IIterator interface - Description of the basic iterator features.
	 */
	public interface ICollectionIterator extends IIterator {

		/**
		 * Returns <code>true</code> if there are preceeding items to be enumerated.
		 * 
		 * <p>Returns <code>false</code>, if the internal cursor is placed before the
		 * first item or the collection is empty.</p>
		 * 
		 * @return <code>true</code> if there are items left to be enumerated.
		 */
		function hasPrevious() : Boolean;
	
		/**
		 * Returns the previous item and places the internal cursor before that item. 
		 * 
		 * <p>Returnes <code>undefined</code> if no previous item exists or the collection is empty.</p>
		 * 
		 * @return The previous item of iteration or <code>undefined</code> if no such item exists.
		 */
		function previous() : *;
	
		/**
		 * The item that most recently has been returned by <code>next()</code>
		 * or <code>previous()</code>.
		 * 
		 * <p>Returns <code>undefined</code> if the iterator points to the postion before the first
		 * or after the last item or the collection is empty.</p>
		 * 
		 * <p>The current item is nullified after all operations that modify the underlying
		 * collection order (<code>add(), remove()</code>) or modify the cursor position
		 * (<code>start(), end()</code>).</p>
		 * 
		 * <p>Returns initially <code>undefined</code>.</p>
		 * 
		 * @return The last returned item or <code>undefined</code> if no such item.
		 */
		function get current() : *;

		/**
		 * Resets the iterator to the position before the first item.
		 * 
		 * <p>The first item of the collection is then returned with a subsequent
		 * call to <code>next()</code>.</p>
		 */
		function start() : void;

		/**
		 * Resets the iterator to the position after the last item.
		 * 
		 * <p>The last item of the collection is then returned with a subsequent
		 * call to <code>previous()</code>.</p>
		 */
		function end() : void;

		/**
		 * Removes the current item from the collection if any.
		 * 
		 * @return <code>true</code> if an item has been removed.
		 */
		function remove() : Boolean;

	}
}
