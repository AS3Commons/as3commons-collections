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
	import org.as3commons.collections.testhelpers.AbstractSpecialIteratorTestCase;
	import org.as3commons.collections.units.iterators.FilterIteratorTests;
	import org.as3commons.collections.units.iterators.IIteratorTests;

	/**
	 * @author Jens Struwe 19.03.2010
	 */
	public class FilterIteratorTest extends AbstractSpecialIteratorTestCase {

		/*
		 * AbstractIteratorTest
		 */

		override public function getIterator(index : uint = 0) : IIterator {
			return new FilterIterator(collection, null);
		}

		override public function getFilterIterator() : IIterator {
			return new FilterIterator(collection, filter);
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
		 * FilterIterator tests
		 */

		public function test_filterIterator() : void {
			new FilterIteratorTests(this).runAllTests();
		}

	}
}
