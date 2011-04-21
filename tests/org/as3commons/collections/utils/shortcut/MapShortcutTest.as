package org.as3commons.collections.utils.shortcut {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.Map;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.testhelpers.CollectionTest;

	/**
	 * @author Jens Struwe 21.04.2011
	 */
	public class MapShortcutTest extends TestCase {

		public function test_map() : void {
			// even number of arguments

			var theMap : IMap = map(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(theMap is Map);

			// odd number of arguments

			theMap = map(1, "1", 2, "2", 3, "3", 4, "4", 5);
			assertTrue(theMap is Map);

			// single argument

			theMap = map(1);
			assertTrue(theMap is Map);

			// no argument

			theMap = map();
			assertTrue(theMap is Map);
		}

		public function test_map_arguments() : void {
			// even number of arguments

			var theMap : IMap = map(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(CollectionTest.keysEqual(theMap, [1, 2, 3, 4, 5]));
			assertTrue(CollectionTest.itemsEqual(theMap, ["1", "2", "3", "4", "5"]));
			return;

			// odd number of arguments

			theMap = map(1, "1", 2, "2", 3, "3", 4, "4", 5);
			assertTrue(CollectionTest.keysEqual(theMap, [1, 2, 3, 4]));
			assertTrue(CollectionTest.itemsEqual(theMap, ["1", "2", "3", "4"]));

			// single argument

			theMap = map(1);
			assertTrue(CollectionTest.keysEqual(theMap, []));
			assertTrue(CollectionTest.itemsEqual(theMap, []));

			// no argument

			theMap = map();
			assertTrue(CollectionTest.keysEqual(theMap, []));
			assertTrue(CollectionTest.itemsEqual(theMap, []));
		}

	}
}
