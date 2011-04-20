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
	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IRecursiveIterator;
	import org.as3commons.collections.iterators.RecursiveIterator;

	/**
	 * Collections utils.
	 *    
	 * @author Jens Struwe 09.03.2009
	 */
	public class CollectionUtils {

		/**
		 * Dumps an iterable structure recursively into a formatted string literal.
		 * 
		 * <p id="link_DumpAsStringExample"><strong><code>dumpAsString()</code> example</strong></p>
		 * 
		 * {{EXAMPLE: DumpAsStringExample}}<br />
		 * 
		 * @param data The iterable data structure.
		 * @return The dump.
		 */
		public static function dumpAsString(data : IIterable) : String {
			var info : String = data + "\n";
			var iterator : IRecursiveIterator = new RecursiveIterator(data);
			var i : uint = 0;
			var j : uint = 0;
			var next : *;
			var prefix : String;
			while (iterator.hasNext()) {
				next = iterator.next();

				prefix = "";
				for (j = 0; j < iterator.depth + 1; j++) {
					prefix += ".......";
				}
				
				info += prefix + next;
				if (iterator.hasNext()) info += "\n";
				i++;
			}
			return info;
		}

	}
}
