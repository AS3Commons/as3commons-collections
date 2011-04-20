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
	import flexunit.framework.TestCase;

	import org.as3commons.collections.framework.IComparator;

	/**
	 * @author Jens Struwe 13.03.2009
	 */
	public class StringComparatorTest extends TestCase {


		public function test_ascendingCasesensitive() : void {
			var comparator : IComparator = new StringComparator(StringComparator.ORDER_ASC, StringComparator.OPTION_CASESENSITIVE);
			
			// case
			
			assertEquals(
				"A < a",
				-1,
				comparator.compare("A", "a")
			);

			assertEquals(
				"a > A",
				1,
				comparator.compare("a", "A")
			);

			assertEquals(
				"namE < name",
				-1,
				comparator.compare("namE", "name")
			);

			assertEquals(
				"name > namE",
				1,
				comparator.compare("name", "namE")
			);

			// empty string

			assertEquals(
				"'' < a",
				-1,
				comparator.compare("", "a")
			);

			assertEquals(
				"a > ''",
				1,
				comparator.compare("a", "")
			);

			assertEquals(
				"'' == ''",
				0,
				comparator.compare("", "")
			);

			// different length

			assertEquals(
				"name < namee",
				-1,
				comparator.compare("name", "namee")
			);

			assertEquals(
				"namee > name",
				1,
				comparator.compare("namee", "name")
			);

			// case and length

			assertEquals(
				"name > nAmee",
				1,
				comparator.compare("name", "nAmee")
			);

			assertEquals(
				"nAmee < name",
				-1,
				comparator.compare("nAmee", "name")
			);

			// numbers as strings

			assertEquals(
				"name1 < name2",
				-1,
				comparator.compare("name1", "name2")
			);

			assertEquals(
				"name2 > name1",
				1,
				comparator.compare("name2", "name1")
			);

			// numbers vs strings

			assertEquals(
				"1 < A",
				-1,
				comparator.compare("1", "A")
			);

			assertEquals(
				"A > 1",
				1,
				comparator.compare("A", "1")
			);

		}

		public function test_ascendingCaseinsensitive() : void {
			var comparator : IComparator = new StringComparator(StringComparator.ORDER_ASC, StringComparator.OPTION_CASEINSENSITIVE);
			
			// case
			
			assertEquals(
				"A == a",
				0,
				comparator.compare("A", "a")
			);

			assertEquals(
				"a == A",
				0,
				comparator.compare("a", "A")
			);

			assertEquals(
				"namE == name",
				0,
				comparator.compare("namE", "name")
			);

			assertEquals(
				"name == namE",
				0,
				comparator.compare("name", "namE")
			);

			// empty string

			assertEquals(
				"'' < a",
				-1,
				comparator.compare("", "a")
			);

			assertEquals(
				"a > ''",
				1,
				comparator.compare("a", "")
			);

			assertEquals(
				"'' == ''",
				0,
				comparator.compare("", "")
			);

			// different length

			assertEquals(
				"name < namee",
				-1,
				comparator.compare("name", "namee")
			);

			assertEquals(
				"namee > name",
				1,
				comparator.compare("namee", "name")
			);

			// case and length

			assertEquals(
				"name < nAmee",
				-1,
				comparator.compare("name", "nAmee")
			);

			assertEquals(
				"nAmee > name",
				1,
				comparator.compare("nAmee", "name")
			);

			// numbers as strings

			assertEquals(
				"name1 < name2",
				-1,
				comparator.compare("name1", "name2")
			);

			assertEquals(
				"name2 > name1",
				1,
				comparator.compare("name2", "name1")
			);

			// numbers vs strings

			assertEquals(
				"1 < A",
				-1,
				comparator.compare("1", "A")
			);

			assertEquals(
				"A > 1",
				1,
				comparator.compare("A", "1")
			);

		}

		public function test_descendingCasesensitive() : void {
			var comparator : IComparator = new StringComparator(StringComparator.ORDER_DESC, StringComparator.OPTION_CASESENSITIVE);
			
			// case
			
			assertEquals(
				"A > a",
				1,
				comparator.compare("A", "a")
			);

			assertEquals(
				"a < A",
				-1,
				comparator.compare("a", "A")
			);

			assertEquals(
				"namE > name",
				1,
				comparator.compare("namE", "name")
			);

			assertEquals(
				"name < namE",
				-1,
				comparator.compare("name", "namE")
			);

			// empty string

			assertEquals(
				"'' > a",
				1,
				comparator.compare("", "a")
			);

			assertEquals(
				"a < ''",
				-1,
				comparator.compare("a", "")
			);

			assertEquals(
				"'' == ''",
				0,
				comparator.compare("", "")
			);

			// different length

			assertEquals(
				"name > namee",
				1,
				comparator.compare("name", "namee")
			);

			assertEquals(
				"namee < name",
				-1,
				comparator.compare("namee", "name")
			);

			// case and length

			assertEquals(
				"name < nAmee",
				-1,
				comparator.compare("name", "nAmee")
			);

			assertEquals(
				"nAmee > name",
				1,
				comparator.compare("nAmee", "name")
			);

			// numbers as strings

			assertEquals(
				"name1 > name2",
				1,
				comparator.compare("name1", "name2")
			);

			assertEquals(
				"name2 < name1",
				-1,
				comparator.compare("name2", "name1")
			);

			// numbers vs strings

			assertEquals(
				"1 > A",
				1,
				comparator.compare("1", "A")
			);

			assertEquals(
				"A < 1",
				-1,
				comparator.compare("A", "1")
			);

		}

		public function test_descendingCaseinsensitive() : void {
			var comparator : IComparator = new StringComparator(StringComparator.ORDER_DESC, StringComparator.OPTION_CASEINSENSITIVE);
			
			// case
			
			assertEquals(
				"A == a",
				0,
				comparator.compare("A", "a")
			);

			assertEquals(
				"a == A",
				0,
				comparator.compare("a", "A")
			);

			assertEquals(
				"namE == name",
				0,
				comparator.compare("namE", "name")
			);

			assertEquals(
				"name == namE",
				0,
				comparator.compare("name", "namE")
			);

			// empty string

			assertEquals(
				"'' > a",
				1,
				comparator.compare("", "a")
			);

			assertEquals(
				"a < ''",
				-1,
				comparator.compare("a", "")
			);

			assertEquals(
				"'' == ''",
				0,
				comparator.compare("", "")
			);

			// different length

			assertEquals(
				"name > namee",
				1,
				comparator.compare("name", "namee")
			);

			assertEquals(
				"namee < name",
				-1,
				comparator.compare("namee", "name")
			);

			// case and length

			assertEquals(
				"name > nAmee",
				1,
				comparator.compare("name", "nAmee")
			);

			assertEquals(
				"nAmee < name",
				-1,
				comparator.compare("nAmee", "name")
			);

			// numbers as strings

			assertEquals(
				"name1 > name2",
				1,
				comparator.compare("name1", "name2")
			);

			assertEquals(
				"name2 < name2",
				-1,
				comparator.compare("name2", "name1")
			);

			// numbers vs strings

			assertEquals(
				"1 > A",
				1,
				comparator.compare("1", "A")
			);

			assertEquals(
				"A < 1",
				-1,
				comparator.compare("A", "1")
			);

		}

	}
}
