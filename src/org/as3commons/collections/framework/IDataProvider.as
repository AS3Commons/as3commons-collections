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
	 * Data provider definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A data provider is a data structure with a known size and an index
	 * based read access. The data provider interface is required by data
	 * driven user interface controls.</p>
	 * 
	 * <p><strong>Note</strong></p>
	 * 
	 * <p>This library provides only two implementors of this interface (<code>ArrayList,
	 * SortedList</code>).</p>
	 * 
	 * @author Jens Struwe 09.03.2010
	 */
	public interface IDataProvider {
		
		/**
		 * The number of items contained by the data provider.
		 */
		function get size() : uint;
		
		/**
		 * Returns the item at the specified position.
		 * 
		 * @param index The position of the item to get.
		 * @return The item or <code>undefined</code> if the position is invalid.
		 */
		function itemAt(index : uint) : *;

	}
	
}
