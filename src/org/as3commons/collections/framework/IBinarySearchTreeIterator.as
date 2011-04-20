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
	 * Binary search tree data structure iterator definition.
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the base collection iterator the <code>IBinarySearchTreeIterator</code>
	 * provides information about the item at the current iterator position:</p>
	 * 
	 * <ul>
	 * <li>Lookup for the next or previous item.<br />
	 * <code>nextItem, previousItem</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 01.04.2010
	 * @see ICollectionIterator ICollectionIterator interface - Detailed description of the base collection iterator features.
	 */
	public interface IBinarySearchTreeIterator extends ICollectionIterator {

		/**
		 * The item left to the current cursor position.
		 * 
		 * <p><code>undefined</code> if the iterator is positioned at start or
		 * the tree is emtpy.</p>
		 */
		function get previousItem() : *;

		/**
		 * The item right to the current cursor position.
		 * 
		 * <p><code>undefined</code> if the iterator is positioned at end or
		 * the tree is emtpy.</p>
		 */
		function get nextItem() : *;

	}
}
