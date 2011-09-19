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

	import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;

	/**
	 * @author Jens Struwe 19.09.2011
	 */
	public class IStringMapTests extends IMapTests {
		public function IStringMapTests(test : AbstractCollectionTestCase) {
			super(test);
		}
		
		/*
		 * Exclude mixed typed key tests
		 */
		
		override public function test_add_objectKeys() : void {
		}
		
		override public function test_add_mixedKeys() : void {
		}
		
		override public function test_add_keyTwice_objectKeys() : void {
		}

		override public function test_add_keyTwice_mixedKeys() : void {
		}
		
		override public function test_add_itemTwice_objectKeys() : void {
		}
		
		override public function test_add_itemTwice_mixedKeys() : void {
		}
		
		override public function test_replaceKey_objectKeys() : void {
		}

		override public function test_replaceKey_mixedKeys() : void {
		}
		
		override public function test_replaceKey_sameValue_objectKeys() : void {
		}
		
		override public function test_replaceKey_sameValue_mixedKeys() : void {
		}
		
		override public function test_replaceKey_wrongKey_objectKeys() : void {
		}

		override public function test_replaceKey_wrongKey_mixedKeys() : void {
		}

		override public function test_hasKey_mixedKeys() : void {
		}
		
		override public function test_hasKey_wrongKey_mixedKeys() : void {
		}

		override public function test_itemFor_mixedKeys() : void {
		}

		override public function test_itemFor_wrongKey_mixedKeys() : void {
		}

		override public function test_keysToArray_objectKeys() : void {
		}

		override public function test_keysToArray_mixedKeys() : void {
		}

		override public function test_keyIterator_objectKeys() : void {
		}

		override public function test_keyIterator_mixedKeys() : void {
		}

		override public function test_removeKey_objectKeys() : void {
		}

		override public function test_removeKey_mixedKeys() : void {
		}
		
		override public function test_removeKey_wrongKey_objectKeys() : void {
		}

		override public function test_removeKey_wrongKey_mixedKeys() : void {
		}
		
		override public function test_remove_objectKeys() : void {
		}

		override public function test_remove_mixedKeys() : void {
		}

		override public function test_removeAll_objectKeys() : void {
		}

		override public function test_removeAll_mixedKeys() : void {
		}

		override public function test_clear_mixedKeys() : void {
		}
		

	}
}
