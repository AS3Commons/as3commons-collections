package {
	import org.as3commons.collections.Set;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISetIterator;
	import flash.display.Sprite;

	public class SetExample extends Sprite {

		public function SetExample() {
			var theSet : Set = new Set();
			
			// Add
			
			theSet.add(1);
			theSet.add(2);
			theSet.add(3);
			theSet.add("4a");
			theSet.add("4b");
			theSet.add("4b"); // no effect (item already contained)
			
			trace (theSet.toArray()); // 4a,4b,1,2,3
			
			// Inspection
			
			trace (theSet.has(1)); // true;
			trace (theSet.has(4)); // false;
			
			// Iterator

			var iterator : IIterator = theSet.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is ISetIterator); // true

			while (iterator.hasNext()) {
				trace (iterator.next()); // 4a,4b,1,2,3
			}

			// Set iterator

			var si : ISetIterator = theSet.iterator() as ISetIterator;
			trace (si.previousItem + " [" + si.current + "] " + si.nextItem);
			while (si.hasNext()) {
				si.next();
				trace (si.previousItem + " [" + si.current + "] " + si.nextItem);
			}

			// undefined [undefined] 4b
			// 4b [4b] 4a
			// 4a [4a] 1
			// 1 [1] 2
			// 2 [2] 3
			// 3 [3] undefined

			// Remove
			
			theSet.remove(2);
			theSet.remove("4b");
			theSet.remove("4"); // no effect (item not contained)

			trace (theSet.toArray()); // 4a,1,3
		}
	}
}
