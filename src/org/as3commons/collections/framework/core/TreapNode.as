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
	 * Treap node.
	 * 
	 * @author Jens Struwe 18.04.2009
	 */
	public class TreapNode {
		
		/**
		 * The item.
		 */
		public var item : *;

		/**
		 * The parent item.
		 */
		public var parent : TreapNode;

		/**
		 * The left subtree.
		 */
		public var left : TreapNode;

		/**
		 * The right subtree.
		 */
		public var right : TreapNode;

		/**
		 * The node priority.
		 */
		public var priority : uint;
		
		/**
		 * Creates a new Treap node.
		 * 
		 * @param theItem The data of the node.
		 * @param theParent The parent node.
		 */
		public function TreapNode(theItem : *, theParent : TreapNode = null) {
			item = theItem;
			parent = theParent;
			priority = Math.random() * uint.MAX_VALUE;
		}

	}
}
