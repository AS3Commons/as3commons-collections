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
package org.as3commons.collections {
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.mocks.MapMock;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.IMapTests;

	/**
	 * @author Jens Struwe 23.03.2010
	 */
	public class MapTest extends AbstractCollectionTestCase {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new MapMock();
		}

		override public function fillCollection(items : Array) : void {
			collection.clear();
			for each (var item : * in items) {
				Map(collection).add(UniqueMapKey.key, item);
			}
		}

		/*
		 * Units
		 */

		/*
		 * Map tests
		 */

		public function test_map() : void {
			new IMapTests(this).runAllTests();
		}

	}
}
