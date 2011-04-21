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

	import org.as3commons.collections.framework.IList;

	/**
	 * <p>A set of common utilities for working with IList implementations.</p>
	 * 
	 * @author Jens Struwe 21.04.2011
	 */
	public class Lists {

		/**
		 * Adds the supplied supplied list of items to the given list.
		 * 
		 * <p>The arguments may be left out. In that case no item is added to the list.</p>
		 * 
		 * <listing>
				Lists.populate(myList, item1, item2, ...);
		 * </listing>
		 * 
		 * @param list The list to be populated.
		 * @param List of items to add to the list.
		 */
		public static function populate(list : IList, ...args) : void {
			for (var i : uint; i < args.length; i++) {
				list.add(args[i]);
			}
		}

	}
}
