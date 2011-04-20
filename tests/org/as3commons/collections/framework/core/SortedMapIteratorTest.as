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
	import org.as3commons.collections.SortedMap;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISortedMap;
	import org.as3commons.collections.framework.core.SortedMapNode;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.mocks.SortedMapMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestComparator;
	import org.as3commons.collections.testhelpers.UniqueMapKey;
	import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
	import org.as3commons.collections.units.iterators.IMapIteratorTests;

	/**
	 * @author Jens Struwe 30.03.2010
	 */
	public class SortedMapIteratorTest extends AbstractIteratorTestCase {

		use namespace as3commons_collections;

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new SortedMapMock(new TestComparator());
		}

		override public function fillCollection(items : Array) : void {
			SortedMapMock(collection).clear();
			for each (var item : * in items) {
				SortedMapMock(collection).add(UniqueMapKey.key, item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			var key : *;
			if (index) {
				var sortedMap : SortedMap = collection as SortedMap;
				var i : uint = 0;
				var node : SortedNode = sortedMap.mostLeftNode_internal();
			
				while (node) {
					if (i == index) {
						key = SortedMapNode(node).key;
						break;
					}
					node = sortedMap.nextNode_internal(node);
					i++;
				}
			}
			
			var iterator : ICollectionIterator = SortedMapMock(collection).iterator(key) as ICollectionIterator;
			if (index && key === undefined) iterator.end();
			
			return iterator;
		}

		override public function toArray() : Array {
			return ISortedMap(collection).toArray();
		}

		/*
		 * Units
		 */

		/*
		 * MapIterator tests
		 */

		public function test_mapIterator() : void {
			new IMapIteratorTests(this).runAllTests();
		}

		/*
		 * StartIndexTests tests
		 */

		public function test_collectionIteratorStartIndex() : void {
			new ICollectionIteratorStartIndexTests(this).runAllTests();
		}

	}
}
