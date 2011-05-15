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
package org.as3commons.collections.utils {
	import org.as3commons.collections.framework.IComparator;

	/**
	 * Null comparator.
	 * 
	 * <p>This comparator is being used as the default comparator for sorted collections
	 * if no comparator has been specified else.</p>
	 * 
	 * <p>Using this comparator results in an insertion order.</p>
	 * 
	 * @author Jens Struwe 14.05.2011
	 * @see org.as3commons.collections.framework.IComparator IComparator interface - Description of the comparator features.
	 */
	public class NullComparator implements IComparator {
		
		/**
		 * Compares two items and returns 0.
		 * 
		 * @param item1 The first item.
		 * @param item1 The second item.
		 * @return <code>0</code>.
		 */
		public function compare(item1 : *, item2 : *) : int {
			return 0;
		}

	}
}
