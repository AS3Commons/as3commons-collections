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
	 * Insertion ordered map iterator definition.
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>An <code>IOrderedMapIterator</code> provides additionally to the base map iterator:</p>
	 * 
	 * <ul>
	 * <li>Insertion operations.<br />
	 * <code>addBefore(), addAfter()</code></li>
	 * <li>Replacing of items.<br />
	 * <code>replace()</code></li></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 10.03.2010
	 * @see IMapIterator IMapIterator interface - Detailed description of the base map iterator features.
	 */
	public interface IOrderedMapIterator extends IMapIterator {

		/**
		 * Adds an item before the current cursor position.
		 * 
		 * <p>If the key is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * <p>The item added will be returned with a subsequent call to <code>previous()</code>.</p>
		 * 
		 * @param key The key of the item to add.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addBefore(key : *, item : *) : Boolean;

		/**
		 * Adds an item after the current cursor position.
		 * 
		 * <p>If the key is already contained, the method aborts with <code>false</code>.</p>
		 * 
		 * <p>The item added will be returned with a subsequent call to <code>next()</code>.</p>
		 * 
		 * @param key The key of the item to add.
		 * @param item The item to add.
		 * @return <code>true</code> if the item has been added.
		 */
		function addAfter(key : *, item : *) : Boolean;

		/**
		 * Replaces the current item if any.
		 * 
		 * <p>The key of the old item points now to the given item.</p>
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
