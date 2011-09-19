/**
 * Copyright 2010-2001 The original author or authors.
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
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.framework.core.SetIterator;

	/**
	 * String set implementation.
	 * 
	 * <p>The <code>StringSet</code> stores literal values.</p>
	 * 
	 * <p>You are still allowed to add complex or numeric items. No error is thrown.</p>
	 * 
	 * <p>Complex items are stored with their String representation such as
	 * <code>[object Object]</code>.</p>
	 * 
	 * <p>When you use items containing numeric values (0, "0", 1, "1", -1, "-1", 1.5, "1.5"),
	 * you should have in mind that the items implicitely get converted as follows:</p>
	 * 
	 * <ul>
	 * <li>Int <code>0</code> is stored and returned as int <code>0</code>.</li>
	 * <li>String <code>"0"</code> is stored and returned as int <code>"0"</code>.</li>
	 * <li>Int <code>1</code> is stored and returned as int <code>1</code>.</li>
	 * <li>String <code>"1"</code> is stored and returned as int <code>"1"</code>.</li>
	 * <li>Int <code>-1</code> is stored and returned as String <code>"-1"</code>.</li>
	 * <li>String <code>"-1"</code> is stored and returned as String <code>"-1"</code>.</li>
	 * <li>Int <code>1.5</code> is stored and returned as String <code>"1.5"</code>.</li>
	 * <li>String <code>"1.5"</code> is stored and returned as String <code>"1.5"</code>.</li>
	 * </ul>
	 * 
	 * <p>In any case, you are safe using the <code>StringSet</code> with non-numeric
	 * literals or non negative integer values.</p>
	 * 
	 * <p>Note to the universal type <code>*</code>. The <code>StringSet</code> still implements
	 * the <code>ISet</code> interface. This interface allows to pass and returns objects of the universal
	 * type <code>*</code>. This is not actually what we like, but since ActionScript does not
	 * support generics, there is no other way to define a base interface for all set
	 * implementations. If you are not comfortable with this, please make your own custom
	 * typed copy of this class.</p>
	 * 
	 * <p>In difference to the basic <code>Set</code> implementation, the <code>StringSet</code>
	 * maintains an object as its source and hence requires less memory.</p>
	 * 
	 * <p>See the <code>Set</code> documentation for more details.</p>
	 * 
	 * <p>The <code>Set</code> maintains a dictionary as its source.</p>
	 * 
	 * @author Jens Struwe 19.09.2011
	 * @see org.as3commons.collections.Set Basic set implementation - Basic set implementation description.
	 */
	public class StringSet implements ISet {

		/**
		 * The string items.
		 */
		private var _items : Object;

		/**
		 * The set size.
		 */
		private var _size : uint = 0;
		
		/**
		 * Set constructor.
		 */
		public function StringSet() {
			_items = new Object();
		}
		
		/*
		 * ISet
		 */

		/**
		 * @inheritDoc
		 */
		public function add(item : *) : Boolean {
			if (_items[item] !== undefined) return false;
			_items[item] = item;
			
			_size++;
			return true;
		}
		
		/*
		 * ICollection
		 */
		
		/**
		 * @inheritDoc
		 */
		public function get size() : uint {
			return _size;
		}
		
		/**
		 * @inheritDoc
		 */
		public function has(item : *) : Boolean {
			return _items[item] !== undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toArray() : Array {
			var items : Array = new Array();
			var item : *;
			for each (item in _items) {
				items.push(item);
			}
			return items;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(item : *) : Boolean {
			if (_items[item] === undefined) return false;
			delete _items[item];
			
			_size--;
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear() : Boolean {
			if (!_size) return false;
			_items = new Object();
			_size = 0;
			return true;
		}
		
		/*
		 * IIterable
		 */

		/**
		 * @inheritDoc
		 */
		public function iterator(cursor : * = undefined) : IIterator {
			return new SetIterator(this);
		}
	}
}
