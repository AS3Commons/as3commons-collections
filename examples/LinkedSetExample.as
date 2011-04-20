package {
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.framework.IOrderedMapIterator;
	import flash.display.Sprite;

	public class LinkedSetExample extends Sprite {

		public function LinkedSetExample() {
			var theSet : LinkedSet = new LinkedSet();
			
			// Add
			
			theSet.add(4);
			theSet.add(1);
			theSet.add(3);
			theSet.add(5);
			theSet.add(2);
			trace (theSet.toArray()); // 4,1,3,5,2
			
			theSet.addBefore(3, 6);
			theSet.addAfter(5, 7);
			trace (theSet.toArray()); // 4,1,6,3,5,7,2

			theSet.addFirst(8);
			theSet.addLast(9);
			trace (theSet.toArray()); // 8,4,1,6,3,5,7,2,9

			// Inspection
			
			trace (theSet.first); // 8
			trace (theSet.last); // 9
			
			// Iterator

			var iterator : IIterator = theSet.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is IMapIterator); // true
			trace (iterator is IOrderedMapIterator); // true
			
			while (iterator.hasNext()) {
				trace (iterator.next()); // 8,4,1,6,3,5,7,2,9
			}

			// Remove

			theSet.removeFirst();
			theSet.removeFirst();
			theSet.removeLast();
			theSet.removeLast();
			trace (theSet.toArray()); // 1,6,3,5,7
		}
	}
}
