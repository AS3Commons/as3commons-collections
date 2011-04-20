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
	 * Definition of a collection whose items are stored in a stable (insertion or sort) order. 
	 * 
	 * @author Jens Struwe 12.04.2010
	 */
	public interface IOrder extends ICollection {

		/**
		 * The first item or <code>undefined</code> if the collection is empty.
		 */
		function get first() : *;

		/**
		 * The last item or <code>undefined</code> if the collection is empty.
		 */
		function get last() : *;
		
		/**
		 * Removes the first item of the ordered collection.
		 * 
		 * @return The formerly first item or <code>undefined</code> if the collection is empty.
		 */
		function removeFirst() : *;

		/**
		 * Removes the last item of the ordered collection.
		 * 
		 * @return The formerly last item or <code>undefined</code> if the collection is empty.
		 */
		function removeLast() : *;

	}
}
