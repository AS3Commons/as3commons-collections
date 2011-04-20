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
	import org.as3commons.collections.SetTest;
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.mocks.SetFxMock;
	import org.as3commons.collections.units.fx.ICollectionFxTests;

	/**
	 * @author Jens Struwe 26.03.2010
	 */
	public class SetFxTest extends SetTest {

		/*
		 * AbstractCollectionTest
		 */

		override public function createCollection() : ICollection {
			return new SetFxMock();
		}

		/*
		 * Units
		 */

		/*
		 * CollectionFx tests
		 */

		public function test_collection_fx() : void {
			new ICollectionFxTests(this).runAllTests();
		}

	}
}
