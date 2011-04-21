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
package org.as3commons.collections.utils.shortcut {

	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.utils.Lists;

	/**
	 * Creates, populates and returns a new <code>ArrayList</code> instance.
	 * 
	 * <p>The arguments may be left out. In that case no item is added to the list.</p>
	 * 
	 * <listing>
			var list : ArrayList = newarraylist(item1, item2, ...);
	 * </listing>
	 * 
	 * @param List of items to add to the list.
	 * @return A new <code>ArrayList</code> instance populated from the given arguments.
	 * @author Jens Struwe 21.04.2011
	 */
	public function newarraylist(...args) : ArrayList {
		var list : ArrayList = new ArrayList();
		args.unshift(list);
		Lists.populate.apply(null, args);
		return list;
	}

}
