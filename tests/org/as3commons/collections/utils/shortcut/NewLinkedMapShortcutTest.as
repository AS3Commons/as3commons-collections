package org.as3commons.collections.utils.shortcut {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.testhelpers.CollectionTest;

	/**
	 * @author Jens Struwe 21.04.2011
	 */
	public class NewLinkedMapShortcutTest extends TestCase {

		public function test_map() : void {
			// even number of arguments

			var theMap : IMap = newlinkedmap(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(theMap is LinkedMap);

			// odd number of arguments

			theMap = newlinkedmap(1, "1", 2, "2", 3, "3", 4, "4", 5);
			assertTrue(theMap is LinkedMap);

			// single argument

			theMap = newlinkedmap(1);
			assertTrue(theMap is LinkedMap);

			// no argument

			theMap = newlinkedmap();
			assertTrue(theMap is LinkedMap);
		}

		public function test_map_arguments() : void {
			// even number of arguments

			var theMap : IMap = newlinkedmap(1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
			assertTrue(CollectionTest.keysEqual(theMap, [1, 2, 3, 4, 5]));
			assertTrue(CollectionTest.itemsEqual(theMap, ["1", "2", "3", "4", "5"]));

			// odd number of arguments

			theMap = newlinkedmap(1, "1", 2, "2", 3, "3", 4, "4", 5);
			assertTrue(CollectionTest.keysEqual(theMap, [1, 2, 3, 4]));
			assertTrue(CollectionTest.itemsEqual(theMap, ["1", "2", "3", "4"]));

			// single argument

			theMap = newlinkedmap(1);
			assertTrue(CollectionTest.keysEqual(theMap, []));
			assertTrue(CollectionTest.itemsEqual(theMap, []));

			// no argument

			theMap = newlinkedmap();
			assertTrue(CollectionTest.keysEqual(theMap, []));
			assertTrue(CollectionTest.itemsEqual(theMap, []));
		}

	}
}
