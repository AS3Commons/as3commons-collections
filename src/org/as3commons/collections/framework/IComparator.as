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
	 * Comparator definition.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>A comparator defines the order of items in sorted collections or in sort operations.</p>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>To setup a comparator it is necessary to create a new class which
	 * implements this interface.</p>
	 * 
	 * <p>Two basic comparators are provided by this library. A <code>StringComparator</code> in
	 * order to sort string literals and a <code>NumericComparator</code> to sort numbers.</p>
	 * 
	 * <p id="link_ComparatorImplementationExample"><strong>Comparator implementation example</strong></p>
	 * 
	 * {{EXAMPLE: ComparatorImplementationExample}}
	 * 
	 * @author Jens Struwe 17.02.2010
	 * @see org.as3commons.collections.utils.NumericComparator NumericComparator - Numeric comparator implementation.
	 * @see org.as3commons.collections.utils.StringComparator StringComparator - Literal comparator implementation.
	 */
	public interface IComparator {

		/**
		 * Compares two items.
		 * 
		 * <p>There are two requirements to implementations of this method.</p>
		 * <ol>
		 * <li>The method is supposed to throw an exception, if an item cannot be
		 * compared due to a type mismatch. In such a case the sort operation
		 * cannot be performed, which is a critical error.</li>
		 * <li>Comparing a wrong typed item with oneself should throw an error.
		 * Adding a wrong typed item as the first element in a still empty sorted
		 * structure (such as <code>Treap</code> or <code>SortedList</code>) would
		 * be successful without that exception, since there is no comparision
		 * to other elements, that could fail. Thus, the sorted structures test
		 * the initial item against itself.</li>
		 * </ol>
		 * 
		 * @param item1 The first operant.
		 * @param item1 The second operant.
		 * @returns <code>-1</code> if the first operant is lesser, <code>1</code> if greater
		 * and <code>0</code> if both items are equal.
		 * @throws org.as3commons.collections.utils.UncomparableType if eather of the items cannot be compared.
		 */
		function compare(item1 : *, item2 : *) : int;

	}
}
