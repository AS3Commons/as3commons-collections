package org.as3commons.collections.utils.shortcut {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.Map;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.testhelpers.CollectionTest;

	/**
	 * @author Jens Struwe 21.04.2011
	 */
	public class NewMapShortcutTest extends TestCase {

		public function test_map() : void {
			// even number of arguments

			var theMap : IMap = newmap(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(theMap is Map);

			// odd number of arguments

			theMap = newmap(1, "1", 2, "2", 3, "3", 4, "4", 5);
			assertTrue(theMap is Map);

			// single argument

			theMap = newmap(1);
			assertTrue(theMap is Map);

			// no argument

			theMap = newmap();
			assertTrue(theMap is Map);
		}

		public function test_map_arguments() : void {
			// even number of arguments

			var theMap : IMap = newmap(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(CollectionTest.keysMatch(theMap, [1, 2, 3, 4, 5]));
			assertTrue(CollectionTest.itemsMatch(theMap, ["1", "2", "3", "4", "5"]));

			// odd number of arguments

			theMap = newmap(1, "1", 2, "2", 3, "3", 4, "4", 5);
			assertTrue(CollectionTest.keysMatch(theMap, [1, 2, 3, 4]));
			assertTrue(CollectionTest.itemsMatch(theMap, ["1", "2", "3", "4"]));

			// single argument

			theMap = newmap(1);
			assertTrue(CollectionTest.keysMatch(theMap, []));
			assertTrue(CollectionTest.itemsMatch(theMap, []));

			// no argument

			theMap = newmap();
			assertTrue(CollectionTest.keysMatch(theMap, []));
			assertTrue(CollectionTest.itemsMatch(theMap, []));
		}

	}
}
