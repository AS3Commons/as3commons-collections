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
package org.as3commons.collections.utils {
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Uncomparable type Exception.
	 * 
	 * @author Jens Struwe 17.03.2009
	 */
	public class UncomparableType extends TypeError {

		/**
		 * UncomparableType constructor.
		 * 
		 * @param expectedType The expected type of the value.
		 * @param failedValue The value not matching that type.
		 */
		public function UncomparableType(expectedType : Class, failedValue : *) {
			var failedType : *;
			var className : String = getQualifiedClassName(failedValue);
			try {
				failedType = getDefinitionByName(className);
			} catch (e : Error) {
				failedType = "[class " + className + "]";
			}
			
			super("Type not supported - expected: " + expectedType + " found: " + failedType);
		}

	}
}
