package org.as3commons.collections.utils {
	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.Map;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.testhelpers.CollectionTest;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class MapsTest extends TestCase {

		private var map : IMap;
		
		override public function setUp() : void {
			map = new Map();
		}
		
		public function test_itemOrError_notMapped() : void {
			const expectedErrorMessage : String = "expected error message";
			var thrownError : ArgumentError;
			
			try {
				Maps.itemOrError(map, "non-existant-key", expectedErrorMessage);
			}
			catch (e : Error) {
				thrownError = e as ArgumentError;
			}
			
			assertNotNull("ArgumentError was thrown", thrownError);
			assertEquals("ArgumentError used the supplied error message", expectedErrorMessage, thrownError.message);
		}
		
		public function test_itemOrError_mapped() : void {
			const expectedItem : * = "an item";
			const key : * = "a key";
			var thrownError : Error;
			
			map.add(key, expectedItem);
			
			try {
				const result : * = Maps.itemOrError(map, key);
			}
			catch (e : Error) {
				thrownError = e;
			}
			
			assertNull("No error was thrown", thrownError);
			assertEquals("Expected item was retrieved from the map", expectedItem, result);
		}
		
		public function test_itemOrValue_notMapped() : void {
			const expectedDefaultValue : * = "a default value";
			
			const result : * = Maps.itemOrValue(map, "non-existant-key", expectedDefaultValue);
			
			assertEquals("Expected default value is returned when no mapping exists", expectedDefaultValue, result);
		}
		
		public function test_itemOrValue_mapped() : void {
			const mappedItem : * = "a mapped item";
			const key : * = "a key";
			
			map.add(key, mappedItem);
			const result : * = Maps.itemOrValue(map, key, "a default value which will not be used");
			
			assertEquals("Mapped item is returned when a prior mapping exists", mappedItem, result);
		}
		
		public function test_itemOrAdd_notMapped() : void {
			const item : * = "a new item";
			const key : * = "a key";
			
			const result : * = Maps.itemOrAdd(map, key, item);
			
			assertEquals("Supplied item is now mapped to the key", item, map.itemFor(key));
			assertEquals("Mapped item is returned by the call when no mapping exists", item, result);
		}
		
		public function test_itemOrAdd_priorMapping() : void {
			const newItem : * = "a new item";
			const previouslyMappedItem : * = "a previously mapped item";
			const key : * = "a key";
			
			map.add(key, previouslyMappedItem);
			const result : * = Maps.itemOrAdd(map, key, newItem);
			
			assertEquals("Previously mapped item is not replaced", previouslyMappedItem, map.itemFor(key));
			assertEquals("Previously mapped item is returned by the call when a prior mapping exists", previouslyMappedItem, result);
		}
		
		public function test_filterKeys() : void {
			map.add(1, "One");
			map.add(2, "Two");
			map.add(3, "Three");
			map.add(4, "Four");
			map.add(5, "Five");
			map.add(6, "Six");
			
			const keyIsEvenNumberPredicate : Function = function(key : int) : Boolean {
				return (key % 2 == 0);
			};
			const result : IMap = Maps.filterKeys(map, keyIsEvenNumberPredicate);
			
			assertEquals("Resulting map contains 3 entries", 3, result.size);
			assertEquals("Resulting map is of the supplied type", getQualifiedClassName(map), getQualifiedClassName(result));
			assertEquals("Expected entry retained in map", "Two", result.itemFor(2));
			assertEquals("Expected entry retained in map", "Four", result.itemFor(4));
			assertEquals("Expected entry retained in map", "Six", result.itemFor(6));
		}
		
		public function test_filterKeys_emptyResult() : void {
			const sourceMap : IMap = new LinkedMap();
			sourceMap.add(1, "One");
			sourceMap.add(2, "Two");
			
			const keyIsStringPredicate : Function = function(key : *) : Boolean {
				return key is String;
			};
			const result :IMap = Maps.filterKeys(sourceMap, keyIsStringPredicate);
			
			assertEquals("Resulting map is empty", 0, map.size);
			assertEquals("Resulting map is of the supplied type", getQualifiedClassName(sourceMap), getQualifiedClassName(result));
		}

		public function test_clone_returnsCopy() : void {
			map.add(1, 1);
			map.add(2, 1);

			var filter : Function = function(key : int) : Boolean {
				return (key % 2 == 0);
			};

			// no filter
			
			var clone : IMap = Maps.clone(map);
			assertTrue (map !== clone);

			// only key filter

			clone = Maps.clone(map, filter);
			assertTrue (map !== clone);

			// only item filter

			clone = Maps.clone(map, null, filter);
			assertTrue (map !== clone);

			// both filters

			clone = Maps.clone(map, filter, filter);
			assertTrue (map !== clone);
		}

		public function test_clone_filters() : void {
			map.add(1, 1);
			map.add(2, 1);
			map.add(3, 2);
			map.add(4, 2);
			map.add(5, 3);
			map.add(6, 3);
			map.add(7, 4);
			map.add(8, 4);
			map.add(9, 5);
			map.add(10, 5);
			map.add(11, 6);
			map.add(12, 6);
			
			var filter : Function = function(key : int) : Boolean {
				return (key % 2 == 0);
			};

			// no filter
			
			var clone : IMap = Maps.clone(map);
			assertEquals(12, clone.size);
			assertEquals(getQualifiedClassName(map), getQualifiedClassName(clone));
			assertTrue(CollectionTest.keysMatch(clone, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
			assertTrue(CollectionTest.itemsMatch(clone, [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]));

			// only key filter

			clone = Maps.clone(map, filter);
			assertEquals(6, clone.size);
			assertEquals(getQualifiedClassName(map), getQualifiedClassName(clone));
			assertTrue(CollectionTest.keysMatch(clone, [2, 4, 6, 8, 10, 12]));
			assertTrue(CollectionTest.itemsMatch(clone, [1, 2, 3, 4, 5, 6]));

			// only item filter

			clone = Maps.clone(map, null, filter);
			assertEquals(6, clone.size);
			assertEquals(getQualifiedClassName(map), getQualifiedClassName(clone));
			assertTrue(CollectionTest.keysMatch(clone, [3, 4, 7, 8, 11, 12]));
			assertTrue(CollectionTest.itemsMatch(clone, [2, 2, 4, 4, 6, 6]));

			// both filters

			clone = Maps.clone(map, filter, filter);
			assertEquals(3, clone.size);
			assertEquals(getQualifiedClassName(map), getQualifiedClassName(clone));
			assertTrue(CollectionTest.keysMatch(clone, [4, 8, 12]));
			assertTrue(CollectionTest.itemsMatch(clone, [2, 4, 6]));
		}
		
		public function test_fromDictionary() : void {
			const source : Dictionary = new Dictionary();
			source["key"] = "value";
			source[22] = "twenty two";
			
			const result : IMap = Maps.fromDictionary(source);
			
			assertEquals("Resulting Map contains 2 entries", 2, result.size);
			assertEquals("Expected entry in resulting Map", "value", result.itemFor("key"));
			assertEquals("Expected entry in resulting Map", "twenty two", result.itemFor(22));
		}
		
		public function test_fromDictionary_null() : void {
			const result : IMap = Maps.fromDictionary(null);
			assertEquals("Empty map returned", 0, result.size);
		}
		
		public function test_fromObject() : void {
			const source : Object = {};
			source["key"] = "value";
			source[22] = "twenty two";
			
			const result : IMap = Maps.fromObject(source);
			
			assertEquals("Resulting Map contains 2 entries", 2, result.size);
			assertEquals("Expected entry in resulting Map", "value", result.itemFor("key"));
			assertEquals("Expected entry in resulting Map", "twenty two", result.itemFor(22));
		}		
		
		public function test_fromObject_null() : void {
			const result : IMap = Maps.fromObject(null);
			assertEquals("Empty map returned", 0, result.size);
		}
		
		public function test_copy() : void {
			const source : IMap = MapBuilder.map()
				.add("key1", "item1")
				.add("key2", "item2")
				.build();
				
			const result : IMap = Maps.copy(source, new Map());
			
			assertEquals("Resulting Map has the expected number of entries", source.size, result.size);
			assertEquals("Expected entry exists in resulting Map", source.itemFor("key1"), result.itemFor("key1"));
			assertEquals("Expected entry exists in resulting Map", source.itemFor("key2"), result.itemFor("key2"));
		}
		
		public function test_copy_doesNotClearTargetMap() : void
		{
			const source : IMap = MapBuilder.map()
				.add("source-key", "source-item")
				.build();
				
			const target : IMap = MapBuilder.map()
				.add("original-key", "original-item")
				.build();
				
			Maps.copy(source, target);
			
			assertEquals("Resulting Map has the expected number of entries", 2, target.size);
			assertTrue("Target map retains its original mappings", target.hasKey("original-key"));
		}
	}
}

