package {
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.utils.Maps;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class MapsCopyExample extends Sprite {
		public function MapsCopyExample() {
			// source
			var source : IMap = Maps.newLinkedMap(
				1, 1, 2, 1,
				3, 2, 4, 2 
			);
			dumpMap(source);
			//	1 => 1
			//	2 => 1
			//	3 => 2
			//	4 => 2
			
			// copy all
			var map : IMap = Maps.newSortedMap(
				new NumericComparator(),
				5, 3, 6, 3,
				7, 4, 8, 4
			);
			dumpMap(map);
			//	5 => 3
			//	6 => 3
			//	7 => 4
			//	8 => 4
			Maps.copy(source, map);
			dumpMap(map);
			//	1 => 1
			//	2 => 1
			//	3 => 2
			//	4 => 2
			//	5 => 3
			//	6 => 3
			//	7 => 4
			//	8 => 4

			// copy only even keys
			map = Maps.newSortedMap(
				new NumericComparator(),
				6, 3,
				8, 4
			);
			dumpMap(map);
			//	6 => 3
			//	8 => 4
			Maps.copy(source, map, evenFilter);
			dumpMap(map);
			//	2 => 1
			//	4 => 2
			//	6 => 3
			//	8 => 4

			// copy only even items
			map = Maps.newSortedMap(
				new NumericComparator(),
				7, 4, 8, 4
			);
			dumpMap(map);
			//	7 => 4
			//	8 => 4
			Maps.copy(source, map, null, evenFilter);
			dumpMap(map);
			//	3 => 2
			//	4 => 2
			//	7 => 4
			//	8 => 4

			// copy only even keys with even items
			map = Maps.newSortedMap(
				new NumericComparator(),
				8, 4
			);
			dumpMap(map);
			//	8 => 4
			Maps.copy(source, map, evenFilter, evenFilter);
			dumpMap(map);
			//	4 => 2
			//	8 => 4
		}
		
		private function evenFilter(item : *) : Boolean {
			return item % 2 == 0;
		}

		private function dumpMap(map : IMap) : void {
			var i : IMapIterator = map.iterator() as IMapIterator;
			while (i.next()) trace (i.key, "=>", i.current);
			trace();
		}

	}
}