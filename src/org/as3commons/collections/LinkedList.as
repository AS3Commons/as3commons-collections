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
package org.as3commons.collections {
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ILinkedList;
	import org.as3commons.collections.framework.core.AbstractLinkedDuplicatesCollection;
	import org.as3commons.collections.framework.core.LinkedListIterator;
	import org.as3commons.collections.framework.core.LinkedNode;
	import org.as3commons.collections.framework.core.as3commons_collections;

	/**
	 * Linked list data structure implementation.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>LinkedList</code> is a collection made up of mutually linking nodes
	 * where each node holds a reference to the actual item added.</p>
	 * 
	 * <p><strong>Runtime of operations</strong></p>
	 * 
	 * <ul>
	 * <li>Adding, getting or removing of items - constant runtime O(1).<br />
	 * <code>add(), addFirst(), addLast(), first, last, removeFirst(), removeLast()</code></li>
	 * <li>Item lookup operations - linear runtime O(n).<br />
	 * has(), count(), remove(), removeAll()</code></li>
	 * </ul>
	 * 
	 * <p><strong>Notes</strong></p>
	 * 
	 * <p>The <code>iterator()</code> method does not support (ignores) the cursor parameter.</p>
	 * 
	 * <p>The <code>iterator()</code> method retuns an <code>ILinkedListIterator</code>.</p>
	 * 
	 * <p><code>null</code> is allowed.</p>
	 * 
	 * <p id="link_LinkedListExample"><strong>LinkedList example</strong></p>
	 * 
	 * <p>This example shows the specific behaviour of a <code>LinkedList</code>.
	 * The general work with collections and iterators is more detailed illustrated
	 * in the <code>ArrayList</code> examples below.</p>
	 * 
	 * {{EXAMPLE: LinkedListExample}}
	 * 
	 * <p id="link_ArrayListExample"><strong>ArrayList example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListExample}}
	 * 
	 * <p id="link_ArrayListIteratorExample"><strong>ArrayListIterator example</strong></p>
	 * 
	 * {{EXAMPLE: ArrayListIteratorExample}}
	 * 
	 * @author Jens Struwe 04.03.2010
	 * @see org.as3commons.collections.framework.ILinkedList ILinkedList interface - Detailed description of the linked list features.
	 * @see org.as3commons.collections.framework.ILinkedListIterator ILinkedListIterator interface - Detailed description of the linked list iterator features.
	 */
	public class LinkedList extends AbstractLinkedDuplicatesCollection implements ILinkedList {

		/**
		 * LinkedList constructor.
		 */
		public function LinkedList() {
		}

		/*
		 * ILinkedList
		 */

		/**
		 * @inheritDoc
		 */
		public function add(item : *) : void {
			addNodeLast(new LinkedNode(item));
		}
		
		/**
		 * @inheritDoc
		 */
		public function addFirst(item : *) : void {
			addNodeFirst(new LinkedNode(item));
		}
		
		/**
		 * @inheritDoc
		 */
		public function addLast(item : *) : void {
			addNodeLast(new LinkedNode(item));
		}
		
		/*
		 * IIterable
		 */

		/**
		 * @inheritDoc
		 */
		override public function iterator(cursor : * = undefined) : IIterator {
			return new LinkedListIterator(this);
		}

		/*
		 * as3commons_collections
		 */

		/**
		 * Framework internal method to remove a node from the list.
		 * 
		 * @param node The node to remove.
		 */
		as3commons_collections function removeNode_internal(node : LinkedNode) : void {
			removeNode(node);
		}

		/**
		 * Framework internal method to add a node before an existing one.
		 * 
		 * @param next The node to add before.
		 * @param node The node to add.
		 */
		as3commons_collections function addNodeBefore_internal(next : LinkedNode, node : LinkedNode) : void {
			addNodeBefore(next, node);
		}
		
	}
}
