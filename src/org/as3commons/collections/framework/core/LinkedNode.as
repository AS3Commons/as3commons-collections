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
	 * Linked node.
	 * 
	 * @author Jens Struwe 13.03.2009
	 */
	public class LinkedNode {
		
		/**
		 * The node's data.
		 */
		private var _item : *;

		/**
		 * The predecessor.
		 */
		public var left : LinkedNode;

		/**
		 * The successor.
		 */
		public var right : LinkedNode;

		/**
		 * LinkedNode constructor.
		 * 
		 * @param theItem The data of the node.
		 */
		public function LinkedNode(theItem : *) {
			_item = theItem;
		}

		/**
		 * @private
		 */
		public function set item(item : *) : void {
			_item = item;
		}
		
		/**
		 * The node's data.
		 */
		public function get item() : * {
			return _item;
		}
		
	}
}
