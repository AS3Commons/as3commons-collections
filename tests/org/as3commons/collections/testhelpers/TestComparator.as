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
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.utils.NumericComparator;
	import org.as3commons.collections.utils.StringComparator;
	import org.as3commons.collections.utils.UncomparableType;

	/**
	 * @author Jens Struwe 22.02.2010
	 */
	public class TestComparator implements IComparator {

		private var types : Array = [
			"number",
			"string",
			"boolean",
			"function",
			"xml",
			"object"
		];

		public function compare(item1 : *, item2 : *) : int {
			
			// equal
			
			if (item1 === item2) return 0;
			
			// allow null
			if (item1 === null) return -1;
			if (item2 === null) return 1;
			
			// type

			var type1 : uint = types.indexOf(typeof item1);
			var type2 : uint = types.indexOf(typeof item2);
			
			if (type1 < type2) return -1;
			else if (type1 > type2) return 1;
			
			// string
			
			if (item1 is String) {
				return new StringComparator().compare(item1, item2);
			}
			
			// number
			
			if (item1 is Number) {
				return new NumericComparator().compare(item1, item2);
			}

			// boolean
			
			if (item1 is Boolean) {
				if (item1) return -1;
				if (item2) return 1;
			}

			// function
			
			if (item1 is Function) {
				return 0;
			}

			// xml
			
			if (item1 is XML) {
				return 0;
			}

			// test item

			// do not allow non objects
			if (!(item1 is Object)) throw new UncomparableType(Object, item1);
			if (!(item2 is Object)) throw new UncomparableType(Object, item2);
			
			if (item1["index"] < item2["index"]) return -1;
			else if (item1["index"] > item2["index"]) return 1;
			else return 0;
		}

	}
}
