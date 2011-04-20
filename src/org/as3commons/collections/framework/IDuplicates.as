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
	import org.as3commons.collections.framework.ICollection;

	/**
	 * Definition of a collection that may contain duplicates.
	 * 
	 * @author Jens Struwe 12.04.2010
	 */
	public interface IDuplicates extends ICollection {

		/**
		 * Returns the number of occurrences of an item.
		 * 
		 * @return Number of occurrences of the given item.
		 */
		function count(item : *) : uint;

		/**
		 * Removes all occurrences of a particular item from the collection.
		 * 
		 * <p>The items are removed in the order they are stored.</p>
		 * 
		 * @param item The item to remove completely from the collection.
		 * @return Number of items removed.
		 */
		function removeAll(item : *) : uint;

	}
}
