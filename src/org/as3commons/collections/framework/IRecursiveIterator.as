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
	 * Recursive iterator definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A recursive iterator enables the recursive enumeration of an iterable data structure,
	 * where the contained elements are either also iterable or single items.</p>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>This interface adds a recursion <code>depth</code> information to the <code>IIterable</code> definition.</p>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>There are 2 resursive iterators provided by this library. The <code>RecursiveIterator</code>
	 * returns all items of a recursive structure. The <code>RecursiveFilterIterator</code> lets
	 * apply a filter function and returns only items that pass this filter.</p>
	 * 
	 * <p>A recursive iterator does not have the ability to modify its underlying data structure.</p>
	 * 
	 * <p>A recursive iterator recognises recursions and skips the iteration over items
	 * that are direct or later children of itself.</p>
	 * 
	 * @author Jens Struwe 17.02.2010
	 * @see IIterator IIterator interface - Description of the basic iterator features.
	 * @see org.as3commons.collections.iterators.RecursiveIterator RecursiveIterator - RecursiveIterator usage example.
	 * @see org.as3commons.collections.iterators.RecursiveFilterIterator RecursiveFilterIterator - RecursiveFilterIterator usage example.
	 */
	public interface IRecursiveIterator extends IIterator {

		/**
		 * The recursion depth of the current item.
		 */
		function get depth() : uint;

	}
}
