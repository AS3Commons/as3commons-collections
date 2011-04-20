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
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.iterators.ArrayIterator;

	/**
	 * Abstract list iterator implementation.
	 * 
	 * @author Jens Struwe 05.03.2010
	 */
	public class AbstractListIterator extends ArrayIterator implements IListIterator {
		
		use namespace as3commons_collections;

		/**
		 * The list to enumerate.
		 */
		protected var _list : AbstractList;
		
		/**
		 * ListIterator constructor.
		 * 
		 * <p>If <code>index</code> is specified, the iterator returns the item at that
		 * index with the first call to <code>next()</code> and the item at <code>index -1</code>
		 * with the first call to <code>previous()</code>.</p>
		 * 
		 * @param list The list to be enumerated.
		 * @param index Start position of enumeration.
		 */
		public function AbstractListIterator(list : AbstractList, index : uint = 0) {
			_list = list;

			super(_list.array_internal, index);
		}
		
		/*
		 * Protected
		 */

		/**
		 * @inheritDoc
		 */
		override protected function removeCurrent() : void {
			_list.removeAt(_current);
		}

	}
}
