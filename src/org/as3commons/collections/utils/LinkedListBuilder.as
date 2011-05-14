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

	import org.as3commons.collections.LinkedList;
	import org.as3commons.collections.framework.ILinkedList;

	/**
	 * LinkedList builder using the builder pattern.
	 * 
	 * <p>Uses the builder Pattern to simplify the creation of new <code>ILinkedList</code> instances
	 * in a fluent fashion.</p>
	 *  
	 * <p>Example: Creating a new <code>LinkedList</code> instance using LinkedListBuilder.</p>
	 * 
	 * <listing>
	 * 		const result : ILinkedList = LinkedListBuilder.newLinkedList()
	 * 			.add("item-one")
	 * 			.add("item-two")
	 * 			.build();
	 * 		
	 * 		// Creates the following list: { item-one, item-two }
	 * 		trace(result);
	 * </listing>;
	 * 
	 * @author John Reeves 14.04.2011
	 */
	public class LinkedListBuilder {

		/**
		 * Backing <code>ILinkedList</code> instance.
		 */
		private var _list : ILinkedList;
		
		/**
		 * Starts construction of a new <code>LinkedList</code> instance.
		 * 
		 * @return A <code>LinkedListBuilder</code> instance which will build and return an instance of <code>LinkedList</code>
		 */		
		public static function newLinkedList() : LinkedListBuilder {
			return new LinkedListBuilder(new LinkedList());
		}

		/**
		 * Please make use of one of the static factory methods for creating a new <code>LinkedListBuilder</code> instance.
		 * 
		 * @private
		 */
		public function LinkedListBuilder(underlyingLinkedList : ILinkedList) {
			_list = underlyingLinkedList;
		}
		
		/**
		 * Adds the supplied item to the <code>ILinkedList</code> under construction.
		 * 
		 * <p>Returns a reference to this <code>LinkedListBuilder</code> instance.</p>
		 * 
		 * @param item to add to the <code>ILinkedList</code> instance under construction.
		 * @return A reference to this <code>LinkedListBuilder</code> instance to allow method chaining.
		 */
		public function add(item : *) : LinkedListBuilder {
			_list.add(item);
			return this;
		}
		
		/**
		 * Completes construction.
		 */
		public function build() : ILinkedList {
			return _list;
		}
	}
}
