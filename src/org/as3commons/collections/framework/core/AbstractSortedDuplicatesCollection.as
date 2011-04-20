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
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IDuplicates;

	/**
	 * Abstract sorted tree based collection implementation with permission of duplicates.
	 * 
	 * @author Jens Struwe 12.04.2010
	 */
	public class AbstractSortedDuplicatesCollection extends AbstractSortedCollection implements IDuplicates {

		use namespace as3commons_collections;

		/**
		 * AbstractSortedCollection constructor.
		 * 
		 * @param comparator The sort criterion.
		 */
		public function AbstractSortedDuplicatesCollection(comparator : IComparator) {
			super(comparator);
		}

		/**
		 * @inheritDoc
		 */
		public function count(item : *) : uint {
			var node : SortedNode = firstEqualNode(item);
			if (!node) return 0;
			
			var count : uint = 0;
			
			if (node.item === item) count++;
			node = nextNode_internal(node);
			while (node) {
				if (_comparator.compare(item, node.item)) break;
				if (node.item === item) count++;
				node = nextNode_internal(node);
			}
			
			return count;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll(item : *) : uint {
			var node : SortedNode = firstEqualNode(item);
			if (!node) return 0;
			
			var count : uint = 0;

			while (node) {
				if (_comparator.compare(item, node.item)) break;
				if (node.item === item) {
					var next : SortedNode = nextNode_internal(node);
					removeNode(node);
					node = next;
					count++;
				} else {
					node = nextNode_internal(node);
				}
			}
			
			return count;
		}
		
		
	}
}
