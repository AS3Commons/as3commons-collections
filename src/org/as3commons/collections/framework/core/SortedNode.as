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
package org.as3commons.collections.framework.core {

	/**
	 * Sorted node.
	 * 
	 * @author Jens Struwe 18.04.2009
	 */
	public class SortedNode {
		
		/**
		 * The item.
		 */
		public var item : *;

		/**
		 * The parent item.
		 */
		public var parent : SortedNode;

		/**
		 * The left subtree.
		 */
		public var left : SortedNode;

		/**
		 * The right subtree.
		 */
		public var right : SortedNode;

		/**
		 * The node priority.
		 */
		public var priority : uint;

		/**
		 * The node order.
		 * 
		 * <p>Since a sorted collection may contain multiple equal items, the
		 * <code>order</code> is used to compare to items.</p>
		 */
		public var order : uint;
		
		/**
		 * Node count.
		 */
		private static var _order : uint = 0; 
		
		/**
		 * SortedNode constructor.
		 * 
		 * @param theItem The data of the node.
		 */
		public function SortedNode(theItem : *) {
			item = theItem;
			priority = Math.random() * uint.MAX_VALUE;
			order = ++_order;
		}

	}
}
