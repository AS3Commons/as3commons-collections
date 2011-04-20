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
	 * Insertion ordered list iterator definition.
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>An <code>IOrderedListIterator</code> provides additionally to the base list iterator:</p>
	 * 
	 * <ul>
	 * <li>Insertion operations.<br />
	 * <code>addBefore(), addAfter()</code></li>
	 * <li>Replacing of items.<br />
	 * <code>replace()</code></li></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 08.03.2010
	 * @see IListIterator IListIterator interface - Detailed description of the base list iterator features.
	 */
	public interface IOrderedListIterator extends IListIterator {

		/**
		 * Adds an item before the current cursor position.
		 * 
		 * <p>The item added will be returned with a subsequent call to <code>previous()</code>.</p>
		 * 
		 * @param item The item to add.
		 * @return The position where the item has been added.
		 */
		function addBefore(item : *) : uint;

		/**
		 * Adds an item after the current cursor position.
		 * 
		 * <p>The item added will be returned with a subsequent call to <code>next()</code>.</p>
		 * 
		 * @param item The item to add.
		 * @return The position where the item has been added.
		 */
		function addAfter(item : *) : uint;

		/**
		 * Replaces the current item if any.
		 * 
		 * <p>If the iterator has no current item or the replacing item
		 * strictly equals the existing one, this method aborts with <code>false</code>.</p>
		 * 
		 * @param item The replacing item.
		 * @return <code>true</code> if the current item has been replaced.
		 */
		function replace(item : *) : Boolean;

	}
}
