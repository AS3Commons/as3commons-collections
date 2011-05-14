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
package org.as3commons.collections.iterators {

	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IRecursiveIterator;
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorTestCase;
	import org.as3commons.collections.units.iterators.FilterIteratorTests;
	import org.as3commons.collections.units.iterators.IIteratorTests;
	import org.as3commons.collections.units.iterators.RecursiveIteratorTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class RecursiveFilterIterator2Test extends AbstractSpecialIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function getIterator(index : uint = 0) : IIterator {
			return new RecursiveFilterIterator2(collection, null, null);
		}

		override public function getFilterIterator() : IIterator {
			return new RecursiveFilterIterator2(collection, filter, null);
		}

		override public function getRecursiveIterator() : IRecursiveIterator {
			return new RecursiveFilterIterator2(collection, null, null);
		}

		/*
		 * Units
		 */

		/*
		 * Iterator tests
		 */

		public function test_iterator() : void {
			new IIteratorTests(this).runAllTests();
		}

		/*
		 * RecursiveIterator
		 */

		public function test_recursiveIterator() : void {
			new RecursiveIteratorTests(this).runAllTests();
		}

		/*
		 * FilterIterator tests
		 */

		public function test_filterIterator() : void {
			new FilterIteratorTests(this).runAllTests();
		}

		/*
		 * RecursiveFilterIterator2
		 */

		private var list : Node;
		private var list0 : Node;
		private var list0_0 : Node;
		private var list0_0_0 : Node;
		private var list0_0_1 : Node;
		private var list0_1 : Node;
		private var list0_1_0 : Node;
		private var list0_1_1 : Node;
		private var list1 : Node;
		private var list1_0 : Node;
		private var list1_0_0 : Node;
		private var list1_1 : Node;
		private var list2 : Node;
		private var list2_0 : Node;
		private var list3 : Node;
		
		override public function setUp() : void {
			super.setUp();
			setUpList();
		}
	
		override public function tearDown() : void {
			super.tearDown();
			list = null;
		}

		/*
		 * Private
		 */
	
		private function getRecursiveFilterIterator(flagFilter : String = "", flagChildren : String = "") : IRecursiveIterator {
			return new RecursiveFilterIterator2(
				list,
				flagFilter ? flagFilter == "true" ? trueFilter : falseFilter : null,
				flagChildren ? flagChildren == "true" ? trueChildrenFilter : falseChildrenFilter : null
			);
		}

		private function trueFilter(item : *) : Boolean {
			return Node(item).active == true;
		}

		private function falseFilter(item : *) : Boolean {
			return Node(item).active == false;
		}

		private function trueChildrenFilter(item : *) : Boolean {
			return Node(item).active == true;
		}
	
		private function falseChildrenFilter(item : *) : Boolean {
			return Node(item).active == false;
		}

		private function setUpList() : void {

			list = new Node("list");
			list0 = new Node("list0");
			list0_0 = new Node("list0_0");
			list0_0_0 = new Node("list0_0_0");
			list0_0_1 = new Node("list0_0_1");
			list0_1 = new Node("list0_1");
			list0_1_0 = new Node("list0_1_0");
			list0_1_1 = new Node("list0_1_1");
			list1 = new Node("list1");
			list1_0 = new Node("list1_0");
			list1_0_0 = new Node("list1_0_0");
			list2 = new Node("list2");
			list2_0 = new Node("list2_0");
			list3 = new Node("list3");

			list.add(list0);
				list0.add(list0_0);
					list0_0.add(list0_0_0);
					list0_0.add(list0_0_1);
				list0.add(list0_1);
					list0_1.add(list0_1_0);
					list0_1.add(list0_1_1);
			list.add(list1);
				list1.add(list1_0);
					list1_0.add(list1_0_0);
			list.add(list2);
				list2.add(list2_0);
			list.add(list3);
		}
		
		/*
		 * Filter tests
		 */

		public function test_filter() : void {
			
			setUpList();
			
			var iterator : IRecursiveIterator = getRecursiveFilterIterator(null, null);
			
			var result : Array = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			var expectedResult : Array = [
				list0,
					list0_0,
						list0_0_0,
						list0_0_1,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
					list1_0,
						list1_0_0,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));
			
			list0_0_1.active = false;
			list1_0_0.active = false;

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0, // false
						list0_0_0,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1, // false
					list1_0,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));
			
			list0_0.active = false;
			list1.active = false;

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
						list0_0_0,
					list0_1,
						list0_1_0,
						list0_1_1,
					list1_0,
				list2,
					list2_0, // false
				list3 // false
			];

			assertTrue(validateItems(expectedResult, result));
			
			list3.active = false;
			list2_0.active = false;

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
						list0_0_0,
					list0_1,
						list0_1_0, // false
						list0_1_1, // false
					list1_0,
				list2
			];

			assertTrue(validateItems(expectedResult, result));

			list0_1_0.active = false;
			list0_1_1.active = false;

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0, // false
						list0_0_0,
					list0_1,
					list1_0,
				list2
			];

			assertTrue(validateItems(expectedResult, result));
			
			list0.active = false;

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
						list0_0_0,
					list0_1,
					list1_0,
				list2 // false
			];

			assertTrue(validateItems(expectedResult, result));
			
			list2.active = false;

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
						list0_0_0,
					list0_1,
					list1_0,
			];

			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("false", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			//list0, // false
			//	list0_0, // false
			//		list0_0_0,
			//		list0_0_1, // false
			//	list0_1,
			//		list0_1_0, // false
			//		list0_1_1, // false
			//list1, // false
			//	list1_0,
			//		list1_0_0, // false
			//list2, // false
			//	list2_0, // false
			//list3 // false

			expectedResult = [
				list0, // false
					list0_0, // false
						list0_0_1, // false
						list0_1_0, // false
						list0_1_1, // false
				list1, // false
						list1_0_0, // false
				list2, // false
					list2_0, // false
				list3 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

		}
		
		public function test_filter2() : void {
			
			list = new Node("list");
				list0 = new Node("list0");
					list0_0 = new Node("list0_0", false);
						list0_0_0 = new Node("list0_0_0");
						list0_0_1 = new Node("list0_0_1");
					list0_1 = new Node("list0_1");
						list0_1_0 = new Node("list0_1_0");
						list0_1_1 = new Node("list0_1_1");
				list1 = new Node("list1");
					list1_0 = new Node("list1_0");
					list1_0_0 = new Node("list1_0_0");
				list2 = new Node("list2");
					list2_0 = new Node("list2_0");
				list3 = new Node("list3");

			list.add(list0);
				list0.add(list0_0);
					list0_0.add(list0_0_0);
					list0_0.add(list0_0_1);
				list0.add(list0_1);
					list0_1.add(list0_1_0);
					list0_1.add(list0_1_1);
			list.add(list1);
				list1.add(list1_0);
					list1_0.add(list1_0_0);
			list.add(list2);
				list2.add(list2_0);
			list.add(list3);
			
			// return only items of "true" and respect only children of items that are "true"
			var iterator : IRecursiveIterator = getRecursiveFilterIterator("true", "true");
			
			var result : Array = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			var expectedResult : Array = [
				list0,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
					list1_0,
						list1_0_0,
				list2,
					list2_0,
				list3
			];
			
			assertEquals(10, result.length);
			assertTrue(validateItems(expectedResult, result));
			
		}

		public function test_filter3() : void {
			
			list = new Node("list");
				list0 = new Node("list0");
					list0_0 = new Node("list0_0", false);
						list0_0_0 = new Node("list0_0_0");
						list0_0_1 = new Node("list0_0_1");
					list0_1 = new Node("list0_1");
						list0_1_0 = new Node("list0_1_0");
						list0_1_1 = new Node("list0_1_1");
				list1 = new Node("list1");
					list1_0 = new Node("list1_0");
					list1_0_0 = new Node("list1_0_0");
				list2 = new Node("list2");
					list2_0 = new Node("list2_0");
				list3 = new Node("list3");

			list.add(list0);
				list0.add(list0_0);
					list0_0.add(list0_0_0);
					list0_0.add(list0_0_1);
				list0.add(list0_1);
					list0_1.add(list0_1_0);
					list0_1.add(list0_1_1);
			list.add(list1);
				list1.add(list1_0);
					list1_0.add(list1_0_0);
			list.add(list2);
				list2.add(list2_0);
			list.add(list3);
			
			// return only items of "true" and respect children of all active statuses
			var iterator : IRecursiveIterator = getRecursiveFilterIterator("true", null);
			
			var result : Array = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			var expectedResult : Array = [
				list0,
						list0_0_0,
						list0_0_1,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
					list1_0,
						list1_0_0,
				list2,
					list2_0,
				list3
			];
			
			assertEquals(12, result.length);
			assertTrue(validateItems(expectedResult, result));
		}

		public function test_filter4() : void {
			
			list = new Node("list");
				list0 = new Node("list0");
					list0_0 = new Node("list0_0");
					list0_1 = new Node("list0_1", false);
				list1 = new Node("list1", false);
					list1_0 = new Node("list1_0");
					list1_1 = new Node("list1_1", false);

			list.add(list0);
				list0.add(list0_0);
				list0.add(list0_1);
			list.add(list1);
				list1.add(list1_0);
				list1.add(list1_1);
				
//			list0,
//				list0_0,
//				list0_1, // false
//			list1, // false
//				list1_0, 
//				list1_1 // false
			
			// NULL, NULL

			var iterator : IRecursiveIterator = getRecursiveFilterIterator(null, null);
			
			var result : Array = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			var expectedResult : Array = [
				list0,
					list0_0,
					list0_1, // false
				list1, // false
					list1_0, 
					list1_1 // false
			];
			
			assertTrue(validateItems(expectedResult, result));
			
			// TRUE, NULL

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0,
					list1_0
			];
			
			assertTrue(validateItems(expectedResult, result));

			// FALSE, NULL

			iterator = getRecursiveFilterIterator("false", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
					list0_1, // false
				list1, // false
					list1_1 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

			// TRUE, TRUE

			iterator = getRecursiveFilterIterator("true", "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0
			];
			
			assertTrue(validateItems(expectedResult, result));

			// FALSE, TRUE

			iterator = getRecursiveFilterIterator("false", "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
					list0_1, // false
				list1 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

			// NULL, TRUE

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0,
					list0_1, // false
				list1 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

			// NULL, FALSE

			iterator = getRecursiveFilterIterator(null, "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
				list1, // false
					list1_0, 
					list1_1 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

			// TRUE, FALSE

			iterator = getRecursiveFilterIterator("true", "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list1_0, 
			];
			
			assertTrue(validateItems(expectedResult, result));

			// FALSE, FALSE

			iterator = getRecursiveFilterIterator("false", "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list1, // false
					list1_1 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

		}

		public function test_childrenFilter() : void {
			
			setUpList();
			
			var iterator : IIterator = getRecursiveFilterIterator(null, null);
			
			var result : Array = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			var expectedResult : Array = [
				list0,
					list0_0,
						list0_0_0,
						list0_0_1,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
					list1_0,
						list1_0_0,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));
			
			list0_0_1.active = false;
			list1_0_0.active = false;

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0,
						list0_0_0,
						list0_0_1,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
					list1_0,
						list1_0_0,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));
			
			list0_0.active = false;
			list1.active = false;
			
			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
				list2,
					list2_0,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));
			
			list3.active = false;
			list2_0.active = false;

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));

			list0_1_0.active = false;
			list0_1_1.active = false;

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0,
					list0_1,
						list0_1_0,
						list0_1_1,
				list1,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));
			
			list0.active = false;

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
				list1,
				list2,
					list2_0,
				list3
			];

			assertTrue(validateItems(expectedResult, result));
			
			list2.active = false;

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
				list1,
				list2,
				list3
			];

			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator(null, "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			//list0, // false
			//	list0_0, // false
			//		list0_0_0,
			//		list0_0_1, // false
			//	list0_1,
			//		list0_1_0, // false
			//		list0_1_1, // false
			//list1, // false
			//	list1_0,
			//		list1_0_0, // false
			//list2, // false
			//	list2_0, // false
			//list3 // false

			expectedResult = [
				list0,
					list0_0,
						list0_0_0,
						list0_0_1,
					list0_1,
				list1,
					list1_0,
				list2,
					list2_0,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

		}

		public function test_filterAndChildrenFilter() : void {
			
			setUpList();
			
			list0_0.active = false;
			list0_1_0.active = false;
			list1.active = false;
			list1_0.active = false;
			list2.active = false;

			var iterator : IIterator = getRecursiveFilterIterator(null, null);
			
			var result : Array = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			var expectedResult : Array = [
				list0,
					list0_0, // false
						list0_0_0,
						list0_0_1,
					list0_1,
						list0_1_0, // false
						list0_1_1,
				list1, // false
					list1_0, // false
						list1_0_0,
				list2, // false
					list2_0,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("true", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
						list0_0_0,
						list0_0_1,
					list0_1,
						list0_1_1,
						list1_0_0,
					list2_0,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("false", null);
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
					list0_0, // false
						list0_1_0, // false
				list1, // false
					list1_0, // false
				list2, // false
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator(null, "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_0, // false
					list0_1,
						list0_1_0, // false
						list0_1_1,
				list1, // false
				list2, // false
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("true", "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
					list0_1,
						list0_1_1,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("false", "true");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
					list0_0, // false
						list0_1_0, // false
				list1, // false
				list2 // false
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator(null, "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
				list1, // false
					list1_0, // false
						list1_0_0,
				list2, // false
					list2_0,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("true", "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list0,
						list1_0_0,
					list2_0,
				list3
			];
			
			assertTrue(validateItems(expectedResult, result));

			iterator = getRecursiveFilterIterator("false", "false");
			
			result = new Array();
			while (iterator.hasNext()) {
				result.push(iterator.next());
			}
			
			expectedResult = [
				list1, // false
					list1_0, // false
				list2, // false
			];
			
			assertTrue(validateItems(expectedResult, result));

		}

	}
}

import org.as3commons.collections.ArrayList;

internal class Node extends ArrayList {
	public var name : String;
	public var active : Boolean = true;
	public function Node(theName : String, theActive : Boolean = true) {
		super();
		name = theName;
		active = theActive;
	}
	public function toString() : String {
		return name + " " + active;
	}
}
