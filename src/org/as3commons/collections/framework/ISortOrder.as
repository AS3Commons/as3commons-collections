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
	 * Definition of a collection whose items are stored in a sorted order. 
	 * 
	 * @author Jens Struwe 09.04.2010
	 */
	public interface ISortOrder extends IOrder {
		
		/**
		 * @private
		 */
		function set comparator(comparator : IComparator) : void;

		/**
		 * Returns or sets the initial comparator of the collection.
		 * 
		 * <p>You cannot reset a comparator of a collection that contains items.
		 * In that case an <code>ArgumentError</code> is thrown.</p>
		 * 
		 * @throws ArgumentError if set to a collection with a size > 0.
		 */
		function get comparator() : IComparator;

		/**
		 * Tests if the collection contains an item that is equal to the given item.
		 * 
		 * <p>Returns of course <code>true</code> if the given item is contained.</p>
		 * 
		 * @param item The item to test.
		 * @return <code>true</code> if there is an equal item contained.
		 */
		function hasEqual(item : *) : Boolean;

	}
}
