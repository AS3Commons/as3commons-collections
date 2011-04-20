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
	import org.as3commons.collections.utils.ArrayUtils;

	/**
	 * @author Jens Struwe 19.02.2010
	 */
	public class TestItems {
		
		public static var object1Key : String;
		public static var object1 : Object;

		public static var object2Key : String;
		public static var object2 : Object;

		public static var object3Key : String;
		public static var object3 : Object;

		public static var object4Key : String;
		public static var object4 : Object;

		public static var object5Key : String;
		public static var object5 : Object;

		public static var object6Key : String;
		public static var object6 : Object;

		public static var object7Key : String;
		public static var object7 : Object;

		public static var object8Key : String;
		public static var object8 : Object;

		public static var object9Key : String;
		public static var object9 : Object;

		public static var object10Key : String;
		public static var object10 : Object;

		public static var object11Key : String;
		public static var object11 : Object;

		public static function init() : void {
			for (var i : uint = 1; i <= 11; i++) {
				TestItems["object" + i + "Key"] =  "object" + i + "key";

				TestItems["object" + i] = {
					index: i,
					name: "object" + i,
					toString: function() : String {
						return this["name"];
					}
				};
			}
		}
		
		public static function cleanUp() : void {
			for (var i : uint = 1; i <= 11; i++) {
				TestItems["object" + i + "Key"] = null;
				TestItems["object" + i] = null;
			}
		}

		public static function itemArray(numItems : uint) : Array {
			var array : Array = new Array();
			for (var i : uint = 1; i <= numItems; i++) {
				array.push(TestItems["object" + i]);
			}
			return array;
		}
		
		public static function itemArrayByIndices(indices : Array) : Array {
			var array : Array = new Array();
			for (var i : uint = 0; i < indices.length; i++) {
				array.push(TestItems["object" + indices[i]]);
			}
			return array;
		}

		public static function keyArrayByIndices(indices : Array) : Array {
			var array : Array = new Array();
			for (var i : uint = 0; i < indices.length; i++) {
				array.push(TestItems["object" + indices[i] + "Key"]);
			}
			return array;
		}

		public static function itemsEqual(indices : Array, items : Array) : Boolean {
			var expectedArray : Array = new Array();
			for (var i : uint = 0; i < indices.length; i++) {
				if (indices[i] === null) expectedArray.push(null);
				else expectedArray.push(TestItems["object" + indices[i]]);
			}
			return ArrayUtils.arraysEqual(expectedArray, items);
		}

		public static function itemsMatch(indices : Array, items : Array) : Boolean {
			var expectedArray : Array = new Array();
			for (var i : uint = 0; i < indices.length; i++) {
				if (indices[i] === null) expectedArray.push(null);
				else expectedArray.push(TestItems["object" + indices[i]]);
			}
			return ArrayUtils.arraysMatch(expectedArray, items);
		}

		public static function keysEqual(indices : Array, keys : Array) : Boolean {
			var expectedArray : Array = new Array();
			for (var i : uint = 0; i < indices.length; i++) {
				if (indices[i] === null) expectedArray.push(null);
				else expectedArray.push(TestItems["object" + indices[i] + "Key"]);
			}
			return ArrayUtils.arraysEqual(expectedArray, keys);
		}

		public static function keysMatch(indices : Array, keys : Array) : Boolean {
			var expectedArray : Array = new Array();
			for (var i : uint = 0; i < indices.length; i++) {
				if (indices[i] === null) expectedArray.push(null);
				else expectedArray.push(TestItems["object" + indices[i] + "Key"]);
			}
			return ArrayUtils.arraysMatch(expectedArray, keys);
		}

	}
}
