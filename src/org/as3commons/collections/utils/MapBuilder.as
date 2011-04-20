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
	 * <p>Uses the Builder Pattern to simplify the creation of new IMap instances in a fluent fashion.</p>
	 *  
	 * @author John Reeves.
	 * @example Creating a new LinkedMap instance using MapBuilder.
	 * &lt;listing version="3.0"&gt;
	 * 		const result : IMap = MapBuilder.linkedMap()
	 * 			.add("key1", "item-one")
	 * 			.add("key2", "item-two")
	 * 			.build();
	 * 		
	 * 		// Creates the following Map: { key1 => item-one, key2 => item-two }
	 * 		trace(result);
	 * &lt;/listing&gt;
	 * 
	 * @author John Reeves 14.04.2011
	 */
	public class MapBuilder {

		/**
		 * <p>Backing IMap instance which will be modified during Builder operation.</p>
		 */
		private var _map : IMap;
		
		/**
		 * <p>Starts the construction of a new Map instance</p>
		 * 
		 * @return a MapBuilder instance which will build and return an instance of Map
		 */
		public static function map() : MapBuilder {
			return new MapBuilder(new Map());
		}
		
		/**
		 * <p>Starts construction of a new LinkedMap instance.</p>
		 * 
		 * @return a MapBuilder instance which will build and return an instance of LinkedMap
		 */
		public static function linkedMap() : MapBuilder {
			return new MapBuilder(new LinkedMap());
		}
		
		/**
		 * <p>Starts construction of a new SortedMap instance which makes use of the supplied comparator.</p>
		 * 
		 * @param comparator the sort criterion which will be used by the resulting SortedMap instance.
		 * @return a MapBuilder instance which will build and return an instance of SortedMap
		 */
		public static function sortedMap(comparator : IComparator) : MapBuilder {
			return new MapBuilder(new SortedMap(comparator));
		}
		
		/**
		 * <p>Please make use of one of the static factory methods for creating a new MapBuilder instance.</p>
		 * @private
		 */
		public function MapBuilder(underlyingMap : IMap) {
			_map = underlyingMap;
		}
		
		/**
		 * <p>Adds the supplied key and item mapping to the IMap under construction, returns a reference 
		 * to this MapBuilder instance.</p>
		 * 
		 * @param key to add to the map
		 * @param item to be mapped to the supplied key 
		 * @return a reference to this MapBuilder instance to allow method chaining.
		 */
		public function add(key : *, item : *) : MapBuilder {
			_map.add(key, item);
			return this;
		}
		
		/**
		 * Adds the supplied supplied list of key-item-pairs to the IMap under construction, returns a reference 
		 * to this MapBuilder instance.
		 * 
		 * <listing>
				mapBuilder.addMany(key1, item1, key2, item2, ...);
		 * </listing>
		 * 
		 * @param List of key-item-pairs to add to the map
		 * @param item to be mapped to the supplied key 
		 * @return a reference to this MapBuilder instance to allow method chaining.
		 */
		public function addMany(...args) : MapBuilder {
			for (var i : uint; i < args.length; i+=2) {
				if (i == args.length - 1) break;
				_map.add(args[i], args[i + 1]);
			}
			return this;
		}

		/**
		 * <p>Completes construction.</p>
		 */
		public function build() : IMap {
			return _map;
		}
	}
}
