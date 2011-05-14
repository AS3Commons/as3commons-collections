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

	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.Map;
	import org.as3commons.collections.SortedMap;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IMap;

	/**
	 * Map builder using the builder pattern.
	 * 
	 * <p>Uses the builder Pattern to simplify the creation of new <code>IMap</code> instances in a fluent fashion.</p>
	 *  
	 * <p>Example: Creating a new <code>LinkedMap</code> instance using MapBuilder.</p>
	 * 
	 * <listing>
	 * 		const result : IMap = MapBuilder.newLinkedMap()
	 * 			.add("key1", "item-one")
	 * 			.add("key2", "item-two")
	 * 			.build();
	 * 		
	 * 		// Creates the following map: { key1 => item-one, key2 => item-two }
	 * 		trace(result);
	 * </listing>
	 * 
	 * @author John Reeves 14.04.2011
	 */
	public class MapBuilder {

		/**
		 * Backing <code>IMap</code> instance.
		 */
		private var _map : IMap;
		
		/**
		 * Starts the construction of a new <code>Map</code> instance.
		 * 
		 * @return a <code>MapBuilder</code> instance which will build and return an instance of <code>Map</code>
		 */
		public static function newMap() : MapBuilder {
			return new MapBuilder(new Map());
		}
		
		/**
		 * Starts construction of a new <code>LinkedMap</code> instance.
		 * 
		 * @return a <code>MapBuilder</code> instance which will build and return an instance of <code>LinkedMap</code>
		 */
		public static function newLinkedMap() : MapBuilder {
			return new MapBuilder(new LinkedMap());
		}
		
		/**
		 * Starts construction of a new <code>SortedMap</code> instance.
		 * 
		 * @param comparator The sort criterion which will be used by the resulting <code>SortedMap</code> instance.
		 * @return a <code>MapBuilder</code> instance which will build and return an instance of <code>SortedMap</code>
		 */
		public static function newSortedMap(comparator : IComparator) : MapBuilder {
			return new MapBuilder(new SortedMap(comparator));
		}
		
		/**
		 * Please make use of one of the static factory methods for creating a new <code>MapBuilder</code> instance.
		 * 
		 * @private
		 */
		public function MapBuilder(underlyingMap : IMap) {
			_map = underlyingMap;
		}
		
		/**
		 * Adds the supplied key and item mapping to the <code>IMap</code> under construction.
		 * 
		 * <p>Returns a reference to this <code>MapBuilder</code> instance.</p>
		 * 
		 * @param key to add to the map
		 * @param item to be mapped to the supplied key 
		 * @return a reference to this <code>MapBuilder</code> instance to allow method chaining.
		 */
		public function add(key : *, item : *) : MapBuilder {
			_map.add(key, item);
			return this;
		}
		
		/**
		 * Completes construction.
		 */
		public function build() : IMap {
			return _map;
		}
	}
}
