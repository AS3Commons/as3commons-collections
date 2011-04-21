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

	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.utils.Maps;

	/**
	 * Creates, populates and returns a new <code>LinkedMap</code> instance.
	 * 
	 * <p>The arguments may be left out. In that case no item is added to the map.</p>
	 * 
	 * <p>The last argument is skipped if the size of arguments is not even.</p>
	 * 
	 * <listing>
			var map : Map = map(key1, item1, key2, item2, ...);
	 * </listing>
	 * 
	 * @param List of key-item-pairs to add to the map.
	 * @return map A new <code>LinkedMap</code> instance populated from the given arguments.
	 * @author Jens Struwe 21.04.2011
	 */
	public function newlinkedmap(...args) : LinkedMap {
		var map : LinkedMap = new LinkedMap();
		args.unshift(map);
		Maps.populate.apply(null, args);
		return map;
	}

}
