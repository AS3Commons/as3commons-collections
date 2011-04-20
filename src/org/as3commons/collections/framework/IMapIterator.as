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
	 * Base map iterator iterator definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An <code>IMapIterator</code> is an extended <code>IBasicMapIterator</code> and
	 * <code>ICollectionIterator</code> available for all map collections.</p>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the base map iterator the <code>IMapIterator</code>
	 * provides information about the current iterator position. The <code>IMapIterator</code>
	 * provides all functionality of the <code>ICollectionIterator</code>.</p>
	 * 
	 * <ul>
	 * <li>Lookup for the key of the next or previous item.<br />
	 * <code>nextKey, previousKey</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 18.03.2010
	 * @see IBasicMapIterator IBasicMapIterator interface - Detailed description of the base map iterator features.
	 * @see ICollectionIterator ICollectionIterator interface - Detailed description of the base collection iterator features.
	 * 
	 * @TODO Rename to IMapCollectionIterator while IBasicMapIterator has to be renamed to IMapIterator.
	 */
	public interface IMapIterator extends ICollectionIterator, IBasicMapIterator {
		
		/**
		 * The key of the item left to the current cursor position.
		 * 
		 * <p>The item stored under this key is returned with the next call
		 * to <code>previous()</code>.</p>
		 * 
		 * <p><code>undefined</code> if the iterator is positioned at start or
		 * the map is emtpy.</p>
		 */
		function get previousKey() : *;

		/**
		 * The key of the item right to the current cursor position.
		 * 
		 * <p>The item stored under this key is returned with the next call
		 * to <code>next()</code>.</p>
		 * 
		 * <p><code>undefined</code> if the iterator is positioned at end or
		 * the map is emtpy.</p>
		 */
		function get nextKey() : *;
		
	}
}
