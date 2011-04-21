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
package org.as3commons.collections.testhelpers {
	import flexunit.framework.TestCase;

	import flash.utils.describeType;

	/**
	 * @author Jens Struwe 18.03.2010
	 */
	public class AbstractIteratorUnitTestCase extends TestCase {
		protected var _test : AbstractIteratorTestCase;
		
		public function AbstractIteratorUnitTestCase(test : AbstractIteratorTestCase) {
			_test = test;
		}
		
		public function runAllTests() : void {
//			var unitTest : String = "[" + getQualifiedClassName(this).replace(/^.*::/, "") + "]";
//			var collectionTest : String = "[" + getQualifiedClassName(_test).replace(/^.*::/, "") + "]";
			var description:XML = describeType(this);
			
			var list : XMLList = description.descendants("method").@name;
			for each (var method : String in list) {
				if (method.toString().indexOf("test") == 0) {

					_test.setUp();

					this[method.toString()]();
//					trace (collectionTest + "::" + unitTest + "::" + method + "()");
//					trace (collectionTest + "::" + method + "()");

					_test.tearDown();

				}
			}
		}

	}
}
