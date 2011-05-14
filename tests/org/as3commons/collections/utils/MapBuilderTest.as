package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.Map;
	import org.as3commons.collections.SortedMap;
	import org.as3commons.collections.framework.IMap;

	import flash.utils.getQualifiedClassName;
	/**
	 * @author John Reeves.
	 */
	public class MapBuilderTest extends TestCase {
		public function test_buildMap() : void {
			const result : IMap = MapBuilder.newMap()
				.add("key", "item")
				.build();
			
			assertEquals("Resulting map has a single mapping", 1, result.size);
			assertEquals("Resulting map has the supplied mapping", "item", result.itemFor("key"));
			assertEquals("Resulting map instance is of type Map", getQualifiedClassName(Map), getQualifiedClassName(result));
		}
		
		public function test_buildLinkedMap() : void {
			const result : IMap = MapBuilder.newLinkedMap()
				.add("key1", "item-1")
				.add("key2", "item-2")
				.build();
				
			assertEquals("Resulting map has a two mappings", 2, result.size);
			assertEquals("Resulting map has the supplied mapping", "item-1", result.itemFor("key1"));
			assertEquals("Resulting map has the supplied mapping", "item-2", result.itemFor("key2"));
			assertEquals("Resulting map instance is of type Map", getQualifiedClassName(LinkedMap), getQualifiedClassName(result));
		}
		
		public function test_buildSortedMap() : void {
			const result : IMap = MapBuilder.newSortedMap(new NumericComparator())
				.add("key1", 200)
				.add("key2", 100)
				.add("key3", 25)
				.build();
				
			assertEquals("Resulting map has a three mappings", 3, result.size);
			assertEquals("Resulting map has the supplied mapping", 200, result.itemFor("key1"));
			assertEquals("Resulting map has the supplied mapping",100, result.itemFor("key2"));
			assertEquals("Resulting map has the supplied mapping",25, result.itemFor("key3"));
			assertEquals("Resulting map instance is of type Map", getQualifiedClassName(SortedMap), getQualifiedClassName(result));
		}

	}
}

