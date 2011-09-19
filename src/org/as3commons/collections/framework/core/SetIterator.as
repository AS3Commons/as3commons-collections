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

	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.framework.ISetIterator;
	import org.as3commons.collections.iterators.ArrayIterator;

	/**
	 * Internal <code>Set</code> iterator implementation.
	 * 
	 * @author Jens Struwe 01.04.2010
	 */
	public class SetIterator extends ArrayIterator implements ISetIterator {

		/**
		 * The set to enumerate.
		 */
		protected var _set : ISet;

		/**
		 * SetIterator constructor.
		 * 
		 * @param theSet The set to enumerate.
		 */
		public function SetIterator(theSet : ISet) {
			_set = theSet;
			super(_set.toArray());
		}
		
		/*
		 * ISetIterator
		 */
		
		/**
		 * @inheritDoc
		 */
		public function get previousItem() : * {
			return _array[previousIndex];
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextItem() : * {
			return _array[_next];
		}
	
		/*
		 * Protected
		 */

		/**
		 * @inheritDoc
		 */
		override protected function removeCurrent() : void {
			_set.remove(super.current);
			super.removeCurrent();
		}

	}
}
