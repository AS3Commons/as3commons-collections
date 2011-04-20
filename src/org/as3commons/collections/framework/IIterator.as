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
	 * Base iterator definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>An <code>IIterator</code> provides basic sequential access to its underlying
	 * data structure while hiding the specific implementation aspects.</p>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>An iterator basically does not have the ability to modify its associated structure. However,
	 * subtypes of this interface may add such functionality.</p>
	 * 
	 * <p>The order in which the iterator returns the items of the iterable data structure
	 * depends on the particular data structure implementation. Unordered collection such as
	 * <code>Map</code> or <code>Set</code> do not have a predictable order and the order of
	 * items returned by two iterators of the same collection may differ.</p>
	 * 
	 * <p>Iterators generally do not take notice if the associated data structure changes. Modifying the
	 * structure within an iteration loop (except through the iterator) may cause unpredictable results.</p>
	 *    
	 * @author Jens Struwe 17.02.2010
	 * @see ICollectionIterator ICollectionIterator interface - Description of the feature richer collection iterator features.
	 */
	public interface IIterator {

		/**
		 * Returns <code>true</code> if there are succeeding items to be enumerated.
		 * 
		 * <p>Returns <code>false</code>, if the internal cursor is placed after the
		 * last item or the collection is empty.</p>
		 * 
		 * @return <code>true</code> if there are items left to be enumerated.
		 */
		function hasNext() : Boolean;
	
		/**
		 * Returns the next item and places the internal cursor after that item.
		 * 
		 * <p>Returnes <code>undefined</code> if no next item exists or the collection is empty.</p>
		 * 
		 * @return The next item of iteration or <code>undefined</code> if no such item exists.
		 */
		function next() : *;

	}
}
