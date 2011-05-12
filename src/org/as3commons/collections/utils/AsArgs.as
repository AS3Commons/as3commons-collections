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

	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.framework.IMapIterator;

	/**
	 * @author Jens Struwe 26.04.2011
	 */
	public class AsArgs {
		
		public var source : Object;

		public function AsArgs(theSource : Object) {
			source = theSource;
		}
		
		public function foreachValue(callback : Function) : void {
			if (source is ICollection) {
				var iterator : IIterator = ICollection(source).iterator();
				while (iterator.hasNext()) {
					callback(iterator.next());
				}
				
			} else if (source is Array) {
				for (var i : uint; i < (source as Array).length; i++) {
					callback(i, source[i]);
				}

			} else {
				for (var key : * in source) {
					callback(key, source[key]);
				}
			}
		}
		
		public function foreachKeyValue(callback : Function) : void {
			if (source is ICollection) {
				var iterator : IIterator = ICollection(source).iterator();
				var next : *;
				while (iterator.hasNext()) {
					next = iterator.next();
					if (iterator is IListIterator) {
						callback(IListIterator(iterator).index, next);
					} else if (iterator is IMapIterator) {
						callback(IMapIterator(iterator).key, next);
					} else {
						callback(next, next);
					}
				}
				
			} else if (source is Array) {
				for (var i : uint; i < (source as Array).length; i+=2) {
					callback(i, source[i]);
				}

			} else {
				for (var key : * in source) {
					callback(key, source[key]);
				}
			}
		}
		
	}
}
