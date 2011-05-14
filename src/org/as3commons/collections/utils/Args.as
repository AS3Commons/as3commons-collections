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

	/**
	 * Wrapper class for complex objects in variable argument lists.
	 * 
	 * <p>If an object is wrapped into an Args object, not the object but its
	 * items are being considered from the accepting method.</p>
	 * 
	 * <listing>
	 * 
			var array : Array = [2, 3, 4];
			var list : ArrayList = Lists.newArrayList(1, array, 5);
			trace (list.size); // 3

			var array : Array = [2, 3, 4];
			var list : ArrayList = Lists.newArrayList(1, Args.from(array), 5);
			trace (list.size); // 5
	 * </listing>
	 * 
	 * @author Jens Struwe 26.04.2011
	 */
	public class Args {
		
		/**
		 * The wrapped complex data source.
		 */
		public var source : Object;

		/**
		 * Creates a wrapper.
		 * 
		 * @param source The data container to be wrapped.
		 * @return Wrapper of the given data source.
		 */
		public static function from(source : Object) : Args {
			var args : Args = new Args();
			args.source = source;
			return args;
		}
		
	}
}
