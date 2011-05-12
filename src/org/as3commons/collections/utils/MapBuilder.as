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
	import org.as3commons.collections.framework.IMapIterator;

	/**
	 * <p>Uses the Builder Pattern to simplify the creation of new IMap instances in a fluent fashion.</p>
	 *  
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
		
		public function addAll(...args) : MapBuilder {
			var wrapper : AsArgs;
			var item : *;
			for (var i : uint; i < args.length; i++) {
				if (args[i] is AsArgs) {
					wrapper = args[i];
					if (wrapper.source is Array) return addFromArray(wrapper.source as Array);
					else if (wrapper.source is IMap) return addFromMap(wrapper.source as IMap);
					else if (wrapper.source is Object) return addFromObject(wrapper.source);

				} else {
					// skip key without item
					if (i == args.length - 1) break;
					// ignore args wrapper for items
					item = args[i + 1] is AsArgs ? args[i + 1] : AsArgs(args[i + 1]).source;
					_map.add(args[i], item);
					i++;
				}
			}
			return this;
		}
		
		public function addFromArray(array : Array) : MapBuilder {
			for (var i : uint; i < array.length; i+=2) {
				if (i == array.length - 1) break;
				_map.add(array[i], array[i + 1]);
			}
			return this;
		}

		public function addFromMap(map : IMap) : MapBuilder {
			var iterator : IMapIterator = map.iterator() as IMapIterator;
			while (iterator.next() !== undefined) {
				_map.add(iterator.key, iterator.current);
			} 
			return this;
		}

		public function addFromObject(object : Object) : MapBuilder {
			for (var key : * in object) {
				_map.add(key, object[key]);
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
