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
	 * Iterable data structure definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>Any object implementing <code>IIterable</code> can be sequentially enumerated using an iterator.</p>
	 * 
	 * <p>Any <code>IIterable</code> instance can then also be recursively iterated using an <code>IRecursiveIterator</code>
	 * implementation (<code>RecursiveIterator, RecursiveFilterIterator</code>) or convenient filtered using
	 * a filter iterator (<code>FilterIterator, RecursiveFilterIterator</code>).</p>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The iterator obtained by the <code>iterator()</code> method returns always the actual item added
	 * to the data structure regardless of the specific internal storage such as Node, MapEntry
	 * and so on.</p>
	 * 
	 * <p>The iterator of an <code>IIterable</code> instance returned by the <code>iterator()</code>
	 * method is always a basic <code>IIterator</code>. Subtypes of this interface may return here a
	 * specialised iterator with richer functionality (such as adding or removing of items during
	 * an iteration loop). It is then possible to downcast the returned iterator to the specialised
	 * iterator type.</p>
	 *    
	 * <p id="link_IteratorDowncastExample"><strong>Iterator downcast example</strong></p>
	 * 
	 * {{EXAMPLE: IteratorDowncastExample}}
	 * 
	 * @author Jens Struwe 17.03.2010
	 * @see org.as3commons.collections.iterators.RecursiveIterator RecursiveIterator - Recursive iterator usage example.
	 * @see org.as3commons.collections.iterators.RecursiveFilterIterator RecursiveFilterIterator - Recursive filter iterator usage example.
	 * @see org.as3commons.collections.iterators.FilterIterator FilterIterator - Filter iterator usage example.
	 */
	public interface IIterable {

		/**
		 * Returns an iterator over the iterable data structure.
		 * 
		 * <p>The <code>cursor</code> parameter is optional and not considered by all iterable
		 * data structures. E.g. the iterator of an unordered collection such as <code>Map</code>
		 * or <code>Set</code> starts always with the first item found. Still passing a parameter to
		 * such a data structure does not throw an error and will simply show no effect.</p>
		 * 
		 * <p>The type of the cursor is unspecified and depends on the particular data structure.
		 * E.g. lists allow to specify an index, sets to specify an item and maps to specify a key.</p>
		 * 
		 * <p>If <code>cursor</code> is specified, the iterator returns the item that is related
		 * to that cursor with the first call to <code>next()</code> (and its predecessor with
		 * the first call to <code>previous()</code> if the iterator allows bidirectional
		 * navigation.</p>
		 * 
		 * @param cursor The initial cursor position.
		 * @return An iterator.
		 */
		function iterator(cursor : * = undefined) : IIterator;

	}
}
