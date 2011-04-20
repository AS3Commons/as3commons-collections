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
	import org.as3commons.collections.framework.IComparator;

	/**
	 * String comparator.
	 * 
	 * <p>The succession order and the case sensitivity may be specified in constructor parameters.</p>
	 *    
	 * @author Jens Struwe 13.03.2009
	 * @see org.as3commons.collections.framework.IComparator IComparator interface - Description of the comparator features.
	 */
	public class StringComparator implements IComparator {
		
		/**
		 * Constant defining ascending order (default).
		 */
		public static const ORDER_ASC : String = "asc";

		/**
		 * Constant defining descending order.
		 */
		public static const ORDER_DESC : String = "desc";

		/**
		 * Constant defining case sensitive comparistion (default).
		 */
		public static const OPTION_CASESENSITIVE : String = "casesensitive";

		/**
		 * Constant defining case insensitive comparistion.
		 */
		public static const OPTION_CASEINSENSITIVE : String = "caseinsensitive";
		
		/**
		 * Sort order.
		 */
		protected var _order : String;

		/**
		 * Case sensitivity.
		 */
		protected var _option : String;
		
		/**
		 * StringComparator constructor.
		 * 
		 * @param order The order of items. <code>StringComparator.ORDER_ASC</code> (default)
		 * or <code>StringComparator.ORDER_DESC</code>.
		 * @param option The case sensitivity. <code>StringComparator.OPTION_CASESENSITIVE</code> (default)
		 * or <code>StringComparator.OPTION_CASEINSENSITIVE</code>.
		 */
		public function StringComparator(order : String = ORDER_ASC, option : String = OPTION_CASESENSITIVE) {
			_order = order;
			_option = option;
		}

		/**
		 * Compares two strings.
		 * 
		 * @param item1 The first string.
		 * @param item1 The second string.
		 * @return <code>-1</code> if the first string is lesser, <code>1</code> if greater
		 * and <code>0</code> if both strings are equal.
		 * @throws UncomparableType if either of the items is not a string.
		 */
		public function compare(item1 : *, item2 : *) : int {

			if (!(item1 is String)) throw new UncomparableType(String, item1);
			if (!(item2 is String)) throw new UncomparableType(String, item2);

			var s1 : String = _order == ORDER_ASC ? item1 : item2;
			var s2 : String = _order == ORDER_ASC ? item2 : item1;
			
			if (_option == OPTION_CASEINSENSITIVE) {
				s1 = s1.toLowerCase();
				s2 = s2.toLowerCase();
			}
			
			if (s1 < s2) return -1;
			else if (s1 > s2) return 1;
			else return 0;
		}

	}
}
