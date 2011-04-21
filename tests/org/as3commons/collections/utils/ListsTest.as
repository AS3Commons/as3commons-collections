package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.testhelpers.CollectionTest;

	public class ListsTest extends TestCase {

		public function test_populate() : void {
			// multiple arguments

			var list : IList = new ArrayList();
			Lists.populate(list, 1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(CollectionTest.itemsEqual(list, [1, "1", 2, "2", 3, "3", 4, "4", 5, "5"]));

			// single argument

			list = new ArrayList();
			Lists.populate(list, 1);
			assertTrue(CollectionTest.itemsEqual(list, [1]));

			// no argument

			list = new ArrayList();
			Lists.populate(list);
			assertTrue(CollectionTest.itemsEqual(list, []));
		}
	}
}

