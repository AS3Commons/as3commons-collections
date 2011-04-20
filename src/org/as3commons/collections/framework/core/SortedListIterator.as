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
package org.as3commons.collections.framework.core {
	import org.as3commons.collections.SortedList;
	import org.as3commons.collections.framework.core.AbstractListIterator;

	/**
	 * Internal <code>SortedList</code> iterator implementation.
	 * 
	 * @author Jens Struwe 01.04.2010
	 */
	public class SortedListIterator extends AbstractListIterator {
		
		/**
		 * SortedListIterator constructor.
		 * 
		 * <p>If <code>index</code> is specified, the iterator returns the item at that
		 * index with the first call to <code>next()</code> and the item at <code>index -1</code>
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param array The list.
		 * @param index Start position of enumeration.
		 */
		public function SortedListIterator(sortedList : SortedList, index : uint = 0) {
			super(sortedList, index);
		}
	}
}
