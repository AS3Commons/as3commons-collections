package org.as3commons.collections.testhelpers {

	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.core.LinkedMapNode;
	import org.as3commons.collections.units.ITestOrder;
	import org.as3commons.collections.units.ITestSortOrder;
	import org.as3commons.collections.utils.ArrayUtils;

	/**
	 * @author Jens Struwe 15.04.2011
	 */
	public class CollectionTest {
		
		/*
		 * Collection items
		 */

		public static function itemsMatch(collection : ICollection, expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = collection.toArray();
			
			if (collection is ITestSortOrder) {
				ArrayUtils.mergeSort(expectedItems, new TestComparator());
				return ArrayUtils.arraysEqual(expectedItems, items);

			} else if (collection is ITestOrder) {
				return ArrayUtils.arraysEqual(expectedItems, items);

			} else {
				return ArrayUtils.arraysMatch(expectedItems, items);
			}
		}

		public static function itemsEqual(collection : ICollection, expectedItems : Array, items : Array = null) : Boolean {
			if (!items) items = collection.toArray();
			
			return ArrayUtils.arraysEqual(expectedItems, items);
		}

		/*
		 * Map keys
		 */

		public static function keysMatch(map : IMap, expectedKeys : Array, keys : Array = null) : Boolean {
			if (!keys) keys = map.keysToArray();
			
			if (map is ITestSortOrder) {
				expectedKeys = sortKeys(map, expectedKeys, map.toArray());
				return ArrayUtils.arraysEqual(expectedKeys, keys);

			} else if (map is ITestOrder) {
				return ArrayUtils.arraysEqual(expectedKeys, keys);

			} else {
				return ArrayUtils.arraysMatch(expectedKeys, keys);
			}
		}

		public static function keysEqual(map : IMap, expectedKeys : Array, keys : Array = null) : Boolean {
			if (!keys) keys = map.keysToArray();
			
			return ArrayUtils.arraysEqual(expectedKeys, keys);
		}
		
		/*
		 * Private
		 */

		private static function sortKeys(map : IMap, keys : Array, items : Array) : Array {
			var entries : Array = new Array();
			for (var i : int = 0; i < keys.length; i++) {
				entries.push(new LinkedMapNode(keys[i], map.itemFor(keys[i])));
			}
			ArrayUtils.mergeSort(entries, new MapEntryComparator());

			var sortedKeys : Array = new Array();
			for (i = 0; i < entries.length; i++) {
				sortedKeys.push(LinkedMapNode(entries[i]).key);
			}

			return sortedKeys;
		}
		
	}
}

import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.testhelpers.TestComparator;

internal class MapEntryComparator extends TestComparator {
	override public function compare(item1 : *, item2 : *) : int {
		return super.compare(LinkedMapNode(item1).item, LinkedMapNode(item2).item);
	}
}