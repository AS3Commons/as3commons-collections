package {
	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.framework.IOrderedMapIterator;
	import flash.display.Sprite;

	public class LinkedMapExample extends Sprite {

		public function LinkedMapExample() {
			var map : LinkedMap = new LinkedMap();
			
			// Add
			
			map.add(4, "four");
			map.add(1, "one");
			map.add(3, "three");
			map.add(5, "five");
			map.add(2, "two");
			trace (map.keysToArray()); // 4,1,3,5,2
			trace (map.toArray()); // four,one,three,five,two
			
			map.addBefore(3, 6, "six");
			map.addAfter(5, 7, "seven");
			trace (map.keysToArray()); // 4,1,6,3,5,7,2
			trace (map.toArray()); // four,one,six,three,five,seven,two

			map.addFirst(8, "eight");
			map.addLast(9, "nine");
			trace (map.keysToArray()); // 8,4,1,6,3,5,7,2,9
			trace (map.toArray()); // eight,four,one,six,three,five,seven,two,nine

			// Inspection
			
			trace (map.first); // eight
			trace (map.last); // nine
			
			// Iterator

			var iterator : IIterator = map.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is IMapIterator); // true
			trace (iterator is IOrderedMapIterator); // true
			
			while (iterator.hasNext()) {
				trace (iterator.next()); // eight,four,one,six,three,five,seven,two,nine
			}

			// Remove

			map.removeFirst();
			map.removeFirst();
			map.removeLast();
			map.removeLast();
			trace (map.keysToArray()); // 1,6,3,5,7
			trace (map.toArray()); // one,six,three,five,seven
		}
	}
}
