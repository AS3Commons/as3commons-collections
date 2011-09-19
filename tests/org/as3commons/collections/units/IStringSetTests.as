/**
 * Copyright 2010-2011 The original author or authors.
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
package org.as3commons.collections.units {

	import org.as3commons.collections.units.ISetTests;
	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;

	/**
	 * @author Jens Struwe 19.09.2011
	 */
	public class IStringSetTests extends ISetTests {
		public function IStringSetTests(test : AbstractCollectionTestCase) {
			super(test);
		}

		/*
		 * Exclude mixed typed key tests
		 */

		override public function test_remove_wrongItem_mixedItems() : void {
		}

		override public function test_add_mixedItems() : void {
		}

		override public function test_has_mixedItems() : void {
		}

		override public function test_clear_mixedItems() : void {
		}

		override public function test_add_itemTwice_mixedItems() : void {
		}

		override public function test_has_wrongKey_mixedItems() : void {
		}

		override public function test_toArray_mixedItems() : void {
		}

		override public function test_remove_mixedItems() : void {
		}

		override public function test_add_mixedTypes() : void {
		}

	}
}
