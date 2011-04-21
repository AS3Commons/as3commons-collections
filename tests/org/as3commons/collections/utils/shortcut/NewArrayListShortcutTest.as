package org.as3commons.collections.utils.shortcut {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.testhelpers.CollectionTest;

	/**
	 * @author Jens Struwe 21.04.2011
	 */
	public class NewArrayListShortcutTest extends TestCase {

		public function test_list() : void {
			// multiple arguments

			var list : IList = newarraylist(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(list is ArrayList);

			// single argument

			list = newarraylist(1);
			assertTrue(list is ArrayList);

			// no argument

			list = newarraylist();
			assertTrue(list is ArrayList);
		}

		public function test_list_arguments() : void {
			// multiple arguments

			var list : IList = newarraylist(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(CollectionTest.itemsEqual(list, [1, "1", 2, "2", 3, "3", 4, "4", 5, "5"]));

			// single argument

			list = newarraylist(1);
			assertTrue(CollectionTest.itemsEqual(list, [1]));

			// no argument

			list = newarraylist();
			assertTrue(CollectionTest.itemsEqual(list, []));
		}

	}
}
