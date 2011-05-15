package {
	import org.as3commons.collections.utils.NumericComparator;
	import flash.utils.getQualifiedClassName;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.utils.Maps;
	import flash.display.Sprite;

	public class MapsCloneExample extends Sprite {

		public function MapsCloneExample() {
			// clone simple map
			var map : IMap = Maps.newMap(
				"two", 2, "four", 4, "one", 1, "three", 3
			);
			var clone : IMap = Maps.clone(map);
			dumpMap(clone);
			trace (getQualifiedClassName(clone));
			//	three => 3
			//	four => 4
			//	one => 1
			//	two => 2
			//	org.as3commons.collections::Map
			
			// clone linked map
			map = Maps.newLinkedMap(
				"two", 2, "four", 4, "one", 1, "three", 3
			);
			clone = Maps.clone(map);
			dumpMap(clone);
			trace (getQualifiedClassName(clone));
			//	two => 2
			//	four => 4
			//	one => 1
			//	three => 3
			//	org.as3commons.collections::LinkedMap

			// clone sorted map
			map = Maps.newSortedMap(
				new NumericComparator(),
				"two", 2, "four", 4, "one", 1, "three", 3
			);
			clone = Maps.clone(map);
			dumpMap(clone);
			trace (getQualifiedClassName(clone));
			//	one => 1
			//	two => 2
			//	three => 3
			//	four => 4
			//	org.as3commons.collections::SortedMap
		}
		
		private function dumpMap(map : IMap) : void {
			var i : IMapIterator = map.iterator() as IMapIterator;
			while (i.next()) trace (i.key, "=>", i.current);
		}
	}
}