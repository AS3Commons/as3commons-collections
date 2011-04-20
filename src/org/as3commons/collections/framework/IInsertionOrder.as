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
	import org.as3commons.collections.framework.IComparator;

	/**
	 * Definition of a collection that enables precise control over where items are inserted.
	 * 
	 * @author Jens Struwe 09.04.2010
	 */
	public interface IInsertionOrder extends IOrder {
		
		/**
		 * Reverses the collection order.
		 * 
		 * <p>If the collection size is less than 2, the method aborts with <code>false</code>.</p>
		 * 
		 * @return <code>true</code> if the collection has been reversed.
		 */
		function reverse() : Boolean;

		/**
		 * Sorts the linked collection using the given comparator.
		 * 
		 * <p>The sort algorithm used by implementors of this interface is stable which
		 * means that equal items are sorted in the same order they had before the sorting.</p>
		 * 
		 * <p>If the collection size is less than 2, the method aborts with <code>false</code>.</p>
		 * 
		 * @param comparator The sort criterion.
		 * @return <code>true</code> if the linked collection has been sorted.
		 */
		function sort(comparator : IComparator) : Boolean;

	}
}
