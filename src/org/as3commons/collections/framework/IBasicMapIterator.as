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

	import org.as3commons.collections.framework.IIterator;

	/**
	 * Base map iterator iterator definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An <code>IMapIterator</code> is an extended <code>IIterator</code> available
	 * for all map collections.</p>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>Additionally to the base iterator the <code>IMapIterator</code>
	 * provides information about the key of the item:</p>
	 * 
	 * <ul>
	 * <li>Key of the last returned item.<br />
	 * <code>key</code></li>
	 * </ul>
	 * 
	 * @author Jens Struwe 15.04.2011
	 * @see IIterator IIterator interface - Description of the basic iterator features.
	 * 
	 * @TODO Rename to IMapIterator while IMapIterator has to be renamed to IMapCollectionIterator.
	 */
	public interface IBasicMapIterator extends IIterator {

		/**
		 * The key of the last returned item.
		 * 
		 * <p><code>undefined</code> if the iterator points to the postion before the first
		 * or after the last item or the map is empty.</p>
		 * 
		 * <p>The key is reset to <code>undefined</code> after all operations that modify the underlying
		 * map order (<code>add(), remove()</code>) or modify the cursor position
		 * (<code>start(), end()</code>).</p>
		 * 
		 * <p>Initially <code>undefined</code>.</p>
		 */
		function get key() : *;

	}
}
