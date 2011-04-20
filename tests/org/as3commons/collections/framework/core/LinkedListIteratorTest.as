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
	import org.as3commons.collections.framework.ILinkedList;
	import org.as3commons.collections.framework.ILinkedListIterator;
	import org.as3commons.collections.mocks.LinkedListMock;
	import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
	import org.as3commons.collections.units.iterators.ICollectionIteratorTests;
	import org.as3commons.collections.units.iterators.IIteratorInsertionOrderTests;
	import org.as3commons.collections.units.iterators.IIteratorNextPreviousLookupTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class LinkedListIteratorTest extends AbstractIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function createCollection() : * {
			return new LinkedListMock();
		}

		override public function fillCollection(items : Array) : void {
			ILinkedList(collection).clear();
			
			for each (var item : * in items) {
				ILinkedList(collection).add(item);
			}
		}

		override public function getIterator(index : uint = 0) : IIterator {
			return ILinkedList(collection).iterator(index);
		}

		override public function toArray() : Array {
			return ILinkedList(collection).toArray();
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
		 * IIteratorInsertionOrderTests tests
		 */

		public function test_iteratorInsertionOrder() : void {
			new IIteratorInsertionOrderTests(this).runAllTests();
		}

		/*
		 * NextPreviousLookup tests
		 */

		public function test_nextPreviousLookup() : void {
			new IIteratorNextPreviousLookupTests(this).runAllTests();
		}

		/*
		 * ILinkedListIterator
		 */

		/*
		 * Initial state
		 */

		public function test_init() : void {
			assertTrue(getIterator() is ILinkedListIterator);
		}

	}
}
