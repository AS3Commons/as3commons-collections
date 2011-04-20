package {
	import org.as3commons.collections.Map;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMapIterator;
	import flash.display.Sprite;

	public class MapExample extends Sprite {

		public function MapExample() {
			var map : Map = new Map();
			
			// Add
			
			map.add(1, "one");
			map.add(2, "two");
			map.add(3, "three");
			map.add("4a", "four");
			map.add("4b", "four");
			map.add("4c", "four");
			
			map.add("4c", "fourC"); // no effect (key already contained)
			
			trace (map.toArray()); // four,four,four,one,two,three
			
			// Replace

			map.replaceFor(3, "three3");
			map.replaceFor("4a", "fourA");
			
			map.replaceFor(1, "one"); // no effect ("one" === "one")
			map.replaceFor(4, "four"); // no effect (key not contained)
			
			trace (map.toArray()); // fourA,four,four,one,two,three3

			// Inspection
			
			trace (map.size); // 6
			trace (map.hasKey(3)); // true
			trace (map.hasKey(4)); // false
			trace (map.itemFor(3)); // three3
			trace (map.itemFor(4)); // undefined
			trace (map.keysToArray()); // 4a,4b,4c,1,2,3

			// Iterator

			var iterator : IIterator = map.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is IMapIterator); // true

			while (iterator.hasNext()) {
				trace (iterator.next()); // fourA,four,four,one,two,three3
			}

			// Map iterator

			var mi : IMapIterator = map.iterator() as IMapIterator;
			trace (mi.previousKey + " [" + mi.key + "=" + mi.current + "] " + mi.nextKey);
			while (mi.hasNext()) {
				mi.next();
				trace (mi.previousKey + " [" + mi.key + "=" + mi.current + "] " + mi.nextKey);
			}

			// undefined [undefined=undefined] 4a
			// 4a [4a=fourA] 4b
			// 4b [4b=four] 4c
			// 4c [4c=four] 1
			// 1 [1=one] 2
			// 2 [2=two] 3
			// 3 [3=three3] undefined
			
			// Remove

			map.removeKey(2);
			map.removeKey("4a");			
			map.removeKey(4); // no effect (key not contained)
			
			trace (map.toArray()); // four,four,one,three3

			map.remove("one");			
			map.remove("fourC"); // no effect (item not contained)
			
			trace (map.toArray()); // four,four,three3

			map.removeAll("four");			
			trace (map.toArray()); // three3
		}
	}
}
