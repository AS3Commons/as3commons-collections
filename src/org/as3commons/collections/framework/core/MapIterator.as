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

	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.iterators.ArrayIterator;

	/**
	 * Internal <code>Map</code> iterator implementation.
	 * 
	 * @author Jens Struwe 01.04.2010
	 */
	public class MapIterator extends ArrayIterator implements IMapIterator {

		/**
		 * The map to enumerate.
		 */
		protected var _map : IMap;

		/**
		 * MapIterator constructor.
		 * 
		 * @param map The map to enumerate.
		 */
		public function MapIterator(map : IMap) {
			_map = map;
			super(_map.keysToArray());
		}
		
		/*
		 * IMapIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		public function get previousKey() : * {
			return _array[previousIndex];
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextKey() : * {
			return _array[_next];
		}
	
		/**
		 * @inheritDoc
		 */
		public function get key() : * {
			return super.current;
		}
	
		/*
		 * ICollectionIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		override public function previous() : * {
			return _map.itemFor(super.previous());
		}
	
		/**
		 * @inheritDoc
		 */
		override public function get current() : * {
			return _map.itemFor(super.current);
		}
	
		/**
		 * @inheritDoc
		 */
		override public function next() : * {
			return _map.itemFor(super.next());
		}
	
		/*
		 * Protected
		 */
		
		/**
		 * @inheritDoc
		 */
		override protected function removeCurrent() : void {
			_map.removeKey(super.current);
			super.removeCurrent();
		}
	}
}
