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
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISortedSet;
	import org.as3commons.collections.framework.core.SortedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;
	import org.as3commons.collections.mocks.SortedSetMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestComparator;
	import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
	import org.as3commons.collections.units.iterators.ISetIteratorTests;

	/**
	 * @author Jens Struwe 30.03.2010
	 */
	public class SortedSetIteratorTest extends AbstractIteratorTestCase {

		use namespace as3commons_collections;

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new SortedSetMock(new TestComparator());
		}

		override public function fillCollection(items : Array) : void {
			ISortedSet(collection).clear();
			
			for each (var item : * in items) {
				ISortedSet(collection).add(item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			
			var item : *;
			if (index) {
				var sortedSet : SortedSet = collection as SortedSet;
				var i : uint = 0;
				var node : SortedNode = sortedSet.mostLeftNode_internal();
			
				while (node) {
					if (i == index) {
						item = node.item;
						break;
					}
					node = sortedSet.nextNode_internal(node);
					i++;
				}
			}
			
			var iterator : ICollectionIterator = SortedSetMock(collection).iterator(item) as ICollectionIterator;
			if (index && item === undefined) iterator.end();
			
			return iterator;
		}

		override public function toArray() : Array {
			return ISortedSet(collection).toArray();
		}

		/*
		 * Units
		 */

		/*
		 * SetIterator tests
		 */

		public function test_setIterator() : void {
			new ISetIteratorTests(this).runAllTests();
		}

		/*
		 * StartIndexTests tests
		 */

		public function test_collectionIteratorStartIndex() : void {
			new ICollectionIteratorStartIndexTests(this).runAllTests();
		}

	}
}
