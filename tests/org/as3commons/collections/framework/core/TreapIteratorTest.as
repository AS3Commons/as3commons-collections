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

	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.mocks.TreapMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestComparator;
	import org.as3commons.collections.units.iterators.ICollectionIteratorTests;
	import org.as3commons.collections.units.iterators.IIteratorNextPreviousLookupTests;

	/**
	 * @author Jens Struwe 30.03.2010
	 */
	public class TreapIteratorTest extends AbstractIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new TreapMock(new TestComparator());
		}

		override public function fillCollection(items : Array) : void {
			TreapMock(collection).clear();
			
			for each (var item : * in items) {
				TreapMock(collection).add(item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			return TreapMock(collection).iterator();
		}

		override public function toArray() : Array {
			return TreapMock(collection).toArray();
		}

		/*
		 * Units
		 */

		/*
		 * CollectionIterator tests
		 */

		public function test_collectionIterator() : void {
			new ICollectionIteratorTests(this).runAllTests();
		}

		/*
		 * NextPreviousLookup tests
		 */

		public function test_nextPreviousLookup() : void {
			new IIteratorNextPreviousLookupTests(this).runAllTests();
		}
	}
}
