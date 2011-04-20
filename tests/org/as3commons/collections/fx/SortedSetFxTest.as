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
package org.as3commons.collections.fx {
	import org.as3commons.collections.SortedSetTest;
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.mocks.SortedSetFxMock;
	import org.as3commons.collections.testhelpers.TestComparator;
	import org.as3commons.collections.units.fx.ICollectionFxTests;
	import org.as3commons.collections.units.fx.ISortOrderFxTests;

	/**
	 * @author Jens Struwe 30.03.2010
	 */
	public class SortedSetFxTest extends SortedSetTest {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new SortedSetFxMock(new TestComparator());
		}

		/*
		 * Units
		 */

		/*
		 * Collection tests
		 */

		public function test_set_fx() : void {
			new ICollectionFxTests(this).runAllTests();
		}

		/*
		 * Order tests
		 */

		public function test_order_fx() : void {
			new ISortOrderFxTests(this).runAllTests();
		}

	}
}
