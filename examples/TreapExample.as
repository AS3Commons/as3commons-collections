package {
	import org.as3commons.collections.Treap;
	import org.as3commons.collections.framework.IBinarySearchTreeIterator;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class TreapExample extends Sprite {

		public function TreapExample() {
			var treap : Treap = new Treap(new NumericComparator());
			
			// Add
			
			treap.add(3);
			treap.add(4);
			treap.add(1);
			treap.add(5);
			treap.add(2);
			treap.add(3); // no effect (equal item already contained)
			trace (treap.toArray()); // 1,2,3,4,5
			
			// Inspection
			
			trace (treap.first); // 1
			trace (treap.last); // 5

			trace (treap.hasEqual(3)); // true
			trace (treap.hasEqual(6)); // false
			trace (treap.equalItem(3)); // 3
			
			trace (treap.lesser(0)); // undefined
			trace (treap.lesser(1)); // undefined
			trace (treap.lesser(2)); // 1
			trace (treap.lesser(8)); // 5
			
			trace (treap.higher(-5)); // 1
			trace (treap.higher(2)); // 3
			trace (treap.higher(5)); // undefined
			trace (treap.higher(8)); // undefined
			
			// Iterator

			var iterator : IIterator = treap.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is IBinarySearchTreeIterator); // true
			
			while (iterator.hasNext()) {
				trace (iterator.next()); // 1,2,3,4,5
			}

			// Binary search tree iterator

			var bsti : IBinarySearchTreeIterator = treap.iterator() as IBinarySearchTreeIterator;
			trace (bsti.previousItem + " [" + bsti.current + "] " + bsti.nextItem);
			while (bsti.hasNext()) {
				bsti.next();
				trace (bsti.previousItem + " [" + bsti.current + "] " + bsti.nextItem);
			}

			// undefined [undefined] 1
			// 1 [1] 2
			// 2 [2] 3
			// 3 [3] 4
			// 4 [4] 5
			// 5 [5] undefined

			// Remove

			treap.removeFirst();
			treap.removeLast();
			trace (treap.toArray()); // 2,3,4
		}
	}
}
