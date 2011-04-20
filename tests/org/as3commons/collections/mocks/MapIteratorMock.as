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
package org.as3commons.collections.mocks {
	import org.as3commons.collections.Map;
	import org.as3commons.collections.framework.core.MapIterator;
	import org.as3commons.collections.units.iterators.ITestIteratorNextPreviousLookup;

	/**
	 * @author Jens Struwe 01.04.2010
	 */
	public class MapIteratorMock extends MapIterator implements
		ITestIteratorNextPreviousLookup
	{
		public function MapIteratorMock(map : Map) {
			super(map);
		}

		public function get previousMock() : * {
			return _map.itemFor(previousKey);
		}
		
		public function get nextMock() : * {
			return _map.itemFor(nextKey);
		}

	}
}
