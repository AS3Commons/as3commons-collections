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
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.testhelpers.TestComparator;
	import org.as3commons.collections.units.iterators.IIteratorTests;

	/**
	 * @author Jens Struwe 14.04.2010
	 */
	public class SortedMapKeyIteratorTest extends AbstractIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new SortedMap(new TestComparator());
		}

		override public function fillCollection(items : Array) : void {
			SortedMap(collection).clear();
			for each (var item : * in items) {
				SortedMap(collection).add(item, item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			return SortedMap(collection).keyIterator();
		}

		override public function toArray() : Array {
			return SortedMap(collection).keysToArray();
		}

		/*
		 * Units
		 */

		/*
		 * IIterator tests
		 */

		public function test_iterator() : void {
			new IIteratorTests(this).runAllTests();
		}

	}
}
